//
//  HomeLatestDataCell.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/7.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

// 数读

class HomeLatestDataCell: UITableViewCell, Reusable {
    
    class func cellWithTableView(tableView: UITableView) -> HomeLatestDataCell {
        var cell = tableView.dequeueReusableCell() as HomeLatestDataCell?
        if cell == nil {
            cell = HomeLatestDataCell(style: .Default, reuseIdentifier: HomeLatestDataCell.reuseIdentifier)
        }
        return cell!
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        self.contentView.addSubview(authorImageView)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(likeLabel)
        self.contentView.addSubview(likeImageView)
        self.contentView.addSubview(numberLabel)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(introduceLabel)
        self.contentView.layer.addSublayer(cellBottomLine)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var popularLayout: HomePopularLayout! {
        didSet {
            // 设置图片位置
            authorImageView.frame = popularLayout.kHomeCellAuthorImgRect
            
            // 设置分类和时间
            let dateAttributeText = NSMutableAttributedString(string: "\(popularLayout.model.category) | \(NSDate.getCommonExpressionOfDate(popularLayout.model.pubDate))")
            dateAttributeText.addAttribute(NSForegroundColorAttributeName, value: UIConstant.UI_COLOR_RedTheme, range: NSRange(location: 0, length: 2))
            dateLabel.attributedText = dateAttributeText
            dateLabel.frame = popularLayout.kHomeCellDateRect
            
            // 喜欢数
            likeLabel.text = "\(popularLayout.model.like)"
            likeLabel.frame = popularLayout.kHomeCellLikeRect
            likeImageView.frame = popularLayout.kHomeCellLikeImgRect
            
            // 数字
            let numberAttributeText = NSMutableAttributedString(string: "\(popularLayout.model.number)  \(popularLayout.model.subfix)")
            numberAttributeText.addAttribute(NSFontAttributeName, value: UIFont.customFont_FZLTZCHJW(fontSize: 40), range: NSRange(location: 0, length: popularLayout.model.number.length))
            numberLabel.attributedText = numberAttributeText
            numberLabel.frame = popularLayout.kHomeCellNumberRect
            
            // 标题
            self.titleLabel.attributedText = NSMutableAttributedString.attribute(popularLayout.model.title)
            self.titleLabel.frame = popularLayout.kHomeCellTitleRect
            
            // 引文
            introduceLabel.attributedText = NSMutableAttributedString.attribute(popularLayout.model.content.stringByReplacingOccurrencesOfString("<p>", withString: "").stringByReplacingOccurrencesOfString("</p>", withString: ""))
            introduceLabel.frame = popularLayout.kHomeCellTextRect
            
            // 底部横线
            cellBottomLine.frame = CGRect(x: UIConstant.UI_MARGIN_20, y: popularLayout.cellHeight-1, width: self.width-2*UIConstant.UI_MARGIN_20, height: 1)
        }
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
    /// 作者图片
    private lazy var authorImageView: UIImageView = {
        var authorImageView = UIImageView()
        authorImageView.image = UIImage(named: "ic_shudu")
        authorImageView.contentMode = .ScaleAspectFit
        return authorImageView
    }()
    
    /// 分类 和 时间
    private lazy var dateLabel: UILabel = {
        var dateLabel = UILabel()
        dateLabel.textColor = UIConstant.UI_COLOR_GrayTheme
        dateLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        return dateLabel
    }()
    
    /// 喜欢数
    private lazy var likeLabel: UILabel = {
        var likeLabel = UILabel()
        likeLabel.textColor = UIConstant.UI_COLOR_GrayTheme
        likeLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        return likeLabel
    }()
    
    private lazy var likeImageView: UIImageView = {
        var likeImage = UIImageView(image: UIImage(named: "heart_selected_false"))
        likeImage.contentMode = .ScaleAspectFit
        return likeImage
    }()
    
        /// 数字
    private lazy var numberLabel: UILabel = {
        var numberLabel = UILabel()
        numberLabel.textColor = UIColor.blackColor()
        numberLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 18)
        return numberLabel
    }()
    
        /// 标题
    private lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 16)
        titleLabel.textColor = UIConstant.UI_COLOR_RedTheme
        return titleLabel
    }()
    
    /// 引文
    private lazy var introduceLabel: UILabel = {
        var introduceLabel = UILabel()
        introduceLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        introduceLabel.numberOfLines = 0
        introduceLabel.textColor = UIConstant.UI_COLOR_GrayTheme
        return introduceLabel
    }()
    
    /// 底部分割线
    private lazy var cellBottomLine: CALayer = {
        var cellBottomLine = CALayer()
        cellBottomLine.backgroundColor = UIConstant.UI_COLOR_GrayTheme.CGColor
        return cellBottomLine
    }()

}