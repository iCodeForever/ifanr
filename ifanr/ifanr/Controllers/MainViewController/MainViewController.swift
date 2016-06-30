//
//  MainViewController.swift
//  ifanr
//
//  Created by 梁亦明 on 16/6/29.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

/**
 主界面
 */

import UIKit

class MainViewController: UIViewController {
    //MARK: --------------------------- LifeCycle --------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(mainTableView)
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
    
        /// 背景图
    private lazy var backgroundImageView : UIImageView = {
        var backgroundImageView = UIImageView(frame: self.view.bounds)
        backgroundImageView.contentMode = .ScaleAspectFill
        backgroundImageView.image = UIImage(named: "profile_background")
        return backgroundImageView
    }()
    
        /// tableview
    private lazy var mainTableView : UITableView = {
        var mainTabView : UITableView = UITableView(frame: self.view.bounds)
        mainTabView.backgroundColor = UIColor.clearColor()
        mainTabView.tableHeaderView = MainHeaderView(frame: CGRect(x: 0, y: 0, width: UIConstant.SCREEN_WIDTH, height: 100))
        mainTabView.separatorStyle = .None
        mainTabView.rowHeight = 80
        mainTabView.sectionHeaderHeight = 100
        mainTabView.dataSource = self
        mainTabView.delegate = self
        return mainTabView
    }()
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainTabItems.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = MainTableViewCell.cellWithTableView(tableView)
        cell.model = MainTabItems[indexPath.row]
        return cell
    }
}
