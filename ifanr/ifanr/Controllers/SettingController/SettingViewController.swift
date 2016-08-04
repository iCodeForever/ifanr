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
        
        view.addSubview(tableView)
    }
    
    /// tableview
    private lazy var tableView : UITableView = {
        var tableView : UITableView = UITableView()
        tableView.backgroundColor = UIColor.blackColor()
        tableView.separatorStyle = .None
        tableView.rowHeight   = 80
        tableView.sectionHeaderHeight = 100
        tableView.dataSource  = self
        tableView.delegate    = self
        return tableView
    }()
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}