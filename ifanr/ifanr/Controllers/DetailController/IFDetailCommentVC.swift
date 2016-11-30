//
//  CommentsController.swift
//  ifanr
//
//  Created by dubinyuan on 16/8/5.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class IFDetailCommentVC: UIViewController {
    
    var ifDetailCommentsModelArray : Array<CommentModel> = Array()
    var post_id: String!
    
    convenience init(id: String!) {
        self.init()
        self.post_id = id
    }
    
    //MARK:-----Life Cycle-----
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.headerView)
        self.view.addSubview(self.tableView)
        
        self.setupLayout()
        getData()
    }
    
    //MARK:-----Private Function-----
    fileprivate func getData() {
        
        
        let type: CommentModel? = CommentModel(dict: [:])
        IFanrService.shareInstance.getData(APIConstant.comments_latest(self.post_id), t: type, keys: ["data", "all"], successHandle: { (modelArray) in
            // 添加数据
            modelArray.forEach {
                self.ifDetailCommentsModelArray.append($0)
            }
            self.tableView.reloadData()
            
        }) { (error) in
            print(error)
        }
        
//        IFanrService.shareInstance.getCommentData(self.post_id, successHandel: { (modelArray) in
//            
//            // 添加数据
//            modelArray.forEach {
//                self.ifDetailCommentsModelArray.append($0)
//            }
//            self.tableView.reloadData()
//            
//        }) { (error) in
//            print(error)
//        }
    }
    
    fileprivate func setupLayout() {
        self.headerView.snp_makeConstraints { (make) in
            make.left.top.right.equalTo(self.view)
            make.height.equalTo(84)
        }
        self.tableView.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(self.view)
            make.top.equalTo(self.headerView.snp_bottom)
        }
    }
    
    //MARK:-----Getter Setter-----
    fileprivate lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: self.view.frame)
        tableView.dataSource = self
        tableView.delegate  = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(red: 250/255.0, green: 247/255.0, blue: 250/255.0, alpha: 1.0)
        return tableView
    }()
    
    fileprivate lazy var headerView: CommentHeaderView = {
        let headerView = CommentHeaderView(model: nil)
        headerView.delegate = self
        return headerView
    }()
}

extension IFDetailCommentVC: CommentHeaderDelegate{
    
    // 将所有的 uibutton 置灰
    func resetBtnSelectState() {
        for item: AnyObject in self.headerView.bottomView.subviews {
            if item is UIButton {
                let itemBtn: UIButton = item as! UIButton
                itemBtn.isSelected = false
            }
        }
    }
    
    func goBackButtonDidClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func timeSortedButtonDidClick(_ sender: UIButton) {
        if !sender.isSelected {
            resetBtnSelectState()
            
            self.ifDetailCommentsModelArray.sort(by: { (model1, model2) -> Bool in
                Date.isEarlier(model1.comment_date, dateStr2: model2.comment_date)
            })
            self.tableView.reloadData()
            
            sender.isSelected = true
        }
    }
    
    func heatSortedButtonDidClick(_ sender: UIButton) {
        if !sender.isSelected {
            resetBtnSelectState()
            
            self.ifDetailCommentsModelArray.sort(by: { (model1, model2) -> Bool in
                Int(model1.comment_rating_up) > Int(model2.comment_rating_up)
            })
            self.tableView.reloadData()
                
            sender.isSelected = true
        }
    }
}

extension IFDetailCommentVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ifDetailCommentsModelArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model   = self.ifDetailCommentsModelArray[indexPath.row]
        
        if model.comment_parent == "0" {
            // 此时不是 "子评论"
            let cell = CommentTableViewCell.cellWithTableView(tableView)
            cell.layoutMargins = UIEdgeInsetsMake(0, 15, 0, 0)
            cell.model  = self.ifDetailCommentsModelArray[indexPath.row]
            
            return cell
            
        } else {
            // 此时是 "子评论"
            let cell = SmallCommentTableViewCell.cellWithTableView(tableView)
            cell.layoutMargins = UIEdgeInsetsMake(0, 45, 0, 0)
            cell.model  = self.ifDetailCommentsModelArray[indexPath.row]
            
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model: CommentModel = self.ifDetailCommentsModelArray[indexPath.row]
        
        if model.comment_parent == "0" {
            return CommentTableViewCell.estimateCellHeight(model.comment_content,
                                                           font: UIFont.systemFont(ofSize: 13),
                                                           size: CGSize(width: UIConstant.SCREEN_WIDTH-30, height: 2000))
        } else {
            return SmallCommentTableViewCell.estimateCellHeight(model.comment_content,
                                                                font: UIFont.systemFont(ofSize: 13),
                                                                size: CGSize(width: UIConstant.SCREEN_WIDTH-60, height: 2000))
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
