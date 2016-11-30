//
//  UITableVIew+ifanr.swift
//  ifanr
//
//  Created by 梁亦明 on 16/8/2.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

extension UITableView {
    func reloadData(_ completion:@escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { 
            self.reloadData()
            }, completion: { _ in
                self.isHidden = true
                completion()
                self.isHidden = false
        }) 
    }
}
