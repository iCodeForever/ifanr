//
//  NewsFlashDetailController.swift
//  ifanr
//
//  Created by sys on 16/7/17.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import WebKit

class NewsFlashDetailController: UIViewController {

    //MARK:-----Variables-----
    var shadowView: UIView?
    var shareView: ShareView?
    var urlStr: String?
    
    private var model: CommonModel?
    
    convenience init(model: CommonModel){
        self.init()
        self.model = model
    }
    
    //MARK:-----Life Cycle-----
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.wkWebView)
        self.view.addSubview(self.bottomBar)
        
        self.setupLayout()
        self.bottomBarSetUpLayout()
        
        self.loadData()
    }
    
    //MARK:-----Custom Function------
    // get data
    func loadData() {
        var links: [String] = (model!.content.getSuitableString("http(.*?)html"))
        if links.count == 0 {
            links = (model!.content.getSuitableString("http(.*?)htm"))
        }
        if links.count != 0 {
            urlStr = links[0]
            self.wkWebView.loadRequest(NSURLRequest(URL: NSURL(string: urlStr!)!))
        }
    }
    
    //MARK:-----Private Function-----
    func bottomBarSetUpLayout() {
        
        self.backButton.snp_makeConstraints { (make) in
            make.left.equalTo(self.bottomBar).offset(30)
            make.top.equalTo(self.bottomBar).offset(20)
            make.width.height.equalTo(15)
        }
        
        self.shareButton.snp_makeConstraints { (make) in
            make.right.equalTo(self.view).offset(-30)
            make.top.equalTo(self.bottomBar).offset(15)
            make.width.height.equalTo(20)
        }
        
        self.safariButton.snp_makeConstraints { (make) in
            make.right.equalTo(self.shareButton.snp_left).offset(-35)
            make.top.equalTo(self.bottomBar).offset(15)
            make.width.height.equalTo(20)
        }
        
        self.reloadButton.snp_makeConstraints { (make) in
            make.right.equalTo(self.safariButton.snp_left).offset(-35)
            make.top.equalTo(self.bottomBar).offset(15)
            make.width.height.equalTo(18)
        }
    }
    func setupLayout() {
        self.bottomBar.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(45)
        }
    }
    
    func backButtonDidClick() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func shareButtonDidClick() {
        showShareView()
    }
    
    func safariButtonDidClick() {
        UIApplication.sharedApplication().openURL(NSURL(string: self.urlStr!)!)
    }
    
    func reloadButtonDidClick() {
        self.wkWebView.loadHTMLString("", baseURL: nil)
        self.wkWebView.loadRequest(NSURLRequest(URL: NSURL(string: urlStr!)!))
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //MARK:-----Getter and Setter-----
    private lazy var wkWebView: WKWebView = {
        let wkWebView: WKWebView = WKWebView(frame: self.view.frame)
        wkWebView.navigationDelegate = self
        return wkWebView
    }()
    
    /// 底部的工具栏
    private lazy var bottomBar: UIView = {
        let bottomBar: UIView = UIView()
        
        bottomBar.backgroundColor = UIColor.blackColor()
        bottomBar.addSubview(self.backButton)
        bottomBar.addSubview(self.reloadButton)
        bottomBar.addSubview(self.shareButton)
        bottomBar.addSubview(self.safariButton)
        
        return bottomBar
    }()
    
    /// 返回按钮
    private lazy var backButton: UIButton = {
        let backButton: UIButton = UIButton()
        backButton.setImage(UIImage(imageLiteral: "ic_close"), forState: .Normal)
        backButton.imageView?.contentMode = .ScaleAspectFit
        backButton.addTarget(self, action: #selector(backButtonDidClick), forControlEvents: .TouchUpInside)
        return backButton
    }()
    
    /// 重新加载按钮
    private lazy var reloadButton: UIButton = {
        let reloadButton: UIButton = UIButton()
        reloadButton.setImage(UIImage(imageLiteral: "ic_refresh"), forState: .Normal)
        reloadButton.contentMode = .ScaleAspectFit
        reloadButton.addTarget(self, action: #selector(reloadButtonDidClick), forControlEvents: .TouchUpInside)
        return reloadButton
    }()
    
    /// 跳转到Safari
    private lazy var safariButton: UIButton = {
        let safariButton: UIButton = UIButton()
        safariButton.setImage(UIImage(imageLiteral: "ic_system_browser"), forState: .Normal)
        safariButton.imageView?.contentMode = .ScaleAspectFit
        safariButton.addTarget(self, action: #selector(safariButtonDidClick), forControlEvents: .TouchUpInside)
        return safariButton
    }()
    
    /// 分享按钮
    private lazy var shareButton: UIButton = {
        let shareButton: UIButton = UIButton()
        shareButton.setImage(UIImage(imageLiteral: "ic_comment_bar_share"), forState: .Normal)
        shareButton.imageView?.contentMode = .ScaleAspectFit
        shareButton.addTarget(self, action: #selector(shareButtonDidClick), forControlEvents: .TouchUpInside)
        return shareButton
    }()
}

//MARK:-----ShareViewDelegate-----
extension NewsFlashDetailController: ShareViewDelegate, shareResuable {
    
    func weixinShareButtonDidClick() {
        shareToFriend((model?.excerpt)!,
                      shareImageUrl: (model?.image)!,
                      shareUrl: urlStr!,
                      shareTitle: (model?.title)!)
    }
    
    func friendsCircleShareButtonDidClick() {
        shareToFriendsCircle((model?.excerpt)!,
                             shareTitle: (model?.title)!,
                             shareUrl: urlStr!,
                             shareImageUrl: (model?.image)!)
    }
    
    func shareMoreButtonDidClick() {
        hiddenShareView()
    }
}

//MARK:-----UIWebView Delegate-----
extension NewsFlashDetailController: WKNavigationDelegate {
    
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showProgress()
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        self.hiddenProgress()
    }
}