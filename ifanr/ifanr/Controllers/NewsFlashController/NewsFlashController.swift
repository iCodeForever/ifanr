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
    
    var dataSource : Array<HomePopularModel> = Array()

    //MARK:-----life cycle-----
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        pullToRefresh.delegate = self
        self.tableView.sectionHeaderHeight = tableHeaderView.height
        self.tableView.tableHeaderView = tableHeaderView
        self.getData()
    }
    
    //MARK:-----custom function-----
    
    func getData() {
        Alamofire.request(.GET, "https://www.ifanr.com/api/v3.0/?action=ifr_m_latest&appkey=sg5673g77yk72455af4sd55ea&excerpt_length=80&page=1&post_type=buzz&posts_per_page=12&sign=19eb476eb0c1fc74bee104316c626fd3&timestamp=1467296130", parameters: [:])
            .responseJSON { response in
                
                if let dataAny = response.result.value {
                    
                    let dataDic : NSDictionary = (dataAny as? NSDictionary)!
                    if dataDic["data"] is NSArray {
                        let dataArr : NSArray = (dataDic["data"] as? NSArray)!
                        for item in dataArr {
                            self.dataSource.append(HomePopularModel(dict: item as! NSDictionary))
                        }
                    }
                    self.tableView.reloadData()
                }
        }
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
     /// 这个属性放到ScrollViewControllerReusable协议， 会初始化两次。所以放到这里好了
    private lazy var tableHeaderView: UIView! = {
        return TableHeaderView(model: TableHeaderModelArray.first!)
    }()
}

// MARK: - 下拉刷新回调
extension NewsFlashController: PullToRefreshDelegate {
    func pullToRefreshViewWillRefresh(pullToRefreshView: PullToRefreshView) {
        print("将要下拉")
    }
    
    func pullToRefreshViewDidRefresh(pulllToRefreshView: PullToRefreshView) {
//        return ({
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
//                NSThread.sleepForTimeInterval(2.0)
//                dispatch_async(dispatch_get_main_queue(), {
//                    pulllToRefreshView.endRefresh()
//                })
//            })
//        })
    }
}


// MARK: - tableView代理和数据源
extension NewsFlashController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = NewsFlashTableViewCell.cellWithTableView(tableView)
        cell.model = self.dataSource[indexPath.row]
        cell.layoutMargins = UIEdgeInsetsMake(0, 32, 0, 0)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return NewsFlashTableViewCell.estimateCellHeight(self.dataSource[indexPath.row].title!) + 30
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let urlStr: String = self.dataSource[indexPath.row].link
        let newsFlashDetailController: NewsFlashDetailController = NewsFlashDetailController(urlStr: urlStr)
        self.navigationController?.pushViewController(newsFlashDetailController, animated: true)
    }
}

