//
//  bottomToolsBar.swift
//  ifanr
//
//  Created by sys on 16/7/17.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

protocol ToolBarDelegate {
    func editCommentDidClick()
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:-----Action-----
    @objc private func editCommentAction() {
        self.delegate?.editCommentDidClick()
    }
    
    @objc private func praiseButtonAction() {
        self.delegate?.praiseButtonDidClick()
    }
    
    @objc private func shareButtonAction() {
        self.delegate?.shareButtonDidClick()
    }
    
    @objc private func commentButtonAction() {
        self.delegate?.commentButtonDidClick()
    }
    
    //MARK:-----Getter Setter-----
    /// 红线
    private lazy var redlineView: UIView = {
        
        let redlineView: UIView     = UIView(frame: CGRectMake(20, 12.5, 2, 25))
        redlineView.backgroundColor = UIColor.redColor()
        return redlineView
    }()
    /// 编辑评论的框
    private lazy var editCommentTextField: UITextField = {
        let editCommentTextField: UITextField = UITextField(frame: CGRectMake(self.redlineView.x+12, 12.5, 100, 25))
        editCommentTextField.font = UIFont.customFont_FZLTZCHJW(fontSize: 12.0)
        editCommentTextField.placeholder = "您有什么看法呢?"
        editCommentTextField.textAlignment = .Center
        editCommentTextField.contentVerticalAlignment = .Center
        editCommentTextField.addTarget(self, action: #selector(editCommentAction), forControlEvents: .TouchUpInside)
        return editCommentTextField
    }()
    /// 点赞 button
    internal lazy var praiseButton: UIButton = {
        let praiseButton: UIButton = UIButton(frame: CGRectMake(UIConstant.SCREEN_WIDTH-155, 12.5, 50, 30))
        praiseButton.setImage(UIImage(imageLiteral: "ic_comment_bar_like_false"), forState: .Normal)
        praiseButton.setImage(UIImage(imageLiteral: "ic_comment_bar_like_true"), forState: .Selected)
        praiseButton.setTitle("点赞(11)", forState: .Normal)
        praiseButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
        praiseButton.titleLabel?.font = UIFont.customFont_FZLTXIHJW(fontSize: 9)
        praiseButton.imageView?.contentMode = .ScaleAspectFit
        praiseButton.imageEdgeInsets = UIEdgeInsetsMake(-12, 16, 0, 16)
        praiseButton.titleEdgeInsets = UIEdgeInsetsMake(praiseButton.currentImage!.size.height-9, -praiseButton.currentImage!.size.width, 0, 0)
        praiseButton.addTarget(self, action: #selector(praiseButtonAction), forControlEvents: .TouchUpInside)
        return praiseButton
    }()
    /// 分享 button
    internal lazy var shareButton: UIButton = {
        let shareButton: UIButton = UIButton(frame: CGRectMake(UIConstant.SCREEN_WIDTH-95, 12.5, 30, 30))
        shareButton.setImage(UIImage(imageLiteral: "ic_comment_bar_share"), forState: .Normal)
        shareButton.setTitle("分享", forState: .Normal)
        shareButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
        shareButton.imageView?.contentMode = .ScaleAspectFit
        shareButton.titleLabel?.font = UIFont.customFont_FZLTXIHJW(fontSize: 9)
        shareButton.imageEdgeInsets = UIEdgeInsetsMake(-16, 7, 0, 7)
        shareButton.titleEdgeInsets = UIEdgeInsetsMake(shareButton.currentImage!.size.height-12.5, -shareButton.currentImage!.size.width, 0, 0)
        shareButton.addTarget(self, action: #selector(shareButtonAction), forControlEvents: .TouchUpInside)
        return shareButton
    }()
    /// 评论 button
    internal lazy var commentButton: UIButton = {
        let commentButton: UIButton = UIButton(frame: CGRectMake(UIConstant.SCREEN_WIDTH-45, 12.5, 30, 30))
        commentButton.setImage(UIImage(imageLiteral: "ic_comment"), forState: .Normal)
        commentButton.setTitle("评论", forState: .Normal)
        commentButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
        commentButton.titleLabel?.font  = UIFont.customFont_FZLTXIHJW(fontSize: 9)
        commentButton.imageView?.contentMode = .ScaleAspectFit
        commentButton.imageEdgeInsets = UIEdgeInsetsMake(-12, 6.5, 0, 6.5)
        commentButton.titleEdgeInsets = UIEdgeInsetsMake(commentButton.currentImage!.size.height-10, -commentButton.currentImage!.size.width, 0, 0)
        commentButton.addTarget(self, action: #selector(commentButtonAction), forControlEvents: .TouchUpInside)
        return commentButton
    }()
}
