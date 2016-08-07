//
//  commentCell.swift
//  ifanr
//
//  Created by sys on 16/8/6.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell, Reusable {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
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
                self.timeLabel.text = (model?.from_app_name)! + NSDate.getCommonExpressionOfDate(dateStr)
            }
            if let url = model?.avatar {
                self.avatarImageView.if_setImage(NSURL(string: url))
            }
            
            self.setupLayout(true)
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
    func buttonAction(sender: AnyObject) {
        let btn: UIButton = (sender as! UIButton)
        if btn.selected {
            btn.selected = false
        } else {
            btn.selected = true
        }
    }

    //MARK:-----Private Function-----
    class func cellWithTableView(tableView : UITableView) -> CommentTableViewCell {
        
        var cell: CommentTableViewCell? = tableView.dequeueReusableCell() as CommentTableViewCell?
        if cell == nil {
            cell = CommentTableViewCell(style: .Default, reuseIdentifier: self.reuseIdentifier)
            cell?.selectionStyle = .None
        }
        return cell!
    }
    
    // 计算内容的高度
    class func estimateCellHeight(content : String, font: UIFont, size: CGSize) -> CGFloat {
        
        let paragphStyle = NSMutableParagraphStyle()
        paragphStyle.lineSpacing = 5.0;
        paragphStyle.firstLineHeadIndent    = 0.0;
        paragphStyle.hyphenationFactor      = 0.0;
        paragphStyle.paragraphSpacingBefore = 0.0;
        
        let dic = [NSFontAttributeName : font,
                   NSParagraphStyleAttributeName: paragphStyle,
                   NSKernAttributeName : 1.0]
        
        
        let labelRect : CGRect = content.boundingRectWithSize(size, options: .UsesLineFragmentOrigin, attributes: dic as [String : AnyObject], context: nil)
        
        return labelRect.height + 80
    }
    
    //设置布局
    internal func setupLayout(isBig: Bool) {
        if isBig {
            self.avatarImageView.snp_makeConstraints { (make) in
                make.top.equalTo(self.contentView).offset(15)
                make.left.equalTo(self.contentView).offset(20)
                make.width.height.equalTo(40)
            }
        } else {
            self.avatarImageView.snp_makeConstraints { (make) in
                make.top.equalTo(self.contentView).offset(15)
                make.left.equalTo(self.contentView).offset(45)
                make.width.height.equalTo(40)
            }
        }
        self.nameLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.avatarImageView.snp_centerY).offset(-1)
            make.left.equalTo(self.avatarImageView.snp_right).offset(10)
        }
        self.timeLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.avatarImageView.snp_centerY).offset(1)
            make.left.equalTo(self.avatarImageView.snp_right).offset(10)
        }
        self.trampleNumLabel.snp_makeConstraints { (make) in
            make.right.equalTo(self.contentView)
            make.centerY.equalTo(self.avatarImageView)
            make.width.equalTo(20)
            make.height.equalTo(30)
        }
        self.trampleButton.snp_makeConstraints { (make) in
            make.right.equalTo(self.trampleNumLabel.snp_left).offset(-2)
            make.centerY.equalTo(self.avatarImageView)
            make.width.height.equalTo(8)
        }
        self.praiseNumLabel.snp_makeConstraints { (make) in
            make.right.equalTo(self.trampleButton).offset(-15)
            make.centerY.equalTo(self.avatarImageView)
            make.width.equalTo(20)
            make.height.equalTo(30)
        }
        self.praiseButton.snp_makeConstraints { (make) in
            make.right.equalTo(self.praiseNumLabel.snp_left).offset(-2)
            make.centerY.equalTo(self.avatarImageView)
            make.width.height.equalTo(8)
        }
        self.contentLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.avatarImageView.snp_bottom).offset(20)
            make.left.equalTo(self.avatarImageView)
            make.right.equalTo(self.contentView).offset(-15)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
    }
    
    //MARK:-----Getter Setter-----
    internal lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .ScaleAspectFit
        avatarImageView.layer.cornerRadius = 20
        avatarImageView.layer.masksToBounds = true
        return avatarImageView
    }()
    
    internal lazy var nameLabel: UILabel = {
        let nameLabel: UILabel = UILabel()
        nameLabel.font = UIFont.systemFontOfSize(14)
        return nameLabel
    }()
    
    internal lazy var timeLabel: UILabel = {
        let timeLabel: UILabel = UILabel()
        timeLabel.font = UIFont.systemFontOfSize(12)
        timeLabel.textColor = UIColor.lightGrayColor()
        return timeLabel
    }()
    
    internal lazy var praiseNumLabel: UILabel = {
        let praiseNumLabel = UILabel()
        praiseNumLabel.font = UIFont.systemFontOfSize(12)
        return praiseNumLabel
    }()
    
    internal lazy var praiseButton: UIButton = {
        let praiseButton = UIButton()
        praiseButton.setImage(UIImage(named:"comment_rating_up_grey"), forState: .Normal)
        praiseButton.setImage(UIImage(named:"comment_rating_up_red"), forState: .Selected)
        praiseButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        return praiseButton
    }()
    
    internal lazy var trampleNumLabel: UILabel = {
        let trampleNumLabel  = UILabel()
        trampleNumLabel.font = UIFont.systemFontOfSize(12)
        return trampleNumLabel
    }()
    
    internal lazy var trampleButton: UIButton = {
        let trampleButton = UIButton()
        trampleButton.setImage(UIImage(named:"comment_rating_down_grey"), forState: .Normal)
        trampleButton.setImage(UIImage(named:"comment_rating_down_black"), forState: .Selected)
        trampleButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        return trampleButton
    }()
    
    internal lazy var contentLabel: UILabel = {
        let contentLabel  = UILabel()
        contentLabel.font = UIFont.systemFontOfSize(13)
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .ByWordWrapping
        return contentLabel
    }()
}
