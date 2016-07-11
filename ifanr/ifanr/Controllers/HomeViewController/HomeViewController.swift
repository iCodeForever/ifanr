//
//  HomeViewController.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/1.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import SnapKit
class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(tableView)
        
        IFanrService.shareInstance.getHomeHotData(0, posts_per_page: 5, successHandle: { [unowned self](modelArray) in
            self.headerView.modelArray = modelArray
            }, errorHandle: nil)
        
        IFanrService.shareInstance.getHomeLatestData(9, successHandle: { [unowned self](layoutArray) in
            self.latestCellLayout = layoutArray
            self.tableView.reloadData()
            }, errorHandle: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("home 内存警告")
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
    // 列表数据
    private var latestCellLayout = [HomePopularLayout]()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.origin = CGPoint.zero
        tableView.size = CGSize(width: self.view.width, height: self.view.height-UIConstant.UI_MARGIN_20)
        tableView.sectionHeaderHeight = self.view.width*0.625
        tableView.tableHeaderView = self.headerView
        tableView.separatorStyle = .None
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var headerView: HomeHeaderView = {
        // tag 高度 65
        return HomeHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: self.view.width*0.625+45))
    }()
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latestCellLayout.count
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let cellModel = latestCellLayout[indexPath.row].model
        
        if cellModel.post_type == PostType.dasheng {
            let cell = cell as! HomeLatestTextCell
            cell.popularLayout = latestCellLayout[indexPath.row]
        } else if cellModel.post_type == PostType.data {
            let cell = cell as! HomeLatestDataCell
            cell.popularLayout = latestCellLayout[indexPath.row]
        } else {
            let cell = cell as! HomeLatestImageCell
            cell.popularLayout = latestCellLayout[indexPath.row]
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellModel = latestCellLayout[indexPath.row].model
        var cell : UITableViewCell!
        if cellModel.post_type == PostType.dasheng {
            cell = HomeLatestTextCell.cellWithTableView(tableView)
        } else if cellModel.post_type == PostType.data {
            cell = HomeLatestDataCell.cellWithTableView(tableView)
        } else {
            cell = HomeLatestImageCell.cellWithTableView(tableView)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return latestCellLayout[indexPath.row].cellHeight
    }
}
