//
//  UITableVIew+ifanr.swift
//  ifanr
//
//  Created by 梁亦明 on 16/8/2.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

extension UITableView {
    func reloadData(completion:()->()) {
        UIView.animateWithDuration(0, animations: { 
            self.reloadData()
            }) { _ in
                self.hidden = true
                completion()
                self.hidden = false
        }
    }
}