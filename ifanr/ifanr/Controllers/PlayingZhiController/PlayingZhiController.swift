//
//  PlayingZhiController.swift
//  ifanr
//
//  Created by sys on 16/7/4.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import Alamofire

class PlayingZhiController: BasePageController {

    //MARK:-----life cycle-----
    override func viewDidLoad() {
        
        //进行特定配置
        self.backgroundImgName  = "coolbuy_header_background"
        self.tagImgName         = "tag_coolbuy"
        
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .None
        
        self.getData()
    }
    
    
    // 复写父类的方法 --- 获得获得
    override func getData() {
        Alamofire.request(.GET, "https://www.ifanr.com/api/v3.0/?action=ifr_m_latest&appkey=sg5673g77yk72455af4sd55ea&excerpt_length=80&page=1&post_type=coolbuy&posts_per_page=12&sign=6e1a1b825a30456e4c68ac0a6e0a2aa7&timestamp=1467295944", parameters: [:])
            .responseJSON { response in
                
                if let dataAny = response.result.value {
                    
                    let dataDic : NSDictionary = (dataAny as? NSDictionary)!
                    if dataDic["data"] is NSArray {
                        let dataArr : NSArray = (dataDic["data"] as? NSArray)!
                        for item in dataArr {
                            self.dataSource.append(NewsFlashModel(dict: item as! NSDictionary))
                        }
                    }
                    self.tableView.reloadData()
                }
        }
    }
    
    // 复写父类的方法
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell    = PlayingZhiTableViewCell.cellWithTableView(tableView)
        cell.model  = self.dataSource[indexPath.row]
        cell.layoutMargins = UIEdgeInsetsMake(0, 32, 0, 0)
        
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return PlayingZhiTableViewCell.estimateCellHeight(self.dataSource[indexPath.row].title!) + 20
    }
}
