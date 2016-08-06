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

class IFDetailsController: UIViewController, WKNavigationDelegate, HeaderViewDelegate, ToolBarDelegate, UIScrollViewDelegate,
shareResuable{
    
    var shadowView: UIView?
    var shareView: ShareView?

    //MARK:-----life cycle-----
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.wkWebView)
        self.view.addSubview(self.toolBar)
        self.view.addSubview(self.headerBack)
        
        self.setupLayout()
        
        self.toolBar.commentButton.showIcon(model?.comments ?? nil)
        self.toolBar.praiseButton.setTitle(String(format:"点赞(%d)",(model?.like)!), forState: .Normal)
        self.wkWebView.loadRequest(NSURLRequest(URL: NSURL(string: (self.model?.link)!)!))
    }
    
    convenience init(model: CommonModel, naviTitle: String) {
        self.init()
        self.model = model
        self.naviTitle = naviTitle
        
        headerBack.title = naviTitle
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
        self.showShareView()
    }
    
    func commentButtonDidClick() {
        let ifDetailCommentVC = IFDetailCommentVC(id: "\(model?.ID)")
        self.navigationController?.pushViewController(ifDetailCommentVC, animated: true)
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
        shareToFriend((model?.excerpt)!,
                      shareImageUrl: (model?.image)!,
                           shareURL: (model?.link)!,
                         shareTitle: (model?.title)!)
    }
    
    func friendsCircleShareButtonDidClick() {
        shareToFriendsCircle((model?.excerpt)!,
                             shareTitle: (model?.title)!,
                               shareUrl: (model?.link)!,
                          shareImageUrl: (model?.image)!)
    }
    
    func shareMoreButtonDidClick() {
        hiddenShareView()
    }
    
    //MARK:-----Getter and Setter-----
    private var lastPosition: CGFloat = 0
    private var headerTopConstraint: Constraint? = nil
    private var model: CommonModel?
    private var naviTitle: String!
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
        let headerBack: HeaderBackView = HeaderBackView(title: "")
        headerBack.delegate = self
        return headerBack
    }()
}