//
//  SettingModel.swift
//  ifanr
//
//  Created by 梁亦明 on 16/8/5.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

let SettingModelArray = [
    SettingModel(type: .DetailTitle, title: nil, detail: "常用设置", isSwitch: false, isImage: false),
    SettingModel(type: .Switch, title: "无图环境", detail: "非Wi-Fi环境下不加载图片", isSwitch: true, isImage: false),
    SettingModel(type: .Default, title: "清除缓存", detail: "已缓存0M", isSwitch: false, isImage: false),
    SettingModel(type: .Image, title: "给我们好评", detail: nil, isSwitch: false, isImage: true)
]


struct SettingModel {
    let type: SettingCellType
    let title: String?
    let detail: String?
    let isSwitch: Bool
    let isImage: Bool
}