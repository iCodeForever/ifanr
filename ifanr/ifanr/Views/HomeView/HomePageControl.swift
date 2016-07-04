//
//  HomePageControl.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/3.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

class HomePageControl: UIView {
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(frame: CGRect, numberOfPage: Int) {
        self.init(frame: frame)
        self.numberOfPage = numberOfPage
        
        // 默认设置currentPage = 0
        self.currentPage = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: --------------------------- Private Methods --------------------------
    /**
     创建一个Label
     */
    private func setupPageLabel() -> UILabel {
        let inactiveLabel = UILabel()
        inactiveLabel.textAlignment = .Center
        inactiveLabel.backgroundColor = UIColor.clearColor()
        inactiveLabel.textColor = UIColor.blackColor()
        inactiveLabel.font = UIConstant.UI_FONT_12
        inactiveLabel.alpha = 0.8
        inactiveLabel.layer.borderColor = UIColor(red: 225/255.0, green: 225/255.0, blue: 225/255.0, alpha: 1).CGColor
        inactiveLabel.layer.borderWidth = 0.5
        return inactiveLabel
    }
    
    private func setupPage(index: Int) {
        // 改变上一个page
        if let lastPage = lastPageLabel {
            lastPage.text = ""
            lastPage.backgroundColor = UIColor.clearColor()
        }
        
        // 改变当前page
        let currentLabel = self.pageArray[index]
        currentLabel.backgroundColor = UIColor(red: 225/255.0, green: 225/255.0, blue: 225/255.0, alpha: 1)
        currentLabel.text = "\(index+1)"
        
        self.lastPageLabel = currentLabel
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
    var currentPage: Int! {
        didSet {
//            if currentPage < 0 || currentPage >= self.numberOfPage {
//                currentPage = 0
//            }
            
            // 设置当前page颜色
            self.setupPage(currentPage)
        }
    }
        /// 上一个Page
    var lastPageLabel: UILabel?
    
    var numberOfPage: Int! {
        didSet {
            // 先从父控件中移除
            pageArray.forEach {
                $0.removeFromSuperview()
            }
            
            // 在添加
            for page in 0..<self.numberOfPage {
                let pageLabel = setupPageLabel()
                pageLabel.frame = CGRect(x: CGFloat(page)*(UIConstant.UI_MARGIN_10+self.height), y: 0, width: self.height, height: self.height)
                self.addSubview(pageLabel)
                pageArray.append(pageLabel)
            }
            self.currentPage = 0
        }
    }
    
    private var pageArray: [UILabel]! = []
}


