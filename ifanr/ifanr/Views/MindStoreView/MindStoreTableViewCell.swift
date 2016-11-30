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
        
        self.isUserInteractionEnabled = true
        self.contentView.isUserInteractionEnabled = true
        
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
            self.relatedImg1.if_setAvatarImage(URL(string: model.createdByModel.avatar_url))
            self.relatedImg2.image = UIImage(named: "mind_store_comment_background")
            
            self.voteBtn.imageView?.image = UIImage(named: "mind_store_vote_background_voted_false")
            self.voteNumberLabel.text = "\(model.vote_user_count)"
            
            self.setupLayout()
        }
    }
    
    //MARK:-----Action-----
    @objc fileprivate func toVote(_ btn: UIButton) {
        if btn.isSelected {
            btn.isSelected = false
            let num: Int = Int(self.voteNumberLabel.text!)! - 1;
            self.voteNumberLabel.text = "\(num)"
            self.voteNumberLabel.textColor = UIColor(colorLiteralRed: 41/255.0,
                                                     green: 173/255.0, blue: 169/255.0, alpha: 1)
        } else {
            btn.isSelected = true
            let num: Int = Int(self.voteNumberLabel.text!)! + 1;
            self.voteNumberLabel.text = "\(num)"
            self.voteNumberLabel.textColor = UIColor.white
        }
    }
    
    //MARK:-----Private Function-----
    fileprivate func setupLayout() -> Void {
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
        self.titleLabel.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .vertical)
        self.tagLineLabel.setContentHuggingPriority(UILayoutPriorityDefaultLow, for: .vertical)
        
        self.relatedImg1.contentMode    = .scaleAspectFill
        self.relatedImg1.layer.cornerRadius     = 10
        self.relatedImg1.layer.masksToBounds    = true
        self.relatedImg1.clipsToBounds  = true
        
        self.relatedImg2.contentMode    = .scaleAspectFit
//        self.relatedImg2.clipsToBounds  = true
//        self.relatedImg2.layer.cornerRadius = 10
//        self.relatedImg2.layer.masksToBounds = true
        
    }
    
    class func cellWithTableView(_ tableView : UITableView) -> MindStoreTableViewCell {
        
        var cell: MindStoreTableViewCell? = tableView.dequeueReusableCell() as MindStoreTableViewCell?
        if cell == nil {
            cell = MindStoreTableViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
            cell?.selectionStyle = .none
        }
        return cell!
    }
    
    // 动态label的高度
    class func estimateLabelHeight (_ content: String, font: UIFont) -> CGFloat {
        
        let size    = CGSize(width: UIConstant.SCREEN_WIDTH - 80 ,height: 2000)
        let paragphStyle = NSMutableParagraphStyle()
        
        paragphStyle.lineSpacing = 5.0;
        paragphStyle.firstLineHeadIndent    = 0.0;
        paragphStyle.hyphenationFactor      = 0.0;
        paragphStyle.paragraphSpacingBefore = 0.0;
        
        let dic = [NSFontAttributeName : font,
                   NSParagraphStyleAttributeName: paragphStyle,
                   NSKernAttributeName : 1.0] as [String : Any]
        
        let labelRect : CGRect = content.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as [String : AnyObject], context: nil)
        
        return labelRect.height
    }
    
    // 动态计算 titleLabel/tagLineLabel 的高度
    class func estimateCellHeight(_ title : String, tagline: String) -> CGFloat {
        
        return estimateLabelHeight(title, font: UIFont.customFont_FZLTXIHJW(fontSize: 16)) +
            estimateLabelHeight(tagline, font: UIFont.customFont_FZLTZCHJW(fontSize: 12)) + 80
    }
    
    //MARK:-----Setter Getter-----
    // vote button
    fileprivate lazy var voteBtn: UIButton = {
        let voteBtn = UIButton()
        voteBtn.setImage(UIImage(named: "mind_store_vote_background_voted_false"), for: UIControlState())
        voteBtn.setImage(UIImage(named: "mind_store_vote_background_voted_true"), for: .selected)
        voteBtn.addTarget(self, action: #selector(toVote), for: .touchUpInside)
        return voteBtn
    }()
    // vote label
    fileprivate lazy var voteNumberLabel: UILabel = {
        let voteNumberLabel = UILabel()
        voteNumberLabel.font = UIFont.customFont_FZLTZCHJW(fontSize: 13)
        voteNumberLabel.textAlignment = .center
        voteNumberLabel.textColor = UIColor(colorLiteralRed: 41/255.0,
                                            green: 173/255.0, blue: 169/255.0, alpha: 1)
        return voteNumberLabel
    }()
    // 标题，需动态计算高度
    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel  = UILabel()
        titleLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 16)
        titleLabel.numberOfLines    = 0
        titleLabel.lineBreakMode    = .byWordWrapping
        return titleLabel
    }()
    // 粗略信息，动态计算高度
    fileprivate lazy var tagLineLabel: UILabel = {
        let tagLineLabel = UILabel()
        tagLineLabel.numberOfLines     = 0
        tagLineLabel.lineBreakMode     = .byCharWrapping
        tagLineLabel.font      = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        tagLineLabel.textColor = UIColor.lightGray
        return tagLineLabel
    }()
    // related imageview
    fileprivate lazy var relatedImg1: UIImageView = {
        let relatedImg1 = UIImageView()
        return relatedImg1
    }()
    fileprivate lazy var relatedImg2: UIImageView = {
        let relatedImg2 = UIImageView()
        return relatedImg2
    }()
}
