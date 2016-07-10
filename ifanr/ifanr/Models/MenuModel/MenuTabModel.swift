//
//  MainTabModel.swift
//  ifanr
//
//  Created by 梁亦明 on 16/6/30.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

struct MenuTabModel {
    let image: UIImage
    let title: String
}

let MenuTabItems = [
    MenuTabModel(image: UIImage(named: "ic_login")!, title: "马上登录"),
    MenuTabModel(image: UIImage(named: "ic_report")!, title: "寻求报道"),
    MenuTabModel(image: UIImage(named: "ic_about")!, title: "关于爱范儿")
]
