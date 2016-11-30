//
//  CategoryModel.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/25.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

let CategoryModelArray = [
    CategoryModel(
        title: "首页",
        backgroundImage: UIImage(named: "category_menu_home_bg")!,
        icon: UIImage(named: "category_menu_home_icon")!,
        listImage: nil, subTitle: "",
        type: nil,
        coverColor: UIColor.black.withAlphaComponent(0.7)),
    
    CategoryModel(
        title: "视频",
        backgroundImage: UIImage(named: "category_menu_video_bg")!,
        icon: UIImage(named: "category_menu_video_icon")!,
        listImage: UIImage(named: "category_article_list_video_bg"),
        subTitle: "只有声和光，呈现更鲜活的科技世界",
        type: .video,
        coverColor: UIColor(red: 175/255.0, green: 185/255.0, blue: 200/255.0, alpha: 0.7)),
    
    CategoryModel(
        title: "iSeed",
        backgroundImage: UIImage(named: "category_menu_iseed_bg")!,
        icon: UIImage(named: "category_menu_iseed_icon")!,
        listImage: UIImage(named: "category_article_list_iseed_bg"),
        subTitle: "每一个创业公司都是一颗种子",
        type: .video,
        coverColor: UIColor(red: 230/255.0, green: 120/255.0, blue: 120/255.0, alpha: 0.7)),
    
    CategoryModel(
        title: "大声", backgroundImage: UIImage(named: "category_menu_dasheng_bg")!,
        icon: UIImage(named: "category_menu_dasheng_icon")!,
        listImage: UIImage(named: "category_article_list_dasheng_bg"),
        subTitle: "为你解读声音其中的真知",
        type: .daSheng,
        coverColor: UIColor(red: 160/255.0, green: 100/255.0, blue: 150/255.0, alpha: 0.7)),
    
    CategoryModel(
        title: "数读",
        backgroundImage: UIImage(named: "category_menu_shudu_bg")!,
        icon: UIImage(named: "category_menu_shudu_icon")!,
        listImage: UIImage(named: "category_article_list_shudu_bg"),
        subTitle: "用数字读懂世界，传达客观的数据实现",
        type: .shudu,
        coverColor: UIColor(red: 250/255.0, green: 200/255.0, blue: 120/255.0, alpha: 0.7)),
    
    CategoryModel(
        title: "评测",
        backgroundImage: UIImage(named: "category_menu_evaluation_bg")!,
        icon: UIImage(named: "category_menu_evaluation_icon")!,
        listImage: UIImage(named: "category_article_list_evaluation_bg"),
        subTitle: "从产品中洞悉你的需求",
        type: .evaluation,
        coverColor: UIColor(red: 204/255.0, green: 177/255.0, blue: 219/255.0, alpha: 0.7)),
    
    CategoryModel(
        title: "产品",
        backgroundImage: UIImage(named: "category_menu_product_bg")!,
        icon: UIImage(named: "category_menu_product_icon")!,
        listImage: UIImage(named: "category_article_list_product_bg"),
        subTitle: "关乎技术，关乎设计，更关乎人性的物件",
        type: .product,
        coverColor: UIColor(red: 236/255.0, green: 146/255.0, blue: 92/255.0, alpha: 0.7)),
    
    CategoryModel(
        title: "汽车",
        backgroundImage: UIImage(named: "category_menu_car_bg")!,
        icon: UIImage(named: "category_menu_car_icon")!,
        listImage: UIImage(named: "category_article_list_car_bg"),
        subTitle: "我们把它视为最大的“移动设备”",
        type: .car,
        coverColor: UIColor(red: 181/255.0, green: 150/255.0, blue: 123/255.0, alpha: 0.7)),
    
    CategoryModel(
        title: "商业",
        backgroundImage: UIImage(named: "category_menu_business_bg")!,
        icon: UIImage(named: "category_menu_business_icon")!,
        listImage: UIImage(named: "category_article_list_business_bg"),
        subTitle: "看起来很远但最可能改变你生活方式的公司",
        type: .business,
        coverColor: UIColor(red: 165/255.0, green: 200/255.0, blue: 115/255.0, alpha: 0.7)),
    
    CategoryModel(
        title: "访谈",
        backgroundImage: UIImage(named: "category_menu_interview_bg")!,
        icon: UIImage(named: "category_menu_interview_icon")!,
        listImage: UIImage(named: "category_article_list_interview_bg"),
        subTitle: "从对话中洞悉价值",
        type: .interview,
        coverColor: UIColor(red: 215/255.0, green: 97/255.0, blue: 97/255.0, alpha: 0.7)),
    
    CategoryModel(
        title: "图记",
        backgroundImage: UIImage(named: "category_menu_picture_bg")!,
        icon: UIImage(named: "category_menu_picture_icon")!,
        listImage: UIImage(named: "category_article_list_picture_bg"),
        subTitle: "五张图，回溯一周的热点",
        type: .picture,
        coverColor: UIColor(red: 61/255.0, green: 144/255.0, blue: 174/255.0, alpha: 0.7)),
    
    CategoryModel(
        title: "清单",
        backgroundImage: UIImage(named: "category_menu_list_bg")!,
        icon: UIImage(named: "category_menu_list_icon")!,
        listImage: UIImage(named: "category_article_list_list_bg"),
        subTitle: "一个List，告诉你需要什么",
        type: .list,
        coverColor: UIColor(red: 85/255.0, green: 160/255.0, blue: 215/255.0, alpha: 0.7))
]

struct CategoryModel {
    let title: String
    let backgroundImage: UIImage
    let icon: UIImage
    let listImage: UIImage?
    let subTitle: String
    let type: CategoryName?
    let coverColor: UIColor
}
