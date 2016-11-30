//
//  SettingViewCell.swift
//  ifanr
//
//  Created by 梁亦明 on 16/8/4.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

enum SettingCellType {
    case `default`
    case detailTitle
    case `switch`
    case image
    
    func cellReuseIdentifier() -> String {
        switch self {
        case .default:
            return "SettingDefault"
        case .detailTitle:
            return "SettingDetailTitle"
        case .switch:
            return "SettingSwitch"
        case .image:
            return "SettingImage"
        }
    }
}

class SettingViewCell: UITableViewCell, Reusable {
    var cellType: SettingCellType = .default
    
    class func cellWithTableView(_ tableView: UITableView) -> SettingViewCell {
        var cell = tableView.dequeueReusableCell() as SettingViewCell?
        if cell == nil {
            cell = SettingViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
            
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.black
        selectionStyle = .none
        switch reuseIdentifier! {
        case SettingCellType.default.cellReuseIdentifier():
            addSubview(titleLabel)
            addSubview(detailLabel)
            setupTitleLayout()
            setupDetailTitleLayout()
        case SettingCellType.detailTitle.cellReuseIdentifier():
            addSubview(detailLabel)
            setupDetailTitleLayout()
        case SettingCellType.switch.cellReuseIdentifier():
            addSubview(titleLabel)
            addSubview(detailLabel)
            addSubview(switchView)
            setupTitleLayout()
            setupDetailTitleLayout()
            setupSwitchLayout()
        case SettingCellType.image.cellReuseIdentifier():
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
            case .default, .switch:
                self.titleLabel.text = model.title
                self.detailLabel.text = model.detail
                
            case .detailTitle:
                detailLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 14)
                self.detailLabel.text = model.detail
                
            case .image:
                titleLabel.text = model.title
            }
        }
    }
    
    convenience init(cellType: SettingCellType) {
        self.init(style: .default, reuseIdentifier: cellType.cellReuseIdentifier())
        self.cellType = cellType
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 16)
        titleLabel.textColor = UIColor.lightGray
        return titleLabel
    }()
    
    fileprivate lazy var detailLabel: UILabel = {
        let detailLable = UILabel()
        detailLable.font = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        detailLable.textColor = UIColor.darkGray
        return detailLable
    }()
    
    fileprivate lazy var switchView: UISwitch = {
        let switchView = UISwitch()
        return switchView
    
    }()
    
    fileprivate lazy var startView: UIView = {
        var startView = UIView()
        for i in 0 ..< 5 {
            var startImageView = UIImageView(image: UIImage(named: "ic_start"))
            startImageView.frame = CGRect(x: i*20, y: 0, width: 20, height: 20)
            startImageView.contentMode = .scaleAspectFit
            startView.addSubview(startImageView)
        }
        return startView
    }()
    
    fileprivate lazy var startImageView: UIImageView = {
        var startImageView = UIImageView(image: UIImage(named: "ic_start"))
        startImageView.contentMode = .scaleAspectFit
        return startImageView
    }()
    
    fileprivate lazy var lineView: UIView = {
        var lineView = UIView()
        lineView.backgroundColor = UIColor.darkGray
        return lineView
    }()
}

extension SettingViewCell {
    fileprivate func setupTitleLayout() {
        self.titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(UIConstant.UI_MARGIN_20)
            make.right.equalTo(self).inset(UIConstant.UI_MARGIN_20)
            make.top.equalTo(self).offset(UIConstant.UI_MARGIN_10)
            make.height.equalTo(20)
        }
    }
    
    fileprivate func setupDetailTitleLayout() {
        self.detailLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(UIConstant.UI_MARGIN_20)
            make.right.equalTo(self).inset(UIConstant.UI_MARGIN_20)
            make.bottom.equalTo(self).inset(UIConstant.UI_MARGIN_10)
            make.height.equalTo(20)
        }
    }
    
    fileprivate func setupLineView() {
        self.lineView.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(UIConstant.UI_MARGIN_20)
            make.right.equalTo(self).inset(UIConstant.UI_MARGIN_20)
            make.height.equalTo(1)
            make.bottom.equalTo(self).inset(1)
        }
    }
    
    fileprivate func setupSwitchLayout() {
        switchView.snp_makeConstraints { (make) in
            make.right.equalTo(self).inset(UIConstant.UI_MARGIN_20)
            make.centerY.equalTo(self.snp_centerY)
            make.size.equalTo(CGSize(width: 49, height: 31))
        }
    }
    fileprivate func setupImageLayout() {
        startView.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(UIConstant.UI_MARGIN_20)
            make.right.equalTo(self).inset(UIConstant.UI_MARGIN_20)
            make.bottom.equalTo(self).inset(UIConstant.UI_MARGIN_10)
            make.height.equalTo(20)
        }
    }
}
