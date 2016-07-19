//
//  IFDetailsController.swift
//  ifanr
//
//  Created by sys on 16/7/17.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import WebKit

class IFDetailsController: UIViewController, WKNavigationDelegate {

    var model: HomePopularModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.wkWebView)
        self.view.addSubview(self.toolBar)
        
        self.setupLayout()
    }
    
    convenience init(model: HomePopularModel) {
        self.init()
        self.model = model
        
        self.wkWebView.loadRequest(NSURLRequest(URL: NSURL(string: model.link)!))
    }
    
    //MARK:-----Getter and Setter-----
    private lazy var wkWebView: WKWebView = {
        let wkWebView: WKWebView = WKWebView()
        return wkWebView
    }()
    
    private lazy var toolBar: BottomToolsBar = {
        let toolBar: BottomToolsBar = BottomToolsBar()
        return toolBar
    }()
    
    //MARK:-----Custom Function-----
    
    private func setupLayout() {
        self.wkWebView.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(self.view);
            make.bottom.equalTo(self.view)
        }
        
        self.toolBar.snp_makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.height.equalTo(50)
            make.bottom.equalTo(self.view).offset(-20)
        }
    }
    
    //MARK:-----WebView Delegate-----
    func webViewDidFinishLoad(webView: UIWebView) {
        
    }
}