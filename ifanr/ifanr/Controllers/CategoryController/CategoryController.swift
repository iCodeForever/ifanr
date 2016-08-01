//
//  CategoryController.swift
//  ifanr
//
//  Created by 梁亦明 on 16/8/1.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

class CategoryController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
    }
    convenience init(categoryModel: CategoryModel) {
        self.init()

        self.view.addSubview(tableView)
        self.view.addSubview(backBtn)
        
        self.categoryModel = categoryModel
        headerView.model = categoryModel
        
        backBtn.snp_makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view).offset(UIConstant.UI_MARGIN_20)
            make.size.equalTo(CGSize(width: 50, height: 20))
        }
        
        getData()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
    private var categoryModel: CategoryModel!
    private var page = 1
    private var isRefreshing: Bool = false
    /// 上拉加载更多触发零界点
    var happenY: CGFloat = UIConstant.SCREEN_HEIGHT+20
    var differY: CGFloat = 0
    private var latestCellLayout = Array<HomePopularLayout>()
    
    private lazy var backBtn: UIButton = {
        var backBtn = UIButton()
        backBtn.setImage(UIImage(named: "ic_back"), forState: .Normal)
        backBtn.addTarget(self, action: #selector(CategoryController.backBtnDidClick), forControlEvents: .TouchUpInside)
        backBtn.imageView?.contentMode = .ScaleAspectFit
        return backBtn
    }()
    
    private lazy var headerView: CategoryListHeaderView = {
        // 1440:944
        var headerView = CategoryListHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 200*UIConstant.SCREEN_WIDTH / UIConstant.IPHONE5_HEIGHT))
        return headerView
    }()
    
    private lazy var tableView: UITableView = {
//        let tableView=  UITableView(frame: self.view.bounds, style: .Plain)
        let tableView = UITableView(frame: self.view.bounds)
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.separatorStyle = .None
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = self.headerView
        tableView.sectionHeaderHeight = 200*UIConstant.SCREEN_WIDTH / UIConstant.IPHONE5_HEIGHT
        tableView.sectionFooterHeight = 50
        tableView.tableFooterView = self.pullToRefreshFootView()
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
}
//MARK: --------------------------- Private Methods --------------------------
extension CategoryController {
    private func pullToRefreshFootView() -> UIView {
        
        let activityView = ActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 25, height: 25) )
        activityView.color = UIConstant.UI_COLOR_GrayTheme
        activityView.center = CGPoint(x: self.view.center.x, y: 25)
        activityView.startAnimation()
        
        let footView = UIView()
        footView.origin = CGPointZero
        footView.size = CGSize(width: 50, height: 50)
        footView.addSubview(activityView)
        return footView
    }
    
    private func getData(page: Int = 1) {
        isRefreshing = true
        IFanrService.shareInstance.getLatestLayout(APIConstant.Category(categoryModel.type!, page), successHandle: { [weak self](layoutArray) in
            if self == nil {
                return
            }
            
            if page == 1 {
                self!.page = 1
                self!.latestCellLayout.removeAll()
            }
            
            layoutArray.forEach {
                self!.latestCellLayout.append($0)
            }
            self!.page += 1
            self!.isRefreshing = false
            self!.tableView.reloadData()
            }) { (error) in
                print(error)
        }
    }
}

//MARK: --------------------------- Event and Action --------------------------
extension CategoryController {
    @objc private func backBtnDidClick() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}

//MARK: --------------------------- PullToRefresh --------------------------
extension CategoryController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // 计算contentsize与offset的差值
        let contentSizeY = scrollView.contentSize.height
        let contentOffsetY = scrollView.contentOffset.y
        
        differY = contentSizeY-contentOffsetY
        
        if differY < happenY {
            if !isRefreshing {
                // 这里处理上拉加载更多
                getData(page)
            }
        }
    }
}

//MARK: --------------------------- UITableViewDelegate, UITableViewDataSource --------------------------
extension CategoryController: UITableViewDelegate, UITableViewDataSource {
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