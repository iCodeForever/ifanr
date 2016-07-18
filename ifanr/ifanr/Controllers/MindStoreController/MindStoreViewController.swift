//
//  MindStoreViewController.swift
//  ifanr
//
//  Created by sys on 16/7/8.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import Alamofire

//class MindStoreViewController: BasePageController {
class MindStoreViewController: UIViewController, ScrollViewControllerReusable {

    var dataSource : Array<MindStoreModel> = Array()
    override func viewDidLoad() {
        
//        self.localDataSource = ["mind_store_header_background", "tag_appsolution", "MindStore", "在这里发现最好的产品和想法"]
        
        super.viewDidLoad()
        
        setupTableView()
        setupPullToRefreshView()
        
        self.getData()
//        self.view.userInteractionEnabled = true
    }
    
    func getData() {
        
        Alamofire.request(.GET, "https://sso.ifanr.com/api/v1.2/mind/?look_back_days=1&limit=60", parameters: [:])
            .responseJSON { response in
                
                if let dataAny = response.result.value {
                    
                    let dataDic : NSDictionary = (dataAny as? NSDictionary)!
                    if dataDic["objects"] is NSArray {
                        let dataArr : NSArray = (dataDic["objects"] as? NSArray)!
                        for item in dataArr {
                            self.dataSource.append(MindStoreModel(dict: item as! NSDictionary))
                        }
                    }
                    self.tableView.reloadData()
                }
        }
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
    var tableView: UITableView!
    /// 下拉刷新
    var pullToRefresh: PullToRefreshView!
    /// 下拉刷新代理
    var scrollViewReusable: ScrollViewControllerReusableDataSource!
    var tableHeaderView: UIView! = {
        return TableHeaderView(model: TableHeaderModelArray.last!)
    }()
    
    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.dataSource.count
//    }
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell    = MindStoreTableViewCell.cellWithTableView(tableView)
//        cell.model  = self.dataSource[indexPath.row]
//        
//        cell.layoutMargins = UIEdgeInsetsMake(0, 65, 0, 0)
//        
//        
//        return cell
//    }
//    
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return MindStoreTableViewCell.estimateCellHeight(self.dataSource[indexPath.row].title!, tagline: self.dataSource[indexPath.row].tagline) + 20
//    }

}

// MARK: - 下拉刷新回调
extension MindStoreViewController {
    func pullToRefreshViewWillRefresh(pullToRefreshView: PullToRefreshView) {
        print("将要下拉")
    }
    
    func pullToRefreshViewDidRefresh(pulllToRefreshView: PullToRefreshView) -> Task {
        return ({
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
                NSThread.sleepForTimeInterval(2.0)
                dispatch_async(dispatch_get_main_queue(), {
                    pulllToRefreshView.endRefresh()
                    print("完成下拉")
                })
            })
        })
    }
}


// MARK: - tableView代理和数据源
extension MindStoreViewController {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell    = MindStoreTableViewCell.cellWithTableView(tableView)
        cell.model  = self.dataSource[indexPath.row]
        
        cell.layoutMargins = UIEdgeInsetsMake(0, 65, 0, 0)
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return MindStoreTableViewCell.estimateCellHeight(self.dataSource[indexPath.row].title!, tagline: self.dataSource[indexPath.row].tagline) + 20
    }
}
