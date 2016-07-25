//
//  CategoryModel.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/25.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

let CategoryModelArray = [
    CategoryModel(title: "首页", backgroundImage: UIImage(named: "category_menu_home_bg")!, icon: UIImage(named: "category_menu_home_icon")!),
    CategoryModel(title: "视频", backgroundImage: UIImage(named: "category_menu_video_bg")!,icon: UIImage(named: "category_menu_video_icon")!),
    CategoryModel(title: "iSeed", backgroundImage: UIImage(named: "category_menu_iseed_bg")!, icon: UIImage(named: "category_menu_iseed_icon")!),
    CategoryModel(title: "大声", backgroundImage: UIImage(named: "category_menu_dasheng_bg")!, icon: UIImage(named: "category_menu_dasheng_icon")!),
    CategoryModel(title: "数读", backgroundImage: UIImage(named: "category_menu_shudu_bg")!, icon: UIImage(named: "category_menu_shudu_icon")!),
    CategoryModel(title: "评测", backgroundImage: UIImage(named: "category_menu_evaluation_bg")!, icon: UIImage(named: "category_menu_evaluation_icon")!),
    CategoryModel(title: "产品", backgroundImage: UIImage(named: "category_menu_product_bg")!, icon: UIImage(named: "category_menu_product_icon")!),
    CategoryModel(title: "汽车", backgroundImage: UIImage(named: "category_menu_car_bg")!, icon: UIImage(named: "category_menu_car_icon")!),
    CategoryModel(title: "商业", backgroundImage: UIImage(named: "category_menu_business_bg")!, icon: UIImage(named: "category_menu_business_icon")!),
    CategoryModel(title: "访谈", backgroundImage: UIImage(named: "category_menu_interview_bg")!, icon: UIImage(named: "category_menu_interview_icon")!),
    CategoryModel(title: "图记", backgroundImage: UIImage(named: "category_menu_picture_bg")!, icon: UIImage(named: "category_menu_picture_icon")!),
    CategoryModel(title: "清单", backgroundImage: UIImage(named: "category_menu_list_bg")!, icon: UIImage(named: "category_menu_list_icon")!)
]

struct CategoryModel {
    let title: String
    let backgroundImage: UIImage
    let icon: UIImage
}