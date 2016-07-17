//
//  IFDetailsController.swift
//  ifanr
//
//  Created by sys on 16/7/17.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

class IFDetailsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.toolBar)
        
        self.setupLayout()
    }
    
    //MARK:-----Getter and Setter-----
    private lazy var toolBar: BottomToolsBar = {
        let toolBar: BottomToolsBar = BottomToolsBar()
        return toolBar
    }()
    
    //MARK:-----Custom Function-----
    private func setupLayout() {
        self.toolBar.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(60)
        }
    }
}
