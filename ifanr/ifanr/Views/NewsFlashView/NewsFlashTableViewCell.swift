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
    var model : CommonModel! {
        didSet {
            
            self.timeLabel.text = Date.getCommonExpressionOfDate(model.pubDate)
            // 设置行间距
            let attrs = NSMutableAttributedString(string: model.title!)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5.0
            attrs.addAttribute(NSParagraphStyleAttributeName,
                               value: paragraphStyle,
                               range: NSMakeRange(0, ((model.title)!.characters.count)))
            self.contentLable.attributedText = attrs
            
            self.sourceLabel.text   = "来源：" + (model.excerpt?.components(separatedBy: "/")[2])!
//            self.sourceLabel.text = "来源:"
        }
    }
    
    //MARK:-----Private Function----
    class func cellWithTableView(_ tableView : UITableView) -> NewsFlashTableViewCell {
        var cell: NewsFlashTableViewCell? = tableView.dequeueReusableCell() as NewsFlashTableViewCell?
        if cell == nil {
            cell = NewsFlashTableViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
            cell?.selectionStyle = .none
        }
        return cell!
    }
    
    // 计算内容的高度
    class func estimateCellHeight(_ content : String) -> CGFloat {
        let size = CGSize(width: UIConstant.SCREEN_WIDTH - 64 ,height: 2000)
        
        let attrs = NSMutableAttributedString(string: content)
        let paragphStyle = NSMutableParagraphStyle()
        
        paragphStyle.lineSpacing = 5.0;
        paragphStyle.firstLineHeadIndent    = 0.0;
        paragphStyle.hyphenationFactor      = 0.0;
        paragphStyle.paragraphSpacingBefore = 0.0;
        
        let dic = [NSFontAttributeName : UIFont.customFont_FZLTXIHJW(fontSize: 16),
                   NSParagraphStyleAttributeName: paragphStyle,
                   NSKernAttributeName : 1.0] as [String : Any]
        
        
        attrs.addAttribute(NSFontAttributeName,
                           value: UIFont.customFont_FZLTXIHJW(fontSize: 16),
                           range: NSMakeRange(0, (content.characters.count)))
        attrs.addAttribute(NSParagraphStyleAttributeName, value: paragphStyle, range: NSMakeRange(0, (content.characters.count)))
        attrs.addAttribute(NSKernAttributeName, value: 1.0, range: NSMakeRange(0, (content.characters.count)))
        
        let labelRect : CGRect = content.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as [String : AnyObject], context: nil)
        
        // 50为其他控件的高度
        return labelRect.height + 50;
    }
    
    func setUpLayout() {
        
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
    
    //MARK:-----Getter Setter-----
    fileprivate lazy var timeLabel : UILabel = {
        //时间
        let timeLabel   = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        timeLabel.font  = UIFont.customFont_FZLTXIHJW(fontSize: 13)
        timeLabel.textColor = UIColor.lightGray
        return timeLabel;
        
    }()
    
    fileprivate lazy var pointView : UIView = {
        //小红点
        let pointView    = UIView()

        return pointView;
    }()
    
    fileprivate lazy var contentLable : UILabel = {
        let contentLable    = UILabel()
        contentLable.font   = UIFont.customFont_FZLTXIHJW(fontSize: 16)
        contentLable.numberOfLines = 0
        contentLable.lineBreakMode = .byWordWrapping
        
        return contentLable
    }()
    
    fileprivate lazy var sourceLabel : UILabel = {
        let sourceLabel     = UILabel()
        sourceLabel.font    = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        sourceLabel.textColor = UIColor.lightGray
        return sourceLabel
    }()
}
