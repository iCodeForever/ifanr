//
//  BasePageController.swift
//  ifanr
//
//  Created by sys on 16/7/4.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import Alamofire

class BasePageController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var backgroundImgName : String = ""
    var tagImgName : String = ""
    
    //MARK:-----life cycle-----
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加tableView
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.hamburgButton)
        
        self.setUpLayout()
    }
    
    //MARK:-----custom function-----
    /*!
     get data, need to ovrried
     */
    internal func getData() {
       
    }
    
    private func setUpLayout() {
        self.hamburgButton.snp_makeConstraints { (make) in
            make.right.equalTo(-15)
            make.top.equalTo(35)
            make.width.height.equalTo(45)
        }
    }
    
    //MARK:-----getter setter-----
    private lazy var hamburgButton : UIButton = {
        let hamburgButton = UIButton()
        hamburgButton.setImage(UIImage(imageLiteral:"ic_hamburg"), forState: .Normal)
        
        return hamburgButton
    }()
    
    internal lazy var tableView : UITableView = {
        let tableView = UITableView(frame: self.view.frame)
        tableView.delegate      = self;
        tableView.dataSource    = self;
        tableView.tableFooterView   = UIView()
        tableView.tableHeaderView   = self.headerView
        
        return tableView;
    }()
    
    /// headerView not need to override
    private lazy var headerView : UIView = {
        let headerView  = UIView(frame: CGRect(x: 0, y: 20, width: UIConstant.SCREEN_WIDTH, height:  220 * UIConstant.SCREEN_HEIGHT / UIConstant.IPHONE5_HEIGHT))
        
        let backgroundImageView   = UIImageView(frame: CGRectMake(0, 20, UIConstant.SCREEN_WIDTH, 120 * UIConstant.SCREEN_HEIGHT/UIConstant.IPHONE5_HEIGHT))
        backgroundImageView.contentMode     = .ScaleAspectFit
        if (self.backgroundImgName != "") {
            backgroundImageView.image = UIImage(imageLiteral: self.backgroundImgName)
        }
        headerView.addSubview(backgroundImageView)
        
        let titleLabel  = UILabel(frame: CGRect(x: 20, y: 30, width: 100, height: 40))
        titleLabel.text = "爱范快讯"
        titleLabel.font = UIFont.boldSystemFontOfSize(22)
        titleLabel.textColor = UIColor.whiteColor()
        headerView.addSubview(titleLabel)
        
        let detailTitleLabel    = UILabel(frame: CGRect(x: 20, y: titleLabel.bottom, width: 100, height: 30))
        detailTitleLabel.text   = "最新的咨询快报"
        detailTitleLabel.font   = UIConstant.UI_FONT_14
        detailTitleLabel.textColor = UIColor.whiteColor()
        headerView.addSubview(detailTitleLabel)
        
        let tagImageView = UIImageView(frame: CGRect(x: 0, y: backgroundImageView.bottom + 38, width: UIConstant.SCREEN_WIDTH, height: 25))
        if (self.tagImgName != "") {
            tagImageView.image = UIImage(imageLiteral: self.tagImgName)
        }
        tagImageView.contentMode = UIViewContentMode.ScaleAspectFit
        headerView.addSubview(tagImageView)
        
        return headerView
    }()
    
    //MARK:-----UITableViewDelegate UITableViewDataSource
    /*!
     need to override
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = NewsFlashTableViewCell.cellWithTableView(tableView)
        cell.layoutMargins = UIEdgeInsetsMake(0, 32, 0, 0)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 0
    }
    
    //MARK:-----hidden status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
