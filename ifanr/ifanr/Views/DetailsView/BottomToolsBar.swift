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
        
        self.backgroundColor = UIColor.white
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:-----Action-----
    @objc fileprivate func editCommentAction() {
        self.delegate?.editCommentDidClick()
    }
    
    @objc fileprivate func praiseButtonAction() {
        self.delegate?.praiseButtonDidClick()
    }
    
    @objc fileprivate func shareButtonAction() {
        self.delegate?.shareButtonDidClick()
    }
    
    @objc fileprivate func commentButtonAction() {
        self.delegate?.commentButtonDidClick()
    }
    
    //MARK:-----Getter Setter-----
    /// 红线
    fileprivate lazy var redlineView: UIView = {
        
        let redlineView: UIView     = UIView(frame: CGRect(x: 20, y: 12.5, width: 2, height: 25))
        redlineView.backgroundColor = UIColor.red
        return redlineView
    }()
    /// 编辑评论的框
    fileprivate lazy var editCommentTextField: UITextField = {
        let editCommentTextField: UITextField = UITextField(frame: CGRect(x: self.redlineView.x+12, y: 12.5, width: 100, height: 25))
        editCommentTextField.font = UIFont.customFont_FZLTZCHJW(fontSize: 12.0)
        editCommentTextField.placeholder = "您有什么看法呢?"
        editCommentTextField.textAlignment = .center
        editCommentTextField.contentVerticalAlignment = .center
        editCommentTextField.addTarget(self, action: #selector(editCommentAction), for: .touchUpInside)
        return editCommentTextField
    }()
    /// 点赞 button
    internal lazy var praiseButton: UIButton = {
        let praiseButton: UIButton = UIButton(frame: CGRect(x: UIConstant.SCREEN_WIDTH-155, y: 12.5, width: 50, height: 30))
        praiseButton.setImage(UIImage.init(named: "ic_comment_bar_like_false"), for: UIControlState())
        praiseButton.setImage(UIImage(named: "ic_comment_bar_like_true"), for: .selected)
        praiseButton.setTitle("点赞(11)", for: UIControlState())
        praiseButton.setTitleColor(UIColor.gray, for: UIControlState())
        praiseButton.titleLabel?.font = UIFont.customFont_FZLTXIHJW(fontSize: 9)
        praiseButton.imageView?.contentMode = .scaleAspectFit
        praiseButton.imageEdgeInsets = UIEdgeInsetsMake(-12, 16, 0, 16)
        praiseButton.titleEdgeInsets = UIEdgeInsetsMake(praiseButton.currentImage!.size.height-9, -praiseButton.currentImage!.size.width, 0, 0)
        praiseButton.addTarget(self, action: #selector(praiseButtonAction), for: .touchUpInside)
        return praiseButton
    }()
    /// 分享 button
    internal lazy var shareButton: UIButton = {
        let shareButton: UIButton = UIButton(frame: CGRect(x: UIConstant.SCREEN_WIDTH-95, y: 12.5, width: 30, height: 30))
        shareButton.setImage(UIImage(named: "ic_comment_bar_share"), for: UIControlState())
        shareButton.setTitle("分享", for: UIControlState())
        shareButton.setTitleColor(UIColor.gray, for: UIControlState())
        shareButton.imageView?.contentMode = .scaleAspectFit
        shareButton.titleLabel?.font = UIFont.customFont_FZLTXIHJW(fontSize: 9)
        shareButton.imageEdgeInsets = UIEdgeInsetsMake(-16, 7, 0, 7)
        shareButton.titleEdgeInsets = UIEdgeInsetsMake(shareButton.currentImage!.size.height-12.5, -shareButton.currentImage!.size.width, 0, 0)
        shareButton.addTarget(self, action: #selector(shareButtonAction), for: .touchUpInside)
        return shareButton
    }()
    /// 评论 button
    internal lazy var commentButton: UIButton = {
        let commentButton: UIButton = UIButton(frame: CGRect(x: UIConstant.SCREEN_WIDTH-45, y: 12.5, width: 30, height: 30))
        commentButton.setImage(UIImage(named: "ic_comment"), for: UIControlState())
        commentButton.setTitle("评论", for: UIControlState())
        commentButton.setTitleColor(UIColor.gray, for: UIControlState())
        commentButton.titleLabel?.font  = UIFont.customFont_FZLTXIHJW(fontSize: 9)
        commentButton.imageView?.contentMode = .scaleAspectFit
        commentButton.imageEdgeInsets = UIEdgeInsetsMake(-12, 6.5, 0, 6.5)
        commentButton.titleEdgeInsets = UIEdgeInsetsMake(commentButton.currentImage!.size.height-10, -commentButton.currentImage!.size.width, 0, 0)
        commentButton.addTarget(self, action: #selector(commentButtonAction), for: .touchUpInside)
        return commentButton
    }()
}
