//
//  NewsFlashControllerViewController.swift
//  ifanr
//
//  Created by sys on 16/6/30.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import Alamofire
class NewsFlashController: BasePageController {
    //MARK:-----life cycle-----
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        pullToRefresh.delegate = self
        
        tableView.sectionHeaderHeight = tableHeaderView.height
        tableView.tableHeaderView = tableHeaderView
        
        getData()
    }
    
    //MARK:-----custom function-----
    
    func getData(_ page: Int = 1) {
        isRefreshing = true
        
        let type: CommonModel? = CommonModel(dict: [:])
        IFanrService.shareInstance.getData(APIConstant.newsFlash_latest(page), t: type, keys: ["data"], successHandle: { (modelArray) in
        
            if page == 1 {
                self.page = 1
                self.newsFlashModelArray.removeAll()
            }
            // 添加数据
            modelArray.forEach {
                self.newsFlashModelArray.append($0)
            }
            self.page += 1
            self.isRefreshing = false
            self.tableView.reloadData()
            self.pullToRefresh.endRefresh()
        }) { (error) in
            print(error)
            
            self.pullToRefresh.endRefresh()
        }
        
//        IFanrService.shareInstance.getLatesModel(APIConstant.NewsFlash_latest(page), successHandle: { (modelArray) in
//            if page == 1 {
//                self.page = 1
//                self.newsFlashModelArray.removeAll()
//            }
//            // 添加数据
//            modelArray.forEach {
//                self.newsFlashModelArray.append($0)
//            }
//            self.page += 1
//            self.isRefreshing = false
//            self.tableView.reloadData()
//            self.pullToRefresh.endRefresh()
//        }) { (error) in
//            print(error)
//            
//            self.pullToRefresh.endRefresh()
//        }
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
     /// 这个属性放到ScrollViewControllerReusable协议， 会初始化两次。所以放到这里好了
    fileprivate lazy var tableHeaderView: UIView! = {
        return TableHeaderView(model: TableHeaderModelArray.first!)
    }()
    
    fileprivate var newsFlashModelArray = Array<CommonModel>()
}

// MARK: - 下拉刷新回调
extension NewsFlashController: PullToRefreshDelegate {
    func pullToRefreshViewDidRefresh(_ pulllToRefreshView: PullToRefreshView) {
        getData()
    }
}

// MARK: - 上拉加载更多
extension NewsFlashController {
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
extension NewsFlashController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NewsFlashTableViewCell.cellWithTableView(tableView)
        cell.model = self.newsFlashModelArray[indexPath.row]
        cell.layoutMargins = UIEdgeInsetsMake(0, 32, 0, 0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsFlashModelArray.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NewsFlashTableViewCell.estimateCellHeight(self.newsFlashModelArray[indexPath.row].title!) + 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = self.newsFlashModelArray[indexPath.row];
        let detailController: IFSafariController = IFSafariController(model: model)
//        self.navigationController?.pushViewController(detailController, animated: true)
        self.present(detailController, animated: true, completion: nil)
        
    }
}

