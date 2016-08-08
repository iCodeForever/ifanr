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
        self.view.backgroundColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.addSubview(tableView)
        self.view.addSubview(headerBack)
        setupLayout()
    }
    
    convenience init(headerModel: MindStoreModel) {
        self.init()
        self.headerModel = headerModel
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    //MARK: --------------------------- Private Methods --------------------------

    private func setupLayout() {
        headerBack.snp_makeConstraints { (make) in
            make.left.top.right.equalTo(self.view)
            make.height.equalTo(50)
        }
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
    private var headerModel: MindStoreModel!
    
    /// 顶部返回栏
    private lazy var headerBack: HeaderBackView = {
        let headerBack: HeaderBackView = HeaderBackView(title: "MindStore")
        headerBack.delegate = self
        return headerBack
    }()
    
    /// tableview
    private lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.separatorStyle = .None
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
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
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = MindStoreTableViewCell.cellWithTableView(tableView)
        cell.model = headerModel
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return MindStoreTableViewCell.estimateCellHeight(headerModel.title!, tagline: headerModel.tagline)
    }
}