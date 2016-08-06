//
//  CommentHeaderView.swift
//  ifanr
//
//  Created by sys on 16/8/5.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

protocol CommentHeaderDelegate {
    func goBackButtonDidClick();
    func timeSortedButtonDidClick();
    func heatSortedButtonDidClick();
}

class CommentHeaderView: UIView {

    private var model: CommentModel?
    var delegate: CommentHeaderDelegate?
    
    convenience init(model: CommentModel?) {
        self.init()
        self.model = model
        
        self.topView.addSubview(self.goBackContainer)
        self.topView.addSubview(self.goBackButton)
        self.topView.addSubview(self.titleLabel)
        self.bottomView.addSubview(self.hintLabel)
        self.bottomView.addSubview(self.timeSortedButton)
        self.bottomView.addSubview(self.line)
        self.bottomView.addSubview(self.heatSortedButton)
        
        self.addSubview(self.topView)
        self.addSubview(self.bottomView)
        
        self.userInteractionEnabled = true
        self.timeSortedButton.selected = true
        
        self.setupLayout()
    }
    //MARK:-----Action-----
    @objc private func goBackButtonAction() {
        self.delegate?.goBackButtonDidClick()
    }
    @objc private func timeSortedButtonAction() {
        self.delegate?.timeSortedButtonDidClick()
    }
    @objc private func heatSortedButtonAction() {
        self.delegate?.heatSortedButtonDidClick()
    }
    
    //MARK:-----Private Function-----
    private func setupLayout() {
        self.topView.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(44)
        }
        self.bottomView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self.topView.snp_bottom)
            make.height.equalTo(30)
        }
        
        /// topView layout
        self.goBackContainer.snp_makeConstraints { (make) in
            make.top.bottom.left.equalTo(self)
            make.width.equalTo(44)
        }
        self.goBackButton.snp_makeConstraints { (make) in
            make.left.equalTo(self.topView).offset(15)
            make.top.equalTo(self.topView).offset(14.5)
            make.width.equalTo(17)
            make.height.equalTo(15)
        }
        self.titleLabel.snp_makeConstraints { (make) in
            make.centerX.centerY.equalTo(self.topView)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        /// bottomView layout
        self.hintLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.bottomView).offset(15)
            make.centerY.equalTo(self.bottomView)
        }
        self.timeSortedButton.snp_makeConstraints { (make) in
            make.left.equalTo(self.hintLabel.snp_right).offset(5)
            make.centerY.equalTo(self.bottomView)
            make.height.width.equalTo(40)
        }
        self.line.snp_makeConstraints { (make) in
            make.left.equalTo(self.timeSortedButton.snp_right).offset(3)
            make.top.equalTo(self.bottomView).offset(9)
            make.bottom.equalTo(self.bottomView).offset(-9)
            make.width.equalTo(1)
        }
        self.heatSortedButton.snp_makeConstraints { (make) in
            make.left.equalTo(self.line.snp_right).offset(3)
            make.centerY.equalTo(self.bottomView)
            make.height.width.equalTo(40)
        }
    }
    
    //MARK:-----Getter Setter-----
    /// topView
    private lazy var topView: UIView = {
        let topView: UIView = UIView()
        topView.backgroundColor = UIColor.blackColor()
        return topView
    }()
    
    /// goBackButton
    private lazy var goBackButton: UIButton = {
        let goBackButton: UIButton = UIButton()
        goBackButton.setImage(UIImage(named: "ic_back"), forState: .Normal)
        goBackButton.contentMode = .ScaleAspectFill
        return goBackButton
    }()
    /// goBackButton----
    private lazy var goBackContainer: UIButton = {
        let goBackContainer = UIButton()
        goBackContainer.addTarget(self, action: #selector(goBackButtonAction), forControlEvents: .TouchUpInside)
        return goBackContainer
    }()
    
    /// titleLabel
    private lazy var titleLabel: UILabel = {
        let titleLable: UILabel = UILabel()
        titleLable.text = "全部评论(0)"
        titleLable.font = UIFont.boldSystemFontOfSize(15)
        titleLable.textColor = UIColor.whiteColor()
        titleLable.textAlignment = .Center
        return titleLable
    }()
    
    /// bottomView
    private lazy var bottomView: UIView = {
        let bottomView: UIView = UIView()
        bottomView.backgroundColor = UIColor.whiteColor()
        return bottomView
    }()
    
    /// 排序方式
    private lazy var hintLabel: UILabel = {
        let hintLabel: UILabel = UILabel()
        hintLabel.text = "排序方式:"
        hintLabel.textColor = UIColor.lightGrayColor()
        hintLabel.font = UIFont.systemFontOfSize(14)
        return hintLabel
    }()
    
    /// 时间排序
    private lazy var timeSortedButton: UIButton = {
        let timeSortedButton: UIButton = UIButton()
        timeSortedButton.setTitle("时间", forState: .Normal)
        timeSortedButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        timeSortedButton.titleLabel?.textAlignment
        timeSortedButton.setTitleColor(UIColor.redColor(), forState: .Selected)
        timeSortedButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        timeSortedButton.addTarget(self, action: #selector(timeSortedButtonAction), forControlEvents: .TouchUpInside)
        return timeSortedButton
    }()
    
    private lazy var line: UIView = {
        let line: UIView = UIView()
        line.backgroundColor = UIColor.lightGrayColor()
        return line
    }()
    
    /// 热度排序
    private lazy var heatSortedButton: UIButton = {
        let heatSortedButton = UIButton()
        heatSortedButton.setTitle("热度", forState: .Normal)
        heatSortedButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        heatSortedButton.titleLabel?.textAlignment
        heatSortedButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        heatSortedButton.setTitleColor(UIColor.redColor(), forState: .Selected)
        heatSortedButton.addTarget(self, action: #selector(heatSortedButtonAction), forControlEvents: .TouchUpInside)
        return heatSortedButton
    }()
}
