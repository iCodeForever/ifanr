//
//  NewsFlashDetailController.swift
//  ifanr
//
//  Created by sys on 16/7/17.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import WebKit

class IFSafariController: UIViewController {

    //MARK:-----Variables-----
    var shadowView: UIView?
    var shareView: ShareView?
    var urlStr: String?
    
    fileprivate var model: CommonModel?
    
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
            self.wkWebView.load(URLRequest(url: URL(string: urlStr!)!))
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
        self.dismiss(animated: true, completion: nil)
    }
    
    func shareButtonDidClick() {
        showShareView()
    }
    
    func safariButtonDidClick() {
        UIApplication.shared.openURL(URL(string: self.urlStr!)!)
    }
    
    func reloadButtonDidClick() {
        self.wkWebView.loadHTMLString("", baseURL: nil)
        self.wkWebView.load(URLRequest(url: URL(string: urlStr!)!))
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    //MARK:-----Getter and Setter-----
    fileprivate lazy var wkWebView: WKWebView = {
        let wkWebView: WKWebView = WKWebView(frame: self.view.frame)
        wkWebView.navigationDelegate = self
        return wkWebView
    }()
    
    /// 底部的工具栏
    fileprivate lazy var bottomBar: UIView = {
        let bottomBar: UIView = UIView()
        
        bottomBar.backgroundColor = UIColor.black
        bottomBar.addSubview(self.backButton)
        bottomBar.addSubview(self.reloadButton)
        bottomBar.addSubview(self.shareButton)
        bottomBar.addSubview(self.safariButton)
        
        return bottomBar
    }()
    
    /// 返回按钮
    fileprivate lazy var backButton: UIButton = {
        let backButton: UIButton = UIButton()
        backButton.setImage(UIImage(named: "ic_close"), for: UIControlState())
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(backButtonDidClick), for: .touchUpInside)
        return backButton
    }()
    
    /// 重新加载按钮
    fileprivate lazy var reloadButton: UIButton = {
        let reloadButton: UIButton = UIButton()
        reloadButton.setImage(UIImage(named: "ic_refresh"), for: UIControlState())
        reloadButton.contentMode = .scaleAspectFit
        reloadButton.addTarget(self, action: #selector(reloadButtonDidClick), for: .touchUpInside)
        return reloadButton
    }()
    
    /// 跳转到Safari
    fileprivate lazy var safariButton: UIButton = {
        let safariButton: UIButton = UIButton()
        safariButton.setImage(UIImage(named: "ic_system_browser"), for: UIControlState())
        safariButton.imageView?.contentMode = .scaleAspectFit
        safariButton.addTarget(self, action: #selector(safariButtonDidClick), for: .touchUpInside)
        return safariButton
    }()
    
    /// 分享按钮
    fileprivate lazy var shareButton: UIButton = {
        let shareButton: UIButton = UIButton()
        shareButton.setImage(UIImage(named: "ic_comment_bar_share"), for: UIControlState())
        shareButton.imageView?.contentMode = .scaleAspectFit
        shareButton.addTarget(self, action: #selector(shareButtonDidClick), for: .touchUpInside)
        return shareButton
    }()
}

//MARK:-----ShareViewDelegate-----
extension IFSafariController: ShareViewDelegate, shareResuable {
    
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
extension IFSafariController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showProgress()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hiddenProgress()
    }
}
