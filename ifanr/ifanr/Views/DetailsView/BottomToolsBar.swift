//
//  bottomToolsBar.swift
//  ifanr
//
//  Created by sys on 16/7/17.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

protocol ToolBarDelegate {
    func praiseButtonDidClick()
    func shareButtonDidClick()
    func commentButtonDidClick()
}

class BottomToolsBar: UIView {

    var delegate: ToolBarDelegate?
    //MARK:-----Life Cycle-----
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.addSubview(self.praiseButton)
        self.addSubview(self.shareButton)
        self.addSubview(self.commentButton)
        self.addSubview(self.editCommentTextField)
        self.addSubview(self.redlineView)
        
        self.setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:-----Getter and Setter-----
    /// 点赞 button
    private lazy var praiseButton: UIButton = {
        let praiseButton: UIButton = UIButton()
        praiseButton.setImage(UIImage(imageLiteral: "ic_comment_bar_like_false"), forState: .Normal)
        praiseButton.setImage(UIImage(imageLiteral: "ic_comment_bar_like_true"), forState: .Selected)
        return praiseButton
    }()
    /// 分享 button
    private lazy var shareButton: UIButton = {
        let shareButton: UIButton = UIButton()
        shareButton.setImage(UIImage(imageLiteral: "ic_comment_bar_share"), forState: .Normal)
        return shareButton
    }()
    
    /// 评论 button
    private lazy var commentButton: UIButton = {
        let commentButton: UIButton = UIButton()
        commentButton.setImage(UIImage(imageLiteral: "ic_comment"), forState: .Normal)
        return commentButton
    }()
    
    /// 编辑评论的框
    private lazy var editCommentTextField: UITextField = {
        let editCommentTextField: UITextField = UITextField()
        editCommentTextField.placeholder = "您有什么看法呢"
        return editCommentTextField
    }()
    
    /// 红线
    private lazy var redlineView: UIView = {
        let redlineView: UIView = UIView()
        return redlineView
    }()
    
    //MARK:-----Custom Function-----
    private func setupLayout() {
        self.redlineView.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.top.bottom.equalTo(self).offset(10)
            make.width.equalTo(5)
        }
        
        self.editCommentTextField.snp_makeConstraints { (make) in
            make.left.equalTo(self.redlineView.snp_right).offset(5)
            make.centerY.equalTo(self)
            make.width.equalTo(100)
        }
        
        self.commentButton.snp_makeConstraints { (make) in
            make.right.equalTo(self).offset(20)
            make.centerY.equalTo(self)
            make.width.equalTo(30)
        }
        
        self.shareButton.snp_makeConstraints { (make) in
            make.right.equalTo(self.commentButton.snp_left).offset(30)
            make.centerY.equalTo(self)
            make.width.equalTo(30)
        }
        
        self.praiseButton.snp_makeConstraints { (make) in
            make.right.equalTo(self.shareButton.snp_left).offset(30)
            make.centerY.equalTo(self)
            make.width.equalTo(30)
        }
    }
}
