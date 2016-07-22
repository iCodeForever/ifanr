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
        
        self.backgroundColor = UIColor.whiteColor()
        self.userInteractionEnabled = true
        self.setupLayout()
        
        praiseButton.setVertical(3)
        shareButton.setVertical(3)
        commentButton.setVertical(3)
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
        praiseButton.setTitle("点赞", forState: .Normal)
        praiseButton.titleLabel?.font = UIFont.customFont_FZLTXIHJW(fontSize: 10)
        praiseButton.imageView?.contentMode = .ScaleAspectFit
        praiseButton.backgroundColor = UIColor.redColor()
        return praiseButton
    }()
    /// 分享 button
    private lazy var shareButton: UIButton = {
        let shareButton: UIButton = UIButton()
        shareButton.setImage(UIImage(imageLiteral: "ic_comment_bar_share"), forState: .Normal)
        shareButton.setTitle("分享", forState: .Normal)
        shareButton.imageView?.contentMode = .ScaleAspectFill
        shareButton.titleLabel?.font = UIFont.customFont_FZLTXIHJW(fontSize: 10)
        shareButton.backgroundColor = UIColor.greenColor()
        return shareButton
    }()
    
    /// 评论 button
    private lazy var commentButton: UIButton = {
        let commentButton: UIButton = UIButton()
        commentButton.setImage(UIImage(imageLiteral: "ic_comment"), forState: .Normal)
        commentButton.setTitle("评论", forState: .Normal)
        commentButton.titleLabel?.font  = UIFont.customFont_FZLTXIHJW(fontSize: 10)
        commentButton.imageView?.contentMode = .ScaleAspectFill
        commentButton.backgroundColor = UIColor.blueColor()
        return commentButton
    }()
    
    /// 编辑评论的框
    private lazy var editCommentTextField: UITextField = {
        let editCommentTextField: UITextField = UITextField()
        editCommentTextField.attributedPlaceholder = NSAttributedString(string: "您有什么看法呢?", attributes: [NSFontAttributeName: UIFont.customFont_FZLTXIHJW(fontSize: 12)] )
        editCommentTextField.textAlignment = .Center
        editCommentTextField.contentVerticalAlignment = .Center
        editCommentTextField.backgroundColor = UIColor.purpleColor()
        return editCommentTextField
    }()
    
    /// 红线
    private lazy var redlineView: UIView = {
        let redlineView: UIView = UIView()
        redlineView.backgroundColor = UIColor.redColor()
        return redlineView
    }()
    
    //MARK:-----Custom Function-----
    private func setupLayout() {
        self.redlineView.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.top.equalTo(self).offset(5)
            make.bottom.equalTo(self).offset(-10)
            make.width.equalTo(2)
        }
        
        self.editCommentTextField.snp_makeConstraints { (make) in
            make.left.equalTo(self.redlineView.snp_right).offset(5)
            make.centerY.equalTo(self)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        self.commentButton.snp_makeConstraints { (make) in
            make.right.equalTo(self).offset(-20)
            make.centerY.equalTo(self)
            make.width.equalTo(20)
            make.height.equalTo(43)
        }
        
        self.shareButton.snp_makeConstraints { (make) in
            make.right.equalTo(self.commentButton.snp_left).offset(-30)
            make.centerY.equalTo(self)
            make.width.equalTo(20)
            make.height.equalTo(43)
        }
        
        self.praiseButton.snp_makeConstraints { (make) in
            make.right.equalTo(self.shareButton.snp_left).offset(-30)
            make.centerY.equalTo(self)
            make.width.equalTo(20)
            make.height.equalTo(43)
        }
    }
}
