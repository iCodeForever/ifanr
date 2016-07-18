//
//  NewsFlashControllerViewController.swift
//  ifanr
//
//  Created by sys on 16/6/30.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import Alamofire
//class NewsFlashController: BasePageController {
class NewsFlashController: UIViewController, ScrollViewControllerReusable {
    
    var dataSource : Array<HomePopularModel> = Array()

    //MARK:-----life cycle-----
    
    override func viewDidLoad() {
        
//        self.localDataSource = ["buzz_header_background", "tag_happeningnow", "爱范科技", "最新的咨询快报"]
        
        super.viewDidLoad()
        
        setupTableView()
        setupPullToRefreshView()
        
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
    var tableView: UITableView!
    /// 下拉刷新
    var pullToRefresh: PullToRefreshView!
    /// 下拉刷新代理
    var scrollViewReusable: ScrollViewControllerReusableDataSource!
    var tableHeaderView: UIView! = {
        return TableHeaderView(model: TableHeaderModelArray.first!)
    }()
    
        /*
        // HAPPENING NOW
        let categoryLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        categoryLabel.numberOfLines = 0
        categoryLabel.textAlignment = .Center
        categoryLabel.font = UIFont.boldSystemFontOfSize(12)
        
        let attrs = NSMutableAttributedString(string: "HAPPENING NOW")
        // 设置不同颜色
        attrs.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(10, 3))
        categoryLabel.attributedText = attrs
        // 获得合适高度
        let size = CGSizeMake(320,2000)
        let labelRect : CGRect = (categoryLabel.text)!.boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: nil , context: nil);
        categoryLabel.frame = CGRectMake(UIConstant.SCREEN_WIDTH/2.0 - labelRect.width/2.0 - 15,
                                         backgroundImageView.bottom + 50 - labelRect.height - 5,
                                         labelRect.width + 30,
                                         labelRect.height + 10)
        categoryLabel.layer.borderColor = UIColor.darkGrayColor().CGColor
        categoryLabel.layer.borderWidth = 1
        headerView.addSubview(categoryLabel)
        */
 }

// MARK: - 下拉刷新回调
extension NewsFlashController {
    func pullToRefreshViewWillRefresh(pullToRefreshView: PullToRefreshView) {
        print("将要下拉")
    }
    
    func pullToRefreshViewDidRefresh(pulllToRefreshView: PullToRefreshView) -> Task {
        return ({
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
                NSThread.sleepForTimeInterval(2.0)
                dispatch_async(dispatch_get_main_queue(), {
                    pulllToRefreshView.endRefresh()
                })
            })
        })
    }
}


// MARK: - tableView代理和数据源
extension NewsFlashController {
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
}