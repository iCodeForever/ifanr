//
//  CommentsController.swift
//  ifanr
//
//  Created by dubinyuan on 16/8/5.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

class IFDetailCommentVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView)
        
        getData()
    }
    
    //MARK:-----Private Function-----
    private func getData() {
        IFanrService.shareInstance.getCommentData(0, successHandel: { (modelArray) in
            
        }) { (error) in
            print(error)
        }
    }
    
    //MARK:-----UITableViewDataSource UITableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    //MARK:-----Getter Setter-----
    private lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: self.view.frame)
        tableView.dataSource = self
        tableView.delegate  = self
        return tableView
    }()
    
    private lazy var commentsArray: NSMutableArray = {
        let commentsArray = NSMutableArray()
        return commentsArray
    }()
}
