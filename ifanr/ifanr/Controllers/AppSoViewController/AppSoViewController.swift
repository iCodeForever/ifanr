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
        Alamofire.request(.GET, "https://www.ifanr.com/api/v3.0/?action=ifr_m_latest&appkey=sg5673g77yk72455af4sd55ea&excerpt_length=80&page=2&post_type=app&posts_per_page=12&sign=52eb3928dc47f57a26b00932226eff22&timestamp=1467295827", parameters: [:])
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
        
        var cell: UITableViewCell? = nil
        let curModel = self.dataSource[indexPath.row];
        
        debugPrint(curModel.app_icon_url)
        
        if curModel.app_icon_url != "" {
            cell    = AppSoTableViewCell.cellWithTableView(tableView)
            (cell as! AppSoTableViewCell).model = curModel
        } else {
            cell    = PlayingZhiTableViewCell.cellWithTableView(tableView)
            (cell as! PlayingZhiTableViewCell).appSoModel = curModel
        }
        
        return cell!
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return AppSoTableViewCell.estimateCellHeight(self.dataSource[indexPath.row].title!) + 20
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let ifDetailController = IFDetailsController(model: self.dataSource[indexPath.row])
//        self.navigationController?.pushViewController(ifDetailController, animated: true)
    }
}
