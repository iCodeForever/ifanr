//
//  TableHeaderModel.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/19.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

let TableHeaderModelArray = [
    TableHeaderModel(backImage: UIImage(named: "buzz_header_background")!, title: "快讯", detail: "最新的资讯快报", tagImage: UIImage(named: "tag_happeningnow")!),
    TableHeaderModel(backImage: UIImage(named: "coolbuy_header_background")!, title: "玩物志", detail: "值得买的未来生活", tagImage: UIImage(named: "tag_coolbuy")!),
    TableHeaderModel(backImage: UIImage(named: "appso_header_background")!, title: "AppSo", detail: "智能手机更好用的秘密", tagImage: UIImage(named: "tag_appsolution")!),
    TableHeaderModel(backImage: UIImage(named: "mind_store_header_background")!,title: "MindStore", detail: "在这里发现最好的产品和想法", tagImage: UIImage(named: "tag_latest_press")!)
]

struct TableHeaderModel {
    let backImage: UIImage
    let title: String
    let detail: String
    let tagImage: UIImage
}