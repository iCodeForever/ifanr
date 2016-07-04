//
//  PlayingZhiTableViewCell.swift
//  ifanr
//
//  Created by sys on 16/7/3.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

class PlayingZhiTableViewCell: UITableViewCell, Reusable {
 
    //MARK:-----variables-----
    var model : NewsFlashModel! {
        didSet {
            
        }
    }
    
    //MARK:-----init-----
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.logoImageView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.likeCountLabel)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.infoLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:-----setter or getter-----
    // 封面
    private lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        return logoImageView
    }()
    // 时间
    private lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        return timeLabel
    }()
    // 点赞的数目
    private lazy var likeCountLabel: UILabel = {
        let likeCountLabel = UILabel()
        return likeCountLabel
    }()
    // 标题，需动态计算高度
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    // 粗略信息，固定两行
    private lazy var infoLabel: UILabel = {
        let infoLabel = UILabel()
        return infoLabel
    }()
    
    //MARK:-----custom function-----
    //布局
    private func setupLayout() -> Void {
        
    }
   
    
    class func cellWithTableView(tableView : UITableView) -> PlayingZhiTableViewCell {
        
        var cell: PlayingZhiTableViewCell? = tableView.dequeueReusableCell() as PlayingZhiTableViewCell?
        if cell == nil {
            cell = PlayingZhiTableViewCell(style: .Default, reuseIdentifier: self.reuseIdentifier)
            cell?.selectionStyle = .None
        }
        return cell!
    }
    
    // 计算内容的高度
    class func estimateCellHeight(content : String) -> CGFloat {
        let size = CGSizeMake(UIConstant.SCREEN_WIDTH - 64 ,2000)
        
        let attrs = NSMutableAttributedString(string: content)
        let paragphStyle = NSMutableParagraphStyle()
        
        paragphStyle.lineSpacing = 5.0;
        paragphStyle.firstLineHeadIndent    = 0.0;
        paragphStyle.hyphenationFactor      = 0.0;
        paragphStyle.paragraphSpacingBefore = 0.0;
        
        let dic = [NSFontAttributeName : UIFont.systemFontOfSize(16),
                   NSParagraphStyleAttributeName: paragphStyle,
                   NSKernAttributeName : 1.0]
        
        
        attrs.addAttribute(NSFontAttributeName,
                           value: UIFont.systemFontOfSize(16),
                           range: NSMakeRange(0, (content.characters.count)))
        attrs.addAttribute(NSParagraphStyleAttributeName, value: paragphStyle, range: NSMakeRange(0, (content.characters.count)))
        attrs.addAttribute(NSKernAttributeName, value: 1.0, range: NSMakeRange(0, (content.characters.count)))
        
        let labelRect : CGRect = content.boundingRectWithSize(size, options: .UsesLineFragmentOrigin, attributes: dic as [String : AnyObject], context: nil)
        
        // 50为其他控件的高度
        return labelRect.height + 50;
    }
    
}
