//
//  MindStoreTableViewCell.swift
//  ifanr
//
//  Created by sys on 16/7/8.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

class MindStoreTableViewCell: UITableViewCell, Reusable {

    //MARK:-----Init-----
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.userInteractionEnabled = true
        self.contentView.userInteractionEnabled = true
        
        self.contentView.addSubview(self.voteBtn)
        self.contentView.addSubview(self.voteNumberLabel)
        self.contentView.addSubview(self.tagLineLabel)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.relatedImg1)
        self.contentView.addSubview(self.relatedImg2)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:-----Variables-----
    var model : MindStoreModel! {
        didSet {
            self.titleLabel.attributedText      = UILabel.setAttributText(model.title, lineSpcae: 5.0)
            self.tagLineLabel.attributedText    = UILabel.setAttributText(model.tagline, lineSpcae: 5.0);
           
//            if model.relatedImageModelArr.count == 1 {
//                self.relatedImg1.if_setImage(NSURL(string: model.relatedImageModelArr[0].link!))
//                self.relatedImg2.image = UIImage(named: "ic_mind_store_like")
//            } else if model.relatedImageModelArr.count == 2 {
//                self.relatedImg1.if_setImage(NSURL(string: model.relatedImageModelArr[0].link!))
//                self.relatedImg2.if_setImage(NSURL(string: model.relatedImageModelArr[1].link!))
//            } else {
//                self.relatedImg1.image = UIImage(named: "ic_mind_store_comment")
//                self.relatedImg2.image = UIImage(named: "ic_mind_store_like")
//            }
            self.relatedImg1.if_setAvatarImage(NSURL(string: model.createdByModel.avatar_url))
            self.relatedImg2.image = UIImage(named: "mind_store_comment_background")
            
            self.voteBtn.imageView?.image = UIImage(imageLiteral: "mind_store_vote_background_voted_false")
            self.voteNumberLabel.text = "\(model.vote_user_count)"
            
            self.setupLayout()
        }
    }
    
    //MARK:-----Action-----
    @objc private func toVote(btn: UIButton) {
        if btn.selected {
            btn.selected = false
            let num: Int = Int(self.voteNumberLabel.text!)! - 1;
            self.voteNumberLabel.text = "\(num)"
            self.voteNumberLabel.textColor = UIColor(colorLiteralRed: 41/255.0,
                                                     green: 173/255.0, blue: 169/255.0, alpha: 1)
        } else {
            btn.selected = true
            let num: Int = Int(self.voteNumberLabel.text!)! + 1;
            self.voteNumberLabel.text = "\(num)"
            self.voteNumberLabel.textColor = UIColor.whiteColor()
        }
    }
    
    //MARK:-----Private Function-----
    private func setupLayout() -> Void {
        //
        // voteBtn - - -  - - - -
        // - - - - titlelabel   -
        // - - - - tagLineLabel -
        // - - - - rImg1-rImg2 - -
        //
        self.voteBtn.snp_makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(UIConstant.UI_MARGIN_20)
            make.left.equalTo(self.contentView).offset(UIConstant.UI_MARGIN_15)
            make.width.equalTo(35)
            make.height.equalTo(45)
        }
        
        self.voteNumberLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.voteBtn.snp_top).offset(20)
            make.left.equalTo(self.voteBtn.snp_left).offset(3)
            make.right.equalTo(self.voteBtn.snp_right).offset(-3)
            make.bottom.equalTo(self.voteBtn.snp_bottom).offset(-3)
        }
        
        self.relatedImg1.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.contentView).offset(-UIConstant.UI_MARGIN_20)
            make.left.equalTo(self.voteBtn.snp_right).offset(UIConstant.UI_MARGIN_15)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        self.relatedImg2.snp_makeConstraints { (make) in
            make.bottom.equalTo(relatedImg1)
            make.left.equalTo(self.relatedImg1.snp_right).offset(UIConstant.UI_MARGIN_5)
            make.size.equalTo(relatedImg1)
        }
        
        self.titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.voteBtn.snp_right).offset(UIConstant.UI_MARGIN_15)
            make.right.equalTo(self.contentView).offset(-UIConstant.UI_MARGIN_15)
            make.top.equalTo(self.contentView).offset(UIConstant.UI_MARGIN_20)
            make.bottom.equalTo(self.tagLineLabel.snp_top).offset(-UIConstant.UI_MARGIN_10)
        }
        
        self.tagLineLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.voteBtn.snp_right).offset(UIConstant.UI_MARGIN_15)
            make.right.equalTo(self.contentView).offset(-UIConstant.UI_MARGIN_15)
            make.bottom.equalTo(self.relatedImg1.snp_top).offset(-UIConstant.UI_MARGIN_10)
        }
        
        // 设置拉伸的优先级，titleLabel默认不拉伸
        self.titleLabel.setContentHuggingPriority(UILayoutPriorityDefaultHigh, forAxis: .Vertical)
        self.tagLineLabel.setContentHuggingPriority(UILayoutPriorityDefaultLow, forAxis: .Vertical)
        
        self.relatedImg1.contentMode    = .ScaleAspectFill
        self.relatedImg1.layer.cornerRadius     = 10
        self.relatedImg1.layer.masksToBounds    = true
        self.relatedImg1.clipsToBounds  = true
        
        self.relatedImg2.contentMode    = .ScaleAspectFill
