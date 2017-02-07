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

class IFDetailsController: UIViewController{
    
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
        self.toolBar.praiseButton.setTitle(String(format:"点赞(%d)",(model?.like)!), for: UIControlState())
        self.wkWebView.load(URLRequest(url: URL(string: (self.model?.link)!)!))
    }
    
    convenience init(model: CommonModel, naviTitle: String) {
        self.init()
        self.model = model
        self.naviTitle = naviTitle
        
        headerBack.title = naviTitle
    }
    
    //MARK:-----Custom Function-----
    fileprivate func setupLayout() {
        self.wkWebView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.view);
            make.bottom.equalTo(self.view)
        }
        
        self.toolBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(50)
        }
        
        self.headerBack.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            self.headerTopConstraint = make.top.equalTo(self.view).constraint
            make.height.equalTo(50)
        }
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    //MARK:-----Getter and Setter-----
    fileprivate var lastPosition: CGFloat = 0
    fileprivate var headerTopConstraint: Constraint? = nil
    fileprivate var model: CommonModel?
    fileprivate var naviTitle: String!
    /// wkWebView
    fileprivate lazy var wkWebView: WKWebView = {
        let wkWebView: WKWebView = WKWebView()
        wkWebView.navigationDelegate    = self
        wkWebView.scrollView.delegate   = self
        return wkWebView
    }()
    /// 底部工具栏
    fileprivate lazy var toolBar: BottomToolsBar = {
        let toolBar: BottomToolsBar = BottomToolsBar()
        toolBar.delegate = self
        return toolBar
    }()
    /// 顶部返回栏
    fileprivate lazy var headerBack: HeaderBackView = {
        let headerBack: HeaderBackView = HeaderBackView(title: "")
        headerBack.delegate = self
        return headerBack
    }()
}

//MARK:-----ShareViewDelegate-----
extension IFDetailsController: ShareViewDelegate, shareResuable {
    
    func weixinShareButtonDidClick() {
        shareToFriend((model?.excerpt)!,
                      shareImageUrl: (model?.image)!,
                      shareUrl: (model?.link)!,
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
}

//MARK:-----ToolBarDelegate-----
extension IFDetailsController: ToolBarDelegate {
    
    func editCommentDidClick() {
        debugPrint("editCommon")
    }
    
    func praiseButtonDidClick() {
        if self.toolBar.praiseButton.isSelected {
            self.toolBar.praiseButton.isSelected = false
        } else {
            self.toolBar.praiseButton.isSelected = true
        }
    }
    
    func shareButtonDidClick() {
        self.showShareView()
    }
    
    func commentButtonDidClick() {
        let ifDetailCommentVC = IFDetailCommentVC(id: model?.ID)
        self.navigationController?.pushViewController(ifDetailCommentVC, animated: true)
    }
}

//MARK:-----WebViewDelegate UIScrollViewDelegate-----
extension IFDetailsController: WKNavigationDelegate, UIScrollViewDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showProgress()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hiddenProgress()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPosition: CGFloat = scrollView.contentOffset.y
        if currentPosition - self.lastPosition > 30 && currentPosition > 0 {
            self.headerTopConstraint?.update(offset: -50)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.headerBack.layoutIfNeeded()
            })
            
            self.lastPosition = currentPosition
            
        } else if self.lastPosition - currentPosition > 10 {
            self.headerTopConstraint?.update(offset: 0)
            UIView.animate(withDuration: 0.3, animations: {
                self.headerBack.layoutIfNeeded()
            })
            self.lastPosition = currentPosition
        }
    }
}

//MARK:-----HeaderViewDelegate-----
extension IFDetailsController: HeaderViewDelegate {
    func backButtonDidClick() {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
