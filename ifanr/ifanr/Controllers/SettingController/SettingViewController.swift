//
//  SettingViewController.swift
//  ifanr
//
//  Created by 梁亦明 on 16/8/4.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.blackColor()
        
        let headerView = SettingHeaderView(frame: CGRect(x: 0, y: UIConstant.UI_MARGIN_20, width: self.view.width, height: 44))
        headerView.backBtnDidClick { [unowned self] in
            self.navigationController!.popViewControllerAnimated(true)
            
        }
        view.addSubview(headerView)
        view.addSubview(tableView)
        
        tableView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(self.view.height-UIConstant.UI_NAV_HEIGHT)
        }
    }
    
    /// tableview
    private lazy var tableView : UITableView = {
        var tableView : UITableView = UITableView()
        tableView.backgroundColor = UIColor.blackColor()
        tableView.separatorStyle = .None
        tableView.sectionHeaderHeight = UIConstant.UI_NAV_HEIGHT
        tableView.dataSource  = self
        tableView.delegate    = self
        return tableView
    }()
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let model = SettingModelArray[indexPath.row]
        let cell = SettingViewCell(cellType: model.type)
        cell.model = model
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50
        }
        return 70
    }
}