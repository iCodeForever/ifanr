//
//  NewsFlashTableViewCell.swift
//  ifanr
//
//  Created by sys on 16/6/30.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

class NewsFlashTableViewCell: UITableViewCell, Reusable {
    
    //MARK:-----init-----

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(pointView)
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(contentLable)
        self.contentView.addSubview(sourceLabel)
        
        self.setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:-----
    
    var model : HomePopularModel! {
        didSet {
            
            let timeInterval = (NSDate.getTimeIntervalFromNow(model.pubDate!) * -1)/60/60
            if timeInterval < 24 {
                self.timeLabel.text = "\(Int(timeInterval)) 小时前"
            } else if timeInterval < 48 {
                let range = NSRange(location: 10, length: 5)
                self.timeLabel.text = "昨天 " + (model.pubDate! as NSString).substringWithRange(range)
            } else if timeInterval < 72 {
                let range = NSRange(location: 10, length: 5)
                self.timeLabel.text = "前天 " + (model.pubDate! as NSString).substringWithRange(range)
            } else {
                self.timeLabel.text = model.pubDate
            }
            
            // 设置行间距
            let attrs = NSMutableAttributedString(string: model.title!)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5.0
            attrs.addAttribute(NSParagraphStyleAttributeName,
                               value: paragraphStyle,
                               range: NSMakeRange(0, ((model.title)!.characters.count)))
            self.contentLable.attributedText = attrs
            
            self.sourceLabel.text   = "来源：" + (model.excerpt?.componentsSeparatedByString("/")[2])!
        }
    }
    
    class func cellWithTableView(tableView : UITableView) -> NewsFlashTableViewCell {
        var cell: NewsFlashTableViewCell? = tableView.dequeueReusableCell() as NewsFlashTableViewCell?
        if cell == nil {
            cell = NewsFlashTableViewCell(style: .Default, reuseIdentifier: self.reuseIdentifier)
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
    
    //MARK:-----getter or setter-----
    
    private lazy var timeLabel : UILabel = {
        //时间
        let timeLabel   = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        timeLabel.font  = UIConstant.UI_FONT_13
        timeLabel.textColor = UIColor.lightGrayColor()
        return timeLabel;
        
    }()
    
    private lazy var pointView : UIView = {
        //小红点
        let pointView    = UIView()

        return pointView;
    }()
    
    private lazy var contentLable : UILabel = {
        let contentLable    = UILabel()
        contentLable.font   = UIConstant.UI_FONT_16
        contentLable.numberOfLines = 0
        contentLable.lineBreakMode = .ByWordWrapping
        
        return contentLable
    }()
    
    private lazy var sourceLabel : UILabel = {
        let sourceLabel     = UILabel()
        sourceLabel.font    = UIConstant.UI_FONT_12
        sourceLabel.textColor = UIColor.lightGrayColor()
        return sourceLabel
    }()
    
    //MARK:-----Private Function----
    func setUpLayout() -> Void {
        
        self.pointView.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(UIConstant.UI_MARGIN_12)
            make.top.equalTo(self).offset(20)
            make.height.width.equalTo(8)
        }
        
        self.timeLabel.snp_makeConstraints { (make) in
            make.left.equalTo(pointView.snp_right).offset(UIConstant.UI_MARGIN_12)
            make.right.equalTo(self).offset(32)
            make.centerY.equalTo(self.pointView)
            make.height.equalTo(20)
        }
        
        self.contentLable.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(32)
            make.right.equalTo(self).offset(-32)
            make.top.equalTo(self.timeLabel.snp_bottom).offset(5)
            make.bottom.equalTo(self.sourceLabel.snp_top).offset(-5)
        }
        
        self.sourceLabel.snp_makeConstraints { (make) in
            make.left.right.equalTo(self).offset(32)
            make.bottom.equalTo(self).offset(-15)
            make.height.equalTo(20)
        }
        
        self.pointView.layer.cornerRadius = 4
        self.pointView.backgroundColor = UIColor(red: 211/255.0, green: 55/255.0, blue: 38/255.0, alpha: 1.0)
    }
}
