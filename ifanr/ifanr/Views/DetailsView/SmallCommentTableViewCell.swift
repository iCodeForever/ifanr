//
//  SmallCommentTableViewCell.swift
//  ifanr
//
//  Created by sys on 16/8/7.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

class SmallCommentTableViewCell: UITableViewCell, Reusable {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    //MARK:-----Variables-----
    var model: CommentModel? {
        didSet{
            self.contentLabel.attributedText = UILabel.setAttributText(model?.comment_content, lineSpcae: 5.0)
            self.nameLabel.text = model?.comment_author
            self.praiseNumLabel.text  = model?.comment_rating_up
            self.trampleNumLabel.text = model?.comment_rating_down
            
            if let dateStr = model?.comment_date {
                self.timeLabel.text = (model?.from_app_name)! + Date.getCommonExpressionOfDate(dateStr)
            }
            if let url = model?.avatar {
                self.avatarImageView.if_setImage(URL(string: url))
            }
            
            self.setupLayout(false)
        }
    }
    
    //MARK:-----init-----
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.avatarImageView)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.timeLabel)
        self.contentView.addSubview(self.praiseNumLabel)
        self.contentView.addSubview(self.praiseButton)
        self.contentView.addSubview(self.trampleNumLabel)
        self.contentView.addSubview(self.trampleButton)
        self.contentView.addSubview(self.contentLabel)
        
        self.backgroundColor = UIColor(red: 250/255.0, green: 247/255.0, blue: 250/255.0, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:-----Action-----
    func buttonAction(_ sender: AnyObject) {
        let btn: UIButton = (sender as! UIButton)
        if btn.isSelected {
            btn.isSelected = false
        } else {
            btn.isSelected = true
        }
    }
    
    //MARK:-----Private Function-----
    class func cellWithTableView(_ tableView : UITableView) -> SmallCommentTableViewCell {
        
        var cell: SmallCommentTableViewCell? = tableView.dequeueReusableCell() as SmallCommentTableViewCell?
        if cell == nil {
            cell = SmallCommentTableViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
            cell?.selectionStyle = .none
        }
        return cell!
    }
    
    // 计算内容的高度
    class func estimateCellHeight(_ content : String, font: UIFont, size: CGSize) -> CGFloat {
        
        let paragphStyle = NSMutableParagraphStyle()
        paragphStyle.lineSpacing = 5.0;
        paragphStyle.firstLineHeadIndent    = 0.0;
        paragphStyle.hyphenationFactor      = 0.0;
        paragphStyle.paragraphSpacingBefore = 0.0;
        
        let dic = [NSFontAttributeName : font,
                   NSParagraphStyleAttributeName: paragphStyle,
                   NSKernAttributeName : 1.0] as [String : Any]
        
        
        let labelRect : CGRect = content.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as [String : AnyObject], context: nil)
        
        return labelRect.height + 80;
    }
    
    //设置布局
    internal func setupLayout(_ isBig: Bool) {
        if isBig {
            self.avatarImageView.snp.makeConstraints { (make) in
                make.top.equalTo(self.contentView).offset(15)
                make.left.equalTo(self.contentView).offset(20)
                make.width.height.equalTo(40)
            }
        } else {
            self.avatarImageView.snp.makeConstraints { (make) in
                make.top.equalTo(self.contentView).offset(15)
                make.left.equalTo(self.contentView).offset(45)
                make.width.height.equalTo(40)
            }
        }
        self.nameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.avatarImageView.snp.centerY).offset(-1)
            make.left.equalTo(self.avatarImageView.snp.right).offset(10)
        }
        self.timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.avatarImageView.snp.centerY).offset(1)
            make.left.equalTo(self.avatarImageView.snp.right).offset(10)
        }
        self.trampleNumLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView)
            make.centerY.equalTo(self.avatarImageView)
            make.width.equalTo(20)
            make.height.equalTo(30)
        }
        self.trampleButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.trampleNumLabel.snp.left).offset(-2)
            make.centerY.equalTo(self.avatarImageView)
            make.width.height.equalTo(8)
        }
        self.praiseNumLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.trampleButton).offset(-15)
            make.centerY.equalTo(self.avatarImageView)
            make.width.equalTo(20)
            make.height.equalTo(30)
        }
        self.praiseButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.praiseNumLabel.snp.left).offset(-2)
            make.centerY.equalTo(self.avatarImageView)
            make.width.height.equalTo(8)
        }
        self.contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.avatarImageView.snp.bottom).offset(20)
            make.left.equalTo(self.avatarImageView)
            make.right.equalTo(self.contentView).offset(-15)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
    }
    
    //MARK:-----Getter Setter-----
    internal lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.layer.cornerRadius = 20
        avatarImageView.layer.masksToBounds = true
        return avatarImageView
    }()
    
    internal lazy var nameLabel: UILabel = {
        let nameLabel: UILabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        return nameLabel
    }()
    
    internal lazy var timeLabel: UILabel = {
        let timeLabel: UILabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = UIColor.lightGray
        return timeLabel
    }()
    
    internal lazy var praiseNumLabel: UILabel = {
        let praiseNumLabel = UILabel()
        praiseNumLabel.font = UIFont.systemFont(ofSize: 12)
        return praiseNumLabel
    }()
    
    internal lazy var praiseButton: UIButton = {
        let praiseButton = UIButton()
        praiseButton.setImage(UIImage(named:"comment_rating_up_grey"), for: UIControlState())
        praiseButton.setImage(UIImage(named:"comment_rating_up_red"), for: .selected)
        praiseButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return praiseButton
    }()
    
    internal lazy var trampleNumLabel: UILabel = {
        let trampleNumLabel  = UILabel()
        trampleNumLabel.font = UIFont.systemFont(ofSize: 12)
        return trampleNumLabel
    }()
    
    internal lazy var trampleButton: UIButton = {
        let trampleButton = UIButton()
        trampleButton.setImage(UIImage(named:"comment_rating_down_grey"), for: UIControlState())
        trampleButton.setImage(UIImage(named:"comment_rating_down_black"), for: .selected)
        trampleButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return trampleButton
    }()
    
    internal lazy var contentLabel: UILabel = {
        let contentLabel  = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 13)
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byWordWrapping
        return contentLabel
    }()
    
}
