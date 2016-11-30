//
//  UIViewController+IF.swift
//  ifanr
//
//  Created by sys on 16/7/21.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

extension UIViewController {
    
    func showProgress () {
        let progressView = UIActivityIndicatorView()
        progressView.activityIndicatorViewStyle = .gray
        progressView.hidesWhenStopped = true
        progressView.tag = 500
        self.view.addSubview(progressView)
        
        progressView.snp_makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.height.width.equalTo(20)
        }
        
        progressView.startAnimating()
    }
    
    func hiddenProgress() {
        for view in self.view.subviews {
            if view.tag == 500 {
                let indicatorView : UIActivityIndicatorView = view as! UIActivityIndicatorView
                indicatorView.stopAnimating()
                indicatorView.removeFromSuperview()
            }
        }
    }
}
