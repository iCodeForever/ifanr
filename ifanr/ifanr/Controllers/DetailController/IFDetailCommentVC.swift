//
//  CommentsController.swift
//  ifanr
//
//  Created by dubinyuan on 16/8/5.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

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
    private func getData() {
        IFanrService.shareInstance.getCommentData(self.post_id, successHandel: { (modelArray) in
            
            // 添加数据
            modelArray.forEach {
                self.ifDetailCommentsModelArray.append($0)
            }
            self.tableView.reloadData()
            
        }) { (error) in
            print(error)
        }
    }
    
    private func setupLayout() {
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
    private lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: self.view.frame)
        tableView.dataSource = self
        tableView.delegate  = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(red: 250/255.0, green: 247/255.0, blue: 250/255.0, alpha: 1.0)
        return tableView
    }()
    
    private lazy var headerView: CommentHeaderView = {
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
                itemBtn.selected = false
            }
        }
    }
    
    func goBackButtonDidClick() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func timeSortedButtonDidClick(sender: UIButton) {
        if !sender.selected {
            resetBtnSelectState()
            
            self.ifDetailCommentsModelArray.sortInPlace({ (model1, model2) -> Bool in
                NSDate.isEarlier(model1.comment_date, dateStr2: model2.comment_date)
            })
            self.tableView.reloadData()
            
            sender.selected = true
        }
    }
    
    func heatSortedButtonDidClick(sender: UIButton) {
        if !sender.selected {
            resetBtnSelectState()
            
            self.ifDetailCommentsModelArray.sortInPlace({ (model1, model2) -> Bool in
                Int(model1.comment_rating_up) > Int(model2.comment_rating_up)
            })
            self.tableView.reloadData()
                
            sender.selected = true
        }
    }
}

extension IFDetailCommentVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ifDetailCommentsModelArray.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
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

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let model: CommentModel = self.ifDetailCommentsModelArray[indexPath.row]
        
        if model.comment_parent == "0" {
            return CommentTableViewCell.estimateCellHeight(model.comment_content,
                                                           font: UIFont.systemFontOfSize(13),
                                                           size: CGSizeMake(UIConstant.SCREEN_WIDTH-30, 2000))
        } else {
            return SmallCommentTableViewCell.estimateCellHeight(model.comment_content,
                                                                font: UIFont.systemFontOfSize(13),
                                                                size: CGSizeMake(UIConstant.SCREEN_WIDTH-60, 2000))
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
