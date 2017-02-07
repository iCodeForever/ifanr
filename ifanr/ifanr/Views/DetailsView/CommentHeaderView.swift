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
    func timeSortedButtonDidClick(_ sender: UIButton);
    func heatSortedButtonDidClick(_ sender: UIButton);
}

class CommentHeaderView: UIView {

    fileprivate var model: CommentModel?
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
        
        self.isUserInteractionEnabled = true
        self.timeSortedButton.isSelected = true
        
        self.setupLayout()
    }
    //MARK:-----Action-----
    @objc fileprivate func goBackButtonAction() {
        self.delegate?.goBackButtonDidClick()
    }
    @objc fileprivate func timeSortedButtonAction(_ sender: UIButton) {
        self.delegate?.timeSortedButtonDidClick(sender)
    }
    @objc fileprivate func heatSortedButtonAction(_ sender: UIButton) {
        self.delegate?.heatSortedButtonDidClick(sender)
    }
    
    //MARK:-----Private Function-----
    fileprivate func setupLayout() {
        self.topView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(44)
        }
        self.bottomView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self.topView.snp.bottom)
            make.height.equalTo(40)
        }
        
        /// topView layout
        self.goBackContainer.snp.makeConstraints { (make) in
            make.top.bottom.left.equalTo(self)
            make.width.equalTo(44)
        }
        self.goBackButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.topView).offset(15)
            make.top.equalTo(self.topView).offset(14.5)
            make.width.equalTo(17)
            make.height.equalTo(15)
        }
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(self.topView)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        /// bottomView layout
        self.hintLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.bottomView).offset(15)
            make.centerY.equalTo(self.bottomView)
        }
        self.timeSortedButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.hintLabel.snp.right).offset(5)
            make.centerY.equalTo(self.bottomView)
            make.height.width.equalTo(40)
        }
        self.line.snp.makeConstraints { (make) in
            make.left.equalTo(self.timeSortedButton.snp.right).offset(3)
            make.top.equalTo(self.bottomView).offset(9)
            make.bottom.equalTo(self.bottomView).offset(-9)
            make.width.equalTo(1)
        }
        self.heatSortedButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.line.snp.right).offset(3)
            make.centerY.equalTo(self.bottomView)
            make.height.width.equalTo(40)
        }
    }
    
    //MARK:-----Getter Setter-----
    /// topView
    fileprivate lazy var topView: UIView = {
        let topView: UIView = UIView()
        topView.backgroundColor = UIColor.black
        return topView
    }()
    
    /// goBackButton
    fileprivate lazy var goBackButton: UIButton = {
        let goBackButton: UIButton = UIButton()
        goBackButton.setImage(UIImage(named: "ic_back"), for: UIControlState())
        goBackButton.addTarget(self, action: #selector(goBackButtonAction), for: .touchUpInside)
        goBackButton.contentMode = .scaleAspectFill
        return goBackButton
    }()
    /// goBackButton----
    fileprivate lazy var goBackContainer: UIButton = {
        let goBackContainer = UIButton()
        goBackContainer.addTarget(self, action: #selector(goBackButtonAction), for: .touchUpInside)
        return goBackContainer
    }()
    
    /// titleLabel
    fileprivate lazy var titleLabel: UILabel = {
        let titleLable: UILabel = UILabel()
        titleLable.text = "全部评论(0)"
        titleLable.font = UIFont.boldSystemFont(ofSize: 15)
        titleLable.textColor = UIColor.white
        titleLable.textAlignment = .center
        return titleLable
    }()
    
    /// bottomView
    lazy var bottomView: UIView = {
        let bottomView: UIView = UIView()
        bottomView.backgroundColor = UIColor.white
        return bottomView
    }()
    
    /// 排序方式
    fileprivate lazy var hintLabel: UILabel = {
        let hintLabel: UILabel = UILabel()
        hintLabel.text = "排序方式:"
        hintLabel.textColor = UIColor.lightGray
        hintLabel.font = UIFont.systemFont(ofSize: 14)
        return hintLabel
    }()
    
    /// 时间排序
    fileprivate lazy var timeSortedButton: UIButton = {
        let timeSortedButton: UIButton = UIButton()
        timeSortedButton.setTitle("时间", for: UIControlState())
        timeSortedButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        //timeSortedButton.titleLabel?.textAlignment
        timeSortedButton.setTitleColor(UIColor(red: 211/255.0, green: 55/255.0, blue: 38/255.0, alpha: 1.0), for: .selected)
        timeSortedButton.setTitleColor(UIColor.lightGray, for: UIControlState())
        timeSortedButton.addTarget(self, action: #selector(timeSortedButtonAction), for: .touchUpInside)
        return timeSortedButton
    }()
    
    fileprivate lazy var line: UIView = {
        let line: UIView = UIView()
        line.backgroundColor = UIColor.lightGray
        return line
    }()
    
    /// 热度排序
    fileprivate lazy var heatSortedButton: UIButton = {
        let heatSortedButton = UIButton()
        heatSortedButton.setTitle("热度", for: UIControlState())
        heatSortedButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        //heatSortedButton.titleLabel?.textAlignment
        heatSortedButton.setTitleColor(UIColor.lightGray, for: UIControlState())
        heatSortedButton.setTitleColor(UIColor(red: 211/255.0, green: 55/255.0, blue: 38/255.0, alpha: 1.0), for: .selected)
        heatSortedButton.addTarget(self, action: #selector(heatSortedButtonAction), for: .touchUpInside)
        return heatSortedButton
    }()
}
