//
//  MindStoreDetailController.swift
//  ifanr
//
//  Created by 梁亦明 on 16/8/6.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

class MindStoreDetailController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    /// 顶部返回栏
    private lazy var headerBack: HeaderBackView = {
        let headerBack: HeaderBackView = HeaderBackView(title: "")
        headerBack.delegate = self
        return headerBack
    }()
    
    /// tableview
    private lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.separatorStyle = .None
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
}

extension MindStoreDetailController: HeaderViewDelegate {
    func backButtonDidClick() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}

extension MindStoreDetailController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
    }
}