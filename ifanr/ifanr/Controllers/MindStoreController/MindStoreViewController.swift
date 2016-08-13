//
//  MindStoreViewController.swift
//  ifanr
//
//  Created by sys on 16/7/8.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import Alamofire

class MindStoreViewController: BasePageController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        pullToRefresh.delegate = self
        
        tableView.sectionHeaderHeight = tableHeaderView.height
        tableView.tableHeaderView = tableHeaderView
        
        getData()
    }
    
    //MARK: --------------------------- Private Methods --------------------------
    func getData(page: Int = 0) {
        isRefreshing = true
        
        
        let type: MindStoreModel? = MindStoreModel(dict: [:])
        IFanrService.shareInstance.getData(APIConstant.MindStore_latest(page), t: type, keys: ["objects"], successHandle: { (modelArray) in
             if page == 0 {
                self.page = 0
                self.mindStoreModelArray.removeAll()
            }
            // 添加数据
            modelArray.forEach {
                self.mindStoreModelArray.append($0)
            }
            self.page += 1
            self.isRefreshing = false
            self.tableView.reloadData()
            self.pullToRefresh.endRefresh()
        }) { (error) in
            print(error)
        }    
        
//        IFanrService.shareInstance.getMindStoreData(page, successHandle: { (modelArray) in
//            if page == 0 {
//                self.page = 0
//                self.mindStoreModelArray.removeAll()
//            }
//            // 添加数据
//            modelArray.forEach {
//                self.mindStoreModelArray.append($0)
//            }
//            self.page += 1
//            self.isRefreshing = false
//            self.tableView.reloadData()
//            self.pullToRefresh.endRefresh()
//        }) { (error) in
//            print(error)
//        }
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
    /// 这个属性放到ScrollViewControllerReusable协议， 会初始化两次。所以放到这里好了
    var tableHeaderView: UIView! = {
        return TableHeaderView(model: TableHeaderModelArray.last!)
    }()
    
    var mindStoreModelArray = Array<MindStoreModel>()
}

// MARK: - 下拉刷新回调
extension MindStoreViewController: PullToRefreshDelegate {
    func pullToRefreshViewDidRefresh(pulllToRefreshView: PullToRefreshView) {
        getData()
    }
}

// MARK: - 上拉加载更多
extension MindStoreViewController {
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        if differY < happenY {
            if !isRefreshing {
                // 这里处理上拉加载更多
                getData(page)
            }
        }
    }
}


// MARK: - tableView代理和数据源
extension MindStoreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell    = MindStoreTableViewCell.cellWithTableView(tableView)
        cell.model  = self.mindStoreModelArray[indexPath.row]
        
        cell.layoutMargins = UIEdgeInsetsMake(0, 65, 0, 0)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mindStoreModelArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return MindStoreTableViewCell.estimateCellHeight(self.mindStoreModelArray[indexPath.row].title!, tagline: self.mindStoreModelArray[indexPath.row].tagline)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.navigationController?.pushViewController(MindStoreDetailController(headerModel: self.mindStoreModelArray[indexPath.row]), animated: true)
    }
}
