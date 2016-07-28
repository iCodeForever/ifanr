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
    
    
    // 复写父类的方法 --- 获得获得
    func getData(page: Int = 1) {
        isRefreshing = true
        
        IFanrService.shareInstance.getLatesData(APIConstant.PlayingZhi_latest(page), successHandle: { (modelArray) in
            if page == 1 {
                self.page = 1
                self.playingZhiModelArray.removeAll()
            }
            // 添加数据
            modelArray.forEach {
                self.playingZhiModelArray.append($0)
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
        return TableHeaderView(model: TableHeaderModelArray[1])
    }()
    
    var playingZhiModelArray : Array<HomePopularModel> = Array()

}

// MARK: - 下拉刷新回调
extension PlayingZhiController: PullToRefreshDelegate {
    func pullToRefreshViewDidRefresh(pulllToRefreshView: PullToRefreshView) {
        getData()
    }
}

// MARK: - 上拉加载更多
extension PlayingZhiController {
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
extension PlayingZhiController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell    = PlayingZhiTableViewCell.cellWithTableView(tableView)
        cell.model  = self.playingZhiModelArray[indexPath.row]
        cell.layoutMargins = UIEdgeInsetsMake(0, 32, 0, 0)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playingZhiModelArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return PlayingZhiTableViewCell.estimateCellHeight(self.playingZhiModelArray[indexPath.row].commonModel.title!) + 20
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let ifDetailsController = IFDetailsController(model: self.playingZhiModelArray[indexPath.row])
        self.navigationController?.pushViewController(ifDetailsController, animated: true)
    }
}
