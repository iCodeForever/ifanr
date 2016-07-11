//
//  MainHeaderView.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/12.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation


class MainHeaderView: UIView, Reusable {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blackColor()
    }
    
    override func layoutSubviews() {
        for i in 0..<textArray.count {
            let label = createLable(textArray[i])
            label.frame = CGRect(origin: CGPointZero, size: CGSize(width: 40, height: self.height))
            let x = CGFloat(i)*(UIConstant.SCREEN_WIDTH*0.5-20)+UIConstant.SCREEN_WIDTH*0.5
            label.center = CGPoint(x: x, y: self.height*0.5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: --------------------------- Private Methods --------------------------
    
    /**
     创建Label
     */
    private func createLable(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.customFont_FZLTXIHJW(fontSize: 10)
        label.textAlignment = .Center
        label.sizeToFit()
        labelArray.append(label)
        self.addSubview(label)
        return label
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
    var labelArray = [UILabel]()
    let textArray = ["快讯", "首页", "玩物志", "Appso", "MindStore"]
}