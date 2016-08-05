//
//  SettingViewCell.swift
//  ifanr
//
//  Created by 梁亦明 on 16/8/4.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

enum SettingCellType {
    case Default
    case DetailTitle
    case Switch
    case Image
    
    func cellReuseIdentifier() -> String {
        switch self {
        case .Default:
            return "SettingDefault"
        case .DetailTitle:
            return "SettingDetailTitle"
        case .Switch:
            return "SettingSwitch"
        case .Image:
            return "SettingImage"
        }
    }
}

class SettingViewCell: UITableViewCell, Reusable {
    var cellType: SettingCellType = .Default
    
    class func cellWithTableView(tableView: UITableView) -> SettingViewCell {
        var cell = tableView.dequeueReusableCell() as SettingViewCell?
        if cell == nil {
            cell = SettingViewCell(style: .Default, reuseIdentifier: self.reuseIdentifier)
            
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.blackColor()
        selectionStyle = .None
        switch reuseIdentifier! {
        case SettingCellType.Default.cellReuseIdentifier():
            addSubview(titleLabel)
            addSubview(detailLabel)
            setupTitleLayout()
            setupDetailTitleLayout()
        case SettingCellType.DetailTitle.cellReuseIdentifier():
            addSubview(detailLabel)
            setupDetailTitleLayout()
        case SettingCellType.Switch.cellReuseIdentifier():
            addSubview(titleLabel)
            addSubview(detailLabel)
            addSubview(switchView)
            setupTitleLayout()
            setupDetailTitleLayout()
            setupSwitchLayout()
        case SettingCellType.Image.cellReuseIdentifier():
            addSubview(titleLabel)
            addSubview(startView)
            setupTitleLayout()
            setupImageLayout()
        default:
            break
        }
        addSubview(lineView)
        setupLineView()
    }
    
    var model: SettingModel! {
        didSet {
            switch model.type {
            case .Default, .Switch:
                self.titleLabel.text = model.title
                self.detailLabel.text = model.detail
                
            case .DetailTitle:
                detailLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 14)
                self.detailLabel.text = model.detail
                
            case .Image:
                titleLabel.text = model.title
            }
        }
    }
    
    convenience init(cellType: SettingCellType) {
        self.init(style: .Default, reuseIdentifier: cellType.cellReuseIdentifier())
        self.cellType = cellType
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 16)
        titleLabel.textColor = UIColor.lightGrayColor()
        return titleLabel
    }()
    
    private lazy var detailLabel: UILabel = {
        let detailLable = UILabel()
        detailLable.font = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        detailLable.textColor = UIColor.darkGrayColor()
        return detailLable
    }()
    
    private lazy var switchView: UISwitch = {
        let switchView = UISwitch()
        return switchView
    
    }()
    
    private lazy var startView: UIView = {
        var startView = UIView()
        for i in 0 ..< 5 {
            var startImageView = UIImageView(image: UIImage(named: "ic_start"))
            startImageView.frame = CGRect(x: i*20, y: 0, width: 20, height: 20)
            startImageView.contentMode = .ScaleAspectFit
            startView.addSubview(startImageView)
        }
        return startView
    }()
    
    private lazy var startImageView: UIImageView = {
        var startImageView = UIImageView(image: UIImage(named: "ic_start"))
        startImageView.contentMode = .ScaleAspectFit
        return startImageView
    }()
    
    private lazy var lineView: UIView = {
        var lineView = UIView()
        lineView.backgroundColor = UIColor.darkGrayColor()
        return lineView
    }()
}

extension SettingViewCell {
    private func setupTitleLayout() {
        self.titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(UIConstant.UI_MARGIN_20)
            make.right.equalTo(self).inset(UIConstant.UI_MARGIN_20)
            make.top.equalTo(self).offset(UIConstant.UI_MARGIN_10)
            make.height.equalTo(20)
        }
    }
    
    private func setupDetailTitleLayout() {
        self.detailLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(UIConstant.UI_MARGIN_20)
            make.right.equalTo(self).inset(UIConstant.UI_MARGIN_20)
            make.bottom.equalTo(self).inset(UIConstant.UI_MARGIN_10)
            make.height.equalTo(20)
        }
    }
    
    private func setupLineView() {
        self.lineView.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(UIConstant.UI_MARGIN_20)
            make.right.equalTo(self).inset(UIConstant.UI_MARGIN_20)
            make.height.equalTo(1)
            make.bottom.equalTo(self).inset(1)
        }
    }
    
    private func setupSwitchLayout() {
        switchView.snp_makeConstraints { (make) in
            make.right.equalTo(self).inset(UIConstant.UI_MARGIN_20)
            make.centerY.equalTo(self.snp_centerY)
            make.size.equalTo(CGSize(width: 49, height: 31))
        }
    }
    private func setupImageLayout() {
        startView.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(UIConstant.UI_MARGIN_20)
            make.right.equalTo(self).inset(UIConstant.UI_MARGIN_20)
            make.bottom.equalTo(self).inset(UIConstant.UI_MARGIN_10)
            make.height.equalTo(20)
        }
    }
}