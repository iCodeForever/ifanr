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
    func getData(_ page: Int = 1) {
        isRefreshing = true
        
        let type: CommonModel? = CommonModel(dict: [:])
        IFanrService.shareInstance.getData(APIConstant.newsFlash_latest(page), t: type, keys: ["data"], successHandle: { (modelArray) in
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
        
//        IFanrService.shareInstance.getLatesModel(APIConstant.PlayingZhi_latest(page), successHandle: { (modelArray) in
//            if page == 1 {
//                self.page = 1
//                self.playingZhiModelArray.removeAll()
//            }
//            // 添加数据
//            modelArray.forEach {
//                self.playingZhiModelArray.append($0)
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
    fileprivate lazy var tableHeaderView: UIView! = {
        return TableHeaderView(model: TableHeaderModelArray[1])
    }()
    
    var playingZhiModelArray : Array<CommonModel> = Array()

}

// MARK: - 下拉刷新回调
extension PlayingZhiController: PullToRefreshDelegate {
    func pullToRefreshViewDidRefresh(_ pulllToRefreshView: PullToRefreshView) {
        getData()
    }
}

// MARK: - 上拉加载更多
extension PlayingZhiController {
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
extension PlayingZhiController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell    = PlayingZhiTableViewCell.cellWithTableView(tableView)
        cell.model  = self.playingZhiModelArray[indexPath.row]
        cell.layoutMargins = UIEdgeInsetsMake(0, 32, 0, 0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playingZhiModelArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PlayingZhiTableViewCell.estimateCellHeight(self.playingZhiModelArray[indexPath.row].title!) + 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model: CommonModel = self.playingZhiModelArray[indexPath.row]
        let ifDetailsController = IFDetailsController(model: model, naviTitle: "玩物志")
        self.navigationController?.pushViewController(ifDetailsController, animated: true)
    }
}
