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

    var dataSource : Array<NewsFlashModel> = Array()
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
        Alamofire.request(.GET, "https://www.ifanr.com/api/v3.0/?action=ifr_m_latest&appkey=sg5673g77yk72455af4sd55ea&excerpt_length=80&page=1&post_type=buzz&posts_per_page=12&sign=19eb476eb0c1fc74bee104316c626fd3&timestamp=1467296130", parameters: [:])
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
        
        
        /*
         // HAPPENING NOW
         let categoryLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
         categoryLabel.numberOfLines = 0
         categoryLabel.textAlignment = .Center
         categoryLabel.font = UIFont.boldSystemFontOfSize(12)
         
         let attrs = NSMutableAttributedString(string: "HAPPENING NOW")
         // 设置不同颜色
         attrs.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(10, 3))
         categoryLabel.attributedText = attrs
         // 获得合适高度
         let size = CGSizeMake(320,2000)
         let labelRect : CGRect = (categoryLabel.text)!.boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: nil , context: nil);
         categoryLabel.frame = CGRectMake(UIConstant.SCREEN_WIDTH/2.0 - labelRect.width/2.0 - 15,
         backgroundImageView.bottom + 50 - labelRect.height - 5,
         labelRect.width + 30,
         labelRect.height + 10)
         categoryLabel.layer.borderColor = UIColor.darkGrayColor().CGColor
         categoryLabel.layer.borderWidth = 1
         headerView.addSubview(categoryLabel)
         */
        
        let tagImageView = UIImageView(frame: CGRect(x: 0, y: backgroundImageView.bottom + 38, width: UIConstant.SCREEN_WIDTH, height: 25))
        if (self.tagImgName != "") {
            tagImageView.image = UIImage(imageLiteral: "tag_happeningnow")
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
        cell.model = self.dataSource[indexPath.row]
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
