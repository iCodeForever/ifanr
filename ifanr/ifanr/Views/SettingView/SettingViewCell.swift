//
//  SettingViewCell.swift
//  ifanr
//
//  Created by 梁亦明 on 16/8/4.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

class SettingViewCell: UITableViewCell, Reusable {
    
    
    class func cellWithTableView(tableView: UITableView) -> SettingViewCell {
        var cell = tableView.dequeueReusableCell() as SettingViewCell?
        if cell == nil {
            cell = SettingViewCell(style: .Default, reuseIdentifier: self.reuseIdentifier)
            cell!.selectionStyle = .None
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 16)
        titleLabel.textColor = UIColor.whiteColor()
        return titleLabel
    }()
    
    private lazy var detailLabel: UILabel = {
        let detailLable = UILabel()
        detailLable.font = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        detailLable.textColor = UIColor.lightGrayColor()
        return detailLable
    }()
    
    private lazy var startView: UIView = {
        var startView = UIView()
        
        return startView
    }()
}