//
//  AppSoViewController.swift
//  ifanr
//
//  Created by sys on 16/7/7.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import Alamofire

class AppSoViewController: BasePageController {

    var dataSource : Array<AppSoModel> = Array()
    override func viewDidLoad() {
        
        self.localDataSource = ["appso_header_background", "tag_appsolution", "AppSolution", "智能手机更好用的秘密"]
        
        super.viewDidLoad()
        
        self.getData()
        self.tableView.separatorStyle = .None
    }
    
    
    override func getData() {
        Alamofire.request(.GET, "https://www.ifanr.com/api/v3.0/?action=ifr_m_latest&appkey=sg5673g77yk72455af4sd55ea&excerpt_length=80&page=1&post_type=coolbuy&posts_per_page=12&sign=6e1a1b825a30456e4c68ac0a6e0a2aa7&timestamp=1467295944", parameters: [:])
            .responseJSON { response in
                
                if let dataAny = response.result.value {
                    
                    let dataDic : NSDictionary = (dataAny as? NSDictionary)!
                    if dataDic["data"] is NSArray {
                        let dataArr : NSArray = (dataDic["data"] as? NSArray)!
                        for item in dataArr {
                            self.dataSource.append(AppSoModel(dict: item as! NSDictionary))
                        }
                    }
                    self.tableView.reloadData()
                }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell    = AppSoTableViewCell.cellWithTableView(tableView)
        cell.model  = self.dataSource[indexPath.row]
        
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return AppSoTableViewCell.estimateCellHeight(self.dataSource[indexPath.row].title!) + 20
    }
}
