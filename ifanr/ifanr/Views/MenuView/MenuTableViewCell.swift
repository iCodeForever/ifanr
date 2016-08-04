//
//  MenuTableViewCell.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/1.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell, Reusable {
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        // 添加控件
        self.contentView.addSubview(iconView)
        self.contentView.addSubview(titleLabel)
        
        // 添加约束
        iconView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 25, height: 25))
            make.centerY.equalTo(self.contentView.snp_centerY)
            make.left.equalTo(self.contentView).offset(UIConstant.UI_MARGIN_20)
        }
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.iconView.snp_right).offset(30)
            make.top.bottom.right.equalTo(self.contentView)
        }
    }
    
    /// 给外部传递模型进来， 然后设置数据
    var model: MenuTabModel! {
        didSet {
            self.iconView.image = model.image
            self.titleLabel.text = model.title
        }
    }
    
    class func cellWithTableView(tableView : UITableView) -> MenuTableViewCell {
        var cell = tableView.dequeueReusableCell() as MenuTableViewCell?
        if cell == nil {
            cell = MenuTableViewCell(style: .Default, reuseIdentifier: self.reuseIdentifier)
            cell?.selectionStyle = .None
        }
        return cell!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: --------------------------- Getter and Setter --------------------------
    /// 图标
    private lazy var iconView: UIImageView = {
        var iconView = UIImageView()
        iconView.contentMode = .ScaleAspectFit
        return iconView
    }()
    
    /// 标题
    private lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.font = UIConstant.UI_FONT_16
        titleLabel.textColor = UIConstant.UI_COLOR_GrayTheme
        return titleLabel
    }()
}
