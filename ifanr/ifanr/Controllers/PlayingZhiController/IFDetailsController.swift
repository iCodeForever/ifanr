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
        
        let window: UIWindow = UIApplication.sharedApplication().keyWindow!
        for item in window.subviews {
            if item.tag == 8888 {
                item.removeFromSuperview()
            }
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
        
        let shareView: ShareView = ShareView()
        shareView.delegate = self
        let window: UIWindow = UIApplication.sharedApplication().keyWindow!
        let shadowView   = UIView(frame: self.view.frame)
        shadowView.alpha = 0.5
        shadowView.backgroundColor = UIColor.blackColor()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hiddenShareView))
        shadowView.addGestureRecognizer(tapGesture)
        
        shareView.tag  = 8888
        shadowView.tag = 8888
        
        window.addSubview(shadowView)
        window.addSubview(shareView)
        
        shareView.snp_makeConstraints { (make) in
            make.bottom.equalTo(window)
            make.left.right.equalTo(window)
            make.height.equalTo(170)
        }
        
        shareView.layoutIfNeeded()
    }
    
    func commentButtonDidClick() {
        debugPrint("commonButton")
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
        ShareSDKUtil.shareToFriend()
    }
    
    func friendsCircleShareButtonDidClick() {
        ShareSDKUtil.shareToFriendsCircle()
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
    
    private lazy var wkWebView: WKWebView = {
        let wkWebView: WKWebView = WKWebView()
        wkWebView.navigationDelegate    = self
        wkWebView.scrollView.delegate   = self
        return wkWebView
    }()
    
    private lazy var toolBar: BottomToolsBar = {
        let toolBar: BottomToolsBar = BottomToolsBar()
        toolBar.delegate = self
        return toolBar
    }()
    
    private lazy var headerBack: HeaderBackView = {
        let headerBack: HeaderBackView = HeaderBackView(title: "玩物志")
        headerBack.delegate = self
        return headerBack
    }()
}