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
    func getData(_ page: Int = 0) {
        isRefreshing = true
        
        
        let type: MindStoreModel? = MindStoreModel(dict: [:])
        IFanrService.shareInstance.getData(APIConstant.mindStore_latest(page), t: type, keys: ["objects"], successHandle: { (modelArray) in
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
    func pullToRefreshViewDidRefresh(_ pulllToRefreshView: PullToRefreshView) {
        getData()
    }
}

// MARK: - 上拉加载更多
extension MindStoreViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell    = MindStoreTableViewCell.cellWithTableView(tableView)
        cell.model  = self.mindStoreModelArray[indexPath.row]
        
        cell.layoutMargins = UIEdgeInsetsMake(0, 65, 0, 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mindStoreModelArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MindStoreTableViewCell.estimateCellHeight(self.mindStoreModelArray[indexPath.row].title!, tagline: self.mindStoreModelArray[indexPath.row].tagline)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(MindStoreDetailController(headerModel: self.mindStoreModelArray[indexPath.row]), animated: true)
    }
}
