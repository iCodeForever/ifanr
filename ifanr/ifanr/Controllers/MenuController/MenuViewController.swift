//
//  MenuViewController.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/1.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    //MARK: --------------------------- LifeCycle --------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(mainTableView)
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
    
    /// 背景图
    fileprivate lazy var backgroundImageView : UIImageView = {
        var backgroundImageView = UIImageView(frame: self.view.bounds)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = UIImage(named: "profile_background")
        return backgroundImageView
    }()
    
    /// tableview
    fileprivate lazy var mainTableView : UITableView = {
        var mainTabView : UITableView = UITableView(frame: self.view.bounds)
        mainTabView.backgroundColor = UIColor.clear
        let headerView = MenuHeaaderView(frame: CGRect(x: 0, y: 0, width: UIConstant.SCREEN_WIDTH, height: 100))
        headerView.delegate = self
        mainTabView.tableHeaderView = headerView
        mainTabView.separatorStyle = .none
        mainTabView.rowHeight   = 80
        mainTabView.sectionHeaderHeight = 100
        mainTabView.dataSource  = self
        mainTabView.delegate    = self
        return mainTabView
    }()
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuTabItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MenuTableViewCell.cellWithTableView(tableView)
        cell.model = MenuTabItems[indexPath.row]
        return cell
    }
}

extension MenuViewController: MenuHeaderViewDelegate {
    func searchBtnDidClick(_ headerView: MenuHeaaderView, searchBtn: UIButton) {
        
    }
    func settingBtnDidClick(_ headerView: MenuHeaaderView, settingBtn: UIButton) {
        self.navigationController?.pushViewController(SettingViewController(), animated: true)
    }
}
