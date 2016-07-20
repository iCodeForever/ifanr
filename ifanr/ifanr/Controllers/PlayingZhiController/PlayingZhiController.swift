//
//  PlayingZhiController.swift
//  ifanr
//
//  Created by sys on 16/7/4.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import Alamofire

class PlayingZhiController: BasePageController {

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
    
    
    // 复写父类的方法 --- 获得获得
    func getData() {
        Alamofire.request(.GET, "https://www.ifanr.com/api/v3.0/?action=ifr_m_latest&appkey=sg5673g77yk72455af4sd55ea&excerpt_length=80&page=1&post_type=coolbuy&posts_per_page=12&sign=6e1a1b825a30456e4c68ac0a6e0a2aa7&timestamp=1467295944", parameters: [:])
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
        return TableHeaderView(model: TableHeaderModelArray[1])
    }()

}

// MARK: - 下拉刷新回调
extension PlayingZhiController: PullToRefreshDelegate {
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
extension PlayingZhiController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell    = PlayingZhiTableViewCell.cellWithTableView(tableView)
        cell.model  = self.dataSource[indexPath.row]
        cell.layoutMargins = UIEdgeInsetsMake(0, 32, 0, 0)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return PlayingZhiTableViewCell.estimateCellHeight(self.dataSource[indexPath.row].title!) + 20
    }
}