//        self.relatedImg2.clipsToBounds  = true
//        self.relatedImg2.layer.cornerRadius = 10
//        self.relatedImg2.layer.masksToBounds = true
        
    }
    
    class func cellWithTableView(tableView : UITableView) -> MindStoreTableViewCell {
        
        var cell: MindStoreTableViewCell? = tableView.dequeueReusableCell() as MindStoreTableViewCell?
        if cell == nil {
            cell = MindStoreTableViewCell(style: .Default, reuseIdentifier: self.reuseIdentifier)
            cell?.selectionStyle = .None
        }
        return cell!
    }
    
    // 动态label的高度
    class func estimateLabelHeight (content: String, font: UIFont) -> CGFloat {
        
        let size    = CGSizeMake(UIConstant.SCREEN_WIDTH - 80 ,2000)
        let paragphStyle = NSMutableParagraphStyle()
        
        paragphStyle.lineSpacing = 5.0;
        paragphStyle.firstLineHeadIndent    = 0.0;
        paragphStyle.hyphenationFactor      = 0.0;
        paragphStyle.paragraphSpacingBefore = 0.0;
        
        let dic = [NSFontAttributeName : font,
                   NSParagraphStyleAttributeName: paragphStyle,
                   NSKernAttributeName : 1.0]
        
        let labelRect : CGRect = content.boundingRectWithSize(size, options: .UsesLineFragmentOrigin, attributes: dic as [String : AnyObject], context: nil)
        
        return labelRect.height
    }
    
    // 动态计算 titleLabel/tagLineLabel 的高度
    class func estimateCellHeight(title : String, tagline: String) -> CGFloat {
        
        return estimateLabelHeight(title, font: UIFont.customFont_FZLTXIHJW(fontSize: 16)) +
            estimateLabelHeight(tagline, font: UIFont.customFont_FZLTZCHJW(fontSize: 12)) + 80
    }
    
    //MARK:-----Setter Getter-----
    // vote button
    private lazy var voteBtn: UIButton = {
        let voteBtn = UIButton()
        voteBtn.setImage(UIImage(imageLiteral: "mind_store_vote_background_voted_false"), forState: .Normal)
        voteBtn.setImage(UIImage(imageLiteral: "mind_store_vote_background_voted_true"),forState: .Selected)
        voteBtn.addTarget(self, action: #selector(toVote), forControlEvents: .TouchUpInside)
        return voteBtn
    }()
    // vote label
    private lazy var voteNumberLabel: UILabel = {
        let voteNumberLabel = UILabel()
        voteNumberLabel.font = UIFont.customFont_FZLTZCHJW(fontSize: 13)
        voteNumberLabel.textAlignment = .Center
        voteNumberLabel.textColor = UIColor(colorLiteralRed: 41/255.0,
                                            green: 173/255.0, blue: 169/255.0, alpha: 1)
        return voteNumberLabel
    }()
    // 标题，需动态计算高度
    private lazy var titleLabel: UILabel = {
        let titleLabel  = UILabel()
        titleLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 16)
        titleLabel.numberOfLines    = 0
        titleLabel.lineBreakMode    = .ByWordWrapping
        return titleLabel
    }()
    // 粗略信息，动态计算高度
    private lazy var tagLineLabel: UILabel = {
        let tagLineLabel = UILabel()
        tagLineLabel.numberOfLines     = 0
        tagLineLabel.lineBreakMode     = .ByCharWrapping
        tagLineLabel.font      = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        tagLineLabel.textColor = UIColor.lightGrayColor()
        return tagLineLabel
    }()
    // related imageview
    private lazy var relatedImg1: UIImageView = {
        let relatedImg1 = UIImageView()
        return relatedImg1
    }()
    private lazy var relatedImg2: UIImageView = {
        let relatedImg2 = UIImageView()
        return relatedImg2
    }()
}
