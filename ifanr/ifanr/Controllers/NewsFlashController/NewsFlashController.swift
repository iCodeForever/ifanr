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
    
    func getData(page: Int = 1) {
        isRefreshing = true
        
        IFanrService.shareInstance.getLatesData(APIConstant.NewsFlash_latest(page), successHandle: { (modelArray) in
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
        }
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
     /// 这个属性放到ScrollViewControllerReusable协议， 会初始化两次。所以放到这里好了
    private lazy var tableHeaderView: UIView! = {
        return TableHeaderView(model: TableHeaderModelArray.first!)
    }()
    
    private var newsFlashModelArray = Array<HomePopularModel>()
}

// MARK: - 下拉刷新回调
extension NewsFlashController: PullToRefreshDelegate {
    func pullToRefreshViewDidRefresh(pulllToRefreshView: PullToRefreshView) {
        getData()
    }
}

// MARK: - 上拉加载更多
extension NewsFlashController {
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
extension NewsFlashController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = NewsFlashTableViewCell.cellWithTableView(tableView)
        cell.model = self.newsFlashModelArray[indexPath.row]
        cell.layoutMargins = UIEdgeInsetsMake(0, 32, 0, 0)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsFlashModelArray.count
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return NewsFlashTableViewCell.estimateCellHeight(self.newsFlashModelArray[indexPath.row].title!) + 30
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let model: HomePopularModel = self.newsFlashModelArray[indexPath.row];
        var links: [String] = (model.content.getSuitableString("http(.*?)html"))
        if links.count == 0 {
            links = (model.content.getSuitableString("http(.*?)htm"))
        }
        if links.count != 0 {
            debugPrint("links[0] %@", links[0])
            let newsFlashDetailController: NewsFlashDetailController = NewsFlashDetailController(urlStr: links[0])
            self.navigationController?.pushViewController(newsFlashDetailController, animated: true)
        }
    }
}

