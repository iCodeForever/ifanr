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
        self.backgroundColor = UIColor.black
        let attributes = [NSFontAttributeName: UIFont.customFont_FZLTXIHJW(fontSize: 10)]
        let labelWidth = (textArray.last! as NSString).boundingRect(with: CGSize(width: 60, height: self.height), options: .usesLineFragmentOrigin, attributes: attributes, context: nil).width
        for i in 0..<textArray.count {
            let label = createLable(textArray[i])
            // 计算label大小
            label.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: labelWidth, height: self.height))
            let x = CGFloat(i)*(UIConstant.SCREEN_WIDTH*0.5-labelWidth*0.5)+UIConstant.SCREEN_WIDTH*0.5
            label.center = CGPoint(x: x, y: self.height*0.5)
        }
    }
    
    override func layoutSubviews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: --------------------------- Private Methods --------------------------
    
    /**
     创建Label
     */
    fileprivate func createLable(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = UIColor.white
        label.font = UIFont.customFont_FZLTXIHJW(fontSize: 10)
        label.textAlignment = .center
        labelArray.append(label)
        self.addSubview(label)
        return label
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
    var labelArray = [UILabel]()
    let textArray = ["快讯", "首页", "玩物志", "Appso", "MindStore"]
}
