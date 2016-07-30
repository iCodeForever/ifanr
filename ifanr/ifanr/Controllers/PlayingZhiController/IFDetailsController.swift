//
//  IFDetailsController.swift
//  ifanr
//
//  Created by sys on 16/7/17.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class IFDetailsController: UIViewController, WKNavigationDelegate, HeaderViewDelegate, ToolBarDelegate, ShareViewDelegate, UIScrollViewDelegate{

    //MARK:-----life cycle-----
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.wkWebView)
        self.view.addSubview(self.toolBar)
        self.view.addSubview(self.headerBack)
        
        self.setupLayout()
        
        self.toolBar.commentButton.showIcon(model?.commonModel.comments ?? nil)
        self.toolBar.praiseButton.setTitle(String(format:"点赞(%d)",(model?.commonModel.like)!), forState: .Normal)
        self.wkWebView.loadRequest(NSURLRequest(URL: NSURL(string: (self.model?.commonModel.link)!)!))
    }
    
    convenience init(model: HomePopularModel) {
        self.init()
        self.model = model
    }
    
    //MARK:-----Action-----
    func hiddenShareView() {
        UIView.animateWithDuration(0.3, animations: {
            self.shadowView.alpha = 0
            self.shareView.center.y += 170
            }) { (true) in
                self.shadowView.removeFromSuperview()
                self.shareView.removeFromSuperview()
        }
    }
   
    //MARK:-----Custom Function-----
    
    private func setupLayout() {
        self.wkWebView.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(self.view);
            make.bottom.equalTo(self.view)
        }
        
        self.toolBar.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(50)
        }
        
        self.headerBack.snp_makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            self.headerTopConstraint = make.top.equalTo(self.view).constraint
            make.height.equalTo(50)
        }
    }
    
    //MARK:-----WebView Delegate-----
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showProgress()
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        self.hiddenProgress()
    }
    
    //MARK:-----HeaderViewDelegate-----
    func backButtonDidClick() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK:-----ToolBarDelegate-----
    func editCommentDidClick() {
        debugPrint("editCommon")
    }
    
    func praiseButtonDidClick() {
        if self.toolBar.praiseButton.selected {
            self.toolBar.praiseButton.selected = false
        } else {
            self.toolBar.praiseButton.selected = true
        }
    }
    
    func shareButtonDidClick() {
        
        let window: UIWindow = UIApplication.sharedApplication().keyWindow!
        
        window.addSubview(self.shadowView)
        window.addSubview(self.shareView)
        
        UIView.animateWithDuration(0.3, animations: {
            self.shadowView.alpha = 0.5
            self.shareView.center.y -= 170
        })
    }
    
    func commentButtonDidClick() {
        hiddenShareView()
    }
    
    //MARK:-----UIScrollViewDelegate-----
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let currentPosition: CGFloat = scrollView.contentOffset.y
        if currentPosition - self.lastPosition > 30 && currentPosition > 0 {
            self.headerTopConstraint?.updateOffset(-50)
            
            UIView.animateWithDuration(0.3, animations: {
                self.headerBack.layoutIfNeeded()
            })
            
            self.lastPosition = currentPosition
            
        } else if self.lastPosition - currentPosition > 10 {
            
            self.headerTopConstraint?.updateOffset(0)
            UIView.animateWithDuration(0.3, animations: {
                self.headerBack.layoutIfNeeded()
            })
            self.lastPosition = currentPosition
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //MARK:-----ShareViewDelegate-----
    func weixinShareButtonDidClick() {
        ShareSDKUtil.shareToFriend((model?.commonModel.excerpt)!,
                                   shareImageUrl: (model?.commonModel.image)!,
                                   shareURL: (model?.commonModel.link)!,
                                   shareTitle: (model?.commonModel.title)!)
    }
    
    func friendsCircleShareButtonDidClick() {
        ShareSDKUtil.shareToFriendsCircle((model?.commonModel.excerpt)!,
                                          shareTitle: (model?.commonModel.title)!,
                                          shareUrl: (model?.commonModel.link)!,
                                          shareImageUrl: (model?.commonModel.image)!)
    }
    
    func shareMoreButtonDidClick() {
        
    }
    
    //MARK:-----Getter and Setter-----
    var lastPosition: CGFloat = 0
    var headerTopConstraint: Constraint? = nil
    var model: HomePopularModel? {
        didSet {
            self.toolBar.backgroundColor = UIColor.orangeColor()
        }
    }
    /// wkWebView
    private lazy var wkWebView: WKWebView = {
        let wkWebView: WKWebView = WKWebView()
        wkWebView.navigationDelegate    = self
        wkWebView.scrollView.delegate   = self
        return wkWebView
    }()
    /// 底部工具栏
    private lazy var toolBar: BottomToolsBar = {
        let toolBar: BottomToolsBar = BottomToolsBar()
        toolBar.delegate = self
        return toolBar
    }()
    /// 顶部返回栏
    private lazy var headerBack: HeaderBackView = {
        let headerBack: HeaderBackView = HeaderBackView(title: "玩物志")
        headerBack.delegate = self
        return headerBack
    }()
    /// 分享的view
    private lazy var shareView: ShareView = {
        let shareView = ShareView(frame: CGRect(x: 0, y: UIConstant.SCREEN_HEIGHT, width: UIConstant.SCREEN_WIDTH, height: UIConstant.SCREEN_HEIGHT))
        shareView.delegate = self
        
        return shareView
    }()
    /// mask
    private lazy var shadowView: UIView = {
        let shadowView = UIView(frame: self.view.frame)
        shadowView.alpha = 0
        shadowView.backgroundColor = UIColor.blackColor()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hiddenShareView))
        shadowView.addGestureRecognizer(tapGesture)
        
        return shadowView
    }()
}