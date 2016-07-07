//
//  HomeLatestTextCell.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/7.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

class HomeLatestTextCell: UITableViewCell, Reusable {
    class func cellWithTableView(tableView: UITableView) -> HomeLatestTextCell {
        var cell = tableView.dequeueReusableCell() as HomeLatestTextCell?
        
        if cell == nil {
            cell = HomeLatestTextCell(style: .Default, reuseIdentifier: HomeLatestTextCell.reuseIdentifier)
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
        self.contentView.addSubview(introduceLabel)
        self.contentView.addSubview(authorLabel)
        self.layer.addSublayer(cellBottomLine)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var popularLayout: HomePopularLayout! {
        didSet {
            // 设置图片位置
            if popularLayout.model.post_type == PostType.dasheng {
                authorImageView.image = UIImage(named: "ic_dasheng")
            } else if popularLayout.model.post_type == PostType.data {
                authorImageView.image = UIImage(named: "ic_shudu")
            }
            
            authorImageView.frame = popularLayout.kHomeCellAuthorImgRect
            
            // 设置分类和时间
            let dateAttributeText = NSMutableAttributedString(string: "\(popularLayout.model.category) | \(NSDate.getDate(popularLayout.model.pubDate))")
            dateAttributeText.addAttribute(NSForegroundColorAttributeName, value: UIConstant.UI_COLOR_RedTheme, range: NSRange(location: 0, length: 2))
            dateLabel.attributedText = dateAttributeText
            dateLabel.frame = popularLayout.kHomeCellDateRect
            
            // 喜欢数
            likeLabel.text = "\(popularLayout.model.like)"
            likeLabel.frame = popularLayout.kHomeCellLikeRect
            likeImageView.frame = popularLayout.kHomeCellLikeImgRect
            
            // 引文
            introduceLabel.attributedText = NSMutableAttributedString.attribute(popularLayout.model.excerpt)
            introduceLabel.frame = popularLayout.kHomeCellTextRect
            
            // 作者
            authorLabel.text = "—— \(popularLayout.model.dasheng_author)"
            authorLabel.frame = popularLayout.kHomeCellAuthorRect
            
            // 底部横线
            cellBottomLine.frame = CGRect(x: UIConstant.UI_MARGIN_20, y: popularLayout.cellHeight-1, width: self.width-2*UIConstant.UI_MARGIN_20, height: 1)
        }
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
        /// 作者图片
    private lazy var authorImageView: UIImageView = {
        var authorImageView = UIImageView()
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
    
    /// 引文
    private lazy var introduceLabel: UILabel = {
        var introduceLabel = UILabel()
        introduceLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 16)
        introduceLabel.numberOfLines = 0
        introduceLabel.textColor = UIConstant.UI_COLOR_RedTheme
        return introduceLabel
    }()
    
    /// 作者
    private lazy var authorLabel: UILabel = {
        var authorLabel = UILabel()
        authorLabel.textAlignment = .Center
        authorLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 16)
        authorLabel.textColor = UIConstant.UI_COLOR_GrayTheme
        return authorLabel
    }()
    
    /// 底部分割线
    private lazy var cellBottomLine: CALayer = {
        var cellBottomLine = CALayer()
        cellBottomLine.backgroundColor = UIConstant.UI_COLOR_GrayTheme.CGColor
        return cellBottomLine
    }()
}