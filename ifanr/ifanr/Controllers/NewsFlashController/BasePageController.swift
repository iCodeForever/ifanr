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

    var localDataSource = [String]()
    
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
     get data, need to ovrride
     */
    internal func getData() {
       
    }
    
    // get topImgName, not to ovrride
    private func getTopImgName() -> String? {
        if localDataSource.count == 4 {
            return localDataSource[0]
        }
        return nil
    }
    
    private func getTagImgName() -> String? {
        if localDataSource.count == 4 {
            return localDataSource[1]
        }
        return nil
    }
    
    private func getTitle() -> String? {
        if localDataSource.count == 4 {
            return localDataSource[2]
        }
        return nil
    }
    
    private func getDetailTitle() -> String? {
        if localDataSource.count == 4 {
            return localDataSource[3]
        }
        return nil
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
        backgroundImageView.image = UIImage(imageLiteral: self.getTopImgName()!)
        headerView.addSubview(backgroundImageView)
        
        let titleLabel  = UILabel(frame: CGRect(x: 20, y: 30, width: UIConstant.SCREEN_WIDTH, height: 40))
        titleLabel.text = self.getTitle()
        titleLabel.font = UIFont.boldSystemFontOfSize(22)
        titleLabel.textColor = UIColor.whiteColor()
        headerView.addSubview(titleLabel)
        
        let detailTitleLabel    = UILabel(frame: CGRect(x: 20, y: titleLabel.bottom, width: UIConstant.SCREEN_WIDTH, height: 30))
        detailTitleLabel.text   = self.getDetailTitle()
        detailTitleLabel.font   = UIConstant.UI_FONT_14
        detailTitleLabel.textColor = UIColor.whiteColor()
        headerView.addSubview(detailTitleLabel)
        
        let tagImageView = UIImageView(frame: CGRect(x: 0, y: backgroundImageView.bottom + 38, width: UIConstant.SCREEN_WIDTH, height: 25))
        tagImageView.image = UIImage(imageLiteral: self.getTagImgName()!)
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
