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
    var model : CommonModel! {
        didSet {
            
            self.timeLabel.text = NSDate.getCommonExpressionOfDate(model.pubDate)
            self.likeCountLabel.text    = "\(model.like)"
            
            self.titleLabel.attributedText = UILabel.setAttributText(model.title, lineSpcae: 5.0)
            self.infoLabel.attributedText  = UILabel.setAttributText(model.excerpt, lineSpcae: 5.0)
            self.logoImageView.if_setImage(NSURL(string: model.image!))
        }
    }
    
    var appSoModel: CommonModel! {
        didSet {
            
            self.timeLabel.text = NSDate.getCommonExpressionOfDate(appSoModel.pubDate)
            self.likeCountLabel.text    = "\(appSoModel.like)"
            
            self.titleLabel.attributedText = UILabel.setAttributText(appSoModel.title, lineSpcae: 5.0)
            self.infoLabel.attributedText  = UILabel.setAttributText(appSoModel.excerpt, lineSpcae: 5.0)
            self.logoImageView.if_setImage(NSURL(string: appSoModel.image!))
        }
    }
    
    //MARK:-----init-----
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.logoImageView)
        self.contentView.addSubview(self.timeLabel)
        self.contentView.addSubview(self.likeCountLabel)
        self.contentView.addSubview(self.heartImgView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.infoLabel)
        self.contentView.addSubview(self.separateLineView)
        
        self.setupLayout()
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
        timeLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        timeLabel.textColor = UIColor.lightGrayColor()
        return timeLabel
    }()
    // 点赞的数目
    private lazy var likeCountLabel: UILabel = {
        let likeCountLabel = UILabel()
        likeCountLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        likeCountLabel.textColor = UIColor.lightGrayColor()
        return likeCountLabel
    }()
    //点赞左侧的心
    private lazy var heartImgView: UIImageView = {
        let heartImgView = UIImageView()
        heartImgView.image = UIImage(imageLiteral: "heart_selected_false")
        return heartImgView
    }()
    // 标题，需动态计算高度
    private lazy var titleLabel: UILabel = {
        let titleLabel  = UILabel()
        titleLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 16)
        titleLabel.numberOfLines    = 0
        titleLabel.lineBreakMode    = .ByWordWrapping
        return titleLabel
    }()
    // 粗略信息，固定两行
    private lazy var infoLabel: UILabel = {
        let infoLabel = UILabel()
        infoLabel.numberOfLines     = 0
        infoLabel.lineBreakMode     = .ByCharWrapping
        infoLabel.font      = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        infoLabel.textColor = UIColor.lightGrayColor()
        return infoLabel
    }()
    // 小黄线
    private lazy var separateLineView: UIView = {
        let separateLineView = UIView()
        separateLineView.backgroundColor = UIColor.brownColor()
        return separateLineView
    }()
    
    //MARK:-----custom function-----
    //布局
    private func setupLayout() -> Void {
        self.logoImageView.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(UIConstant.UI_MARGIN_20)
            make.left.equalTo(self).offset(UIConstant.UI_MARGIN_15)
            make.right.equalTo(self).offset(-1 * UIConstant.UI_MARGIN_15)
            make.height.equalTo(170).priority(1000)
        }
        self.timeLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.logoImageView.snp_bottom).offset(UIConstant.UI_MARGIN_10)
            make.left.equalTo(self).offset(UIConstant.UI_MARGIN_15)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        self.likeCountLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.timeLabel)
            make.right.equalTo(self).offset(-1 * UIConstant.UI_MARGIN_15)
            make.width.height.equalTo(20)
        }
        self.heartImgView.snp_makeConstraints { (make) in
            make.right.equalTo(self.likeCountLabel.snp_left).offset(-UIConstant.UI_MARGIN_5)
            make.centerY.equalTo(self.timeLabel)
            make.width.height.equalTo(10)
        }
        self.separateLineView.snp_makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-UIConstant.UI_MARGIN_5)
            make.centerX.equalTo(self)
            make.width.equalTo(20)
            make.height.equalTo(2)
        }
        self.infoLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.separateLineView.snp_top).offset(-UIConstant.UI_MARGIN_10)
            make.left.equalTo(self).offset(UIConstant.UI_MARGIN_15)
            make.right.equalTo(self).offset(-1 * UIConstant.UI_MARGIN_15)
            make.height.equalTo(50)
        }
        self.titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(UIConstant.UI_MARGIN_15)
            make.right.equalTo(self).offset(-UIConstant.UI_MARGIN_15)
            make.bottom.equalTo(self.infoLabel.snp_top)
            make.top.equalTo(self.likeCountLabel.snp_bottom)
        }
        
        self.logoImageView.contentMode      = .ScaleAspectFill
        self.logoImageView.clipsToBounds    = true
        self.heartImgView.contentMode       = .ScaleAspectFill
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
        let size = CGSizeMake(UIConstant.SCREEN_WIDTH - 30 ,2000)
        
        let attrs = NSMutableAttributedString(string: content)
        let paragphStyle = NSMutableParagraphStyle()
        
        paragphStyle.lineSpacing = 5.0;
        paragphStyle.firstLineHeadIndent    = 0.0;
        paragphStyle.hyphenationFactor      = 0.0;
        paragphStyle.paragraphSpacingBefore = 0.0;
        
        let dic = [NSFontAttributeName : UIFont.customFont_FZLTXIHJW(fontSize: 16),
                   NSParagraphStyleAttributeName: paragphStyle,
                   NSKernAttributeName : 1.0]
        
        
        attrs.addAttribute(NSFontAttributeName,
                           value: UIFont.customFont_FZLTXIHJW(fontSize: 16),
                           range: NSMakeRange(0, (content.characters.count)))
        attrs.addAttribute(NSParagraphStyleAttributeName, value: paragphStyle, range: NSMakeRange(0, (content.characters.count)))
        attrs.addAttribute(NSKernAttributeName, value: 1.0, range: NSMakeRange(0, (content.characters.count)))
        
        let labelRect : CGRect = content.boundingRectWithSize(size, options: .UsesLineFragmentOrigin, attributes: dic as [String : AnyObject], context: nil)
        
        // 50为其他控件的高度
        return labelRect.height + 280;
    }
    
}
