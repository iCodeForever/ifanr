//
//  Constant.swift
//  ifanr
//
//  Created by 梁亦明 on 16/6/30.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

struct UIConstant {
    // 屏幕宽高
    static let IPHONE6_WIDTH : CGFloat = 375
    static let IPHONE6_HEIGHT : CGFloat = 667
    static let IPHONE5_WIDTH : CGFloat = 320
    static let IPHONE5_HEIGHT : CGFloat = 568
    static let SCREEN_WIDTH : CGFloat = UIScreen.mainScreen().bounds.width
    static let SCREEN_HEIGHT : CGFloat = UIScreen.mainScreen().bounds.height
    // 导航栏高度
    static let UI_NAV_HEIGHT : CGFloat = 64
    // tab高度
    static let UI_TAB_HEIGHT : CGFloat = 49
    // 字体
    static let UI_FONT_12 : UIFont = UIFont.systemFontOfSize(12)
    static let UI_FONT_13 : UIFont = UIFont.systemFontOfSize(13)
    static let UI_FONT_14 : UIFont = UIFont.systemFontOfSize(14)
    static let UI_FONT_16 : UIFont = UIFont.systemFontOfSize(16)
    static let UI_FONT_20 : UIFont = UIFont.systemFontOfSize(20)
    // 间距
    static let UI_MARGIN_5 : CGFloat = 5
    static let UI_MARGIN_10 : CGFloat = 10
    static let UI_MARGIN_15 : CGFloat = 15
    static let UI_MARGIN_20 : CGFloat = 20
    
    // 颜色
    static let UI_COLOR_GrayTheme: UIColor = UIColor(red: 155/255.0, green: 155/255.0, blue: 155/255.0, alpha: 1)
}
