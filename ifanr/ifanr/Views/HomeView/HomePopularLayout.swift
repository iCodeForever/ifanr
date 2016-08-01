//
//  HomePopularLayout.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/5.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

/**
 *  cell的布局
 */
struct HomePopularLayout {
    var model: CommonModel!
    // 顶部留白
    let kHomeCellTopMargin = UIConstant.UI_MARGIN_20
    // 左右留白
    let kHomeCellPadding = UIConstant.UI_MARGIN_10
    // 底部高度
    let kHomeCellBottoMInset = UIConstant.UI_MARGIN_20
    
    
    //MARK: --------------------------- 这里是有图片的Rect --------------------------
    // 时间，分类，点赞数高度
    var kHomeCellToolBarHeight: CGFloat = 15
        /// 作者头像大少
    let authorSize: CGFloat = 30
    
        /// 图片Rect 1200x750 8/5
    var kHomeCellPicRect: CGRect = CGRectZero
        /// 标题Rect
    var kHomeCellTitleRect: CGRect = CGRectZero
    
    
    //MARK: --------------------------- 没图片的Rect(大声) --------------------------
    var kHomeCellAuthorImgRect: CGRect = CGRectZero
    var kHomeCellAuthorRect: CGRect = CGRectZero
    
    //MARK: --------------------------- 数读 --------------------------
    var kHomeCellNumberRect: CGRect = CGRectZero
    
    //MARK: --------------------------- 公共部分的Rect --------------------------
    /// 时间，分类Rect
    var kHomeCellDateRect: CGRect = CGRectZero
    /// 喜欢数
    var kHomeCellLikeRect: CGRect = CGRectZero
    var kHomeCellLikeImgRect: CGRect = CGRectZero
    /// 引文Rect
    var kHomeCellTextRect: CGRect = CGRectZero
    // 总高度
    var cellHeight: CGFloat = 0
    
    init(model: CommonModel) {
        self.model = model
        
        if model.post_type == PostType.dasheng {
            self.setupTextLayout()
        } else if model.post_type == PostType.data {
            self.setupDataLayout()
        } else {
            self.setupPostLayout()
        }
    }
    
    
    /**
     有图片的Cell(post)
     */
    private mutating func setupPostLayout() {
        let cellPicWidth = UIConstant.SCREEN_WIDTH-2*kHomeCellPadding
        // 图片的Rect
        self.kHomeCellPicRect = CGRect(x: kHomeCellPadding, y: kHomeCellTopMargin, width: cellPicWidth, height: cellPicWidth*0.625)
        
        // 时间分类Rect
    
        let toolBarY = CGRectGetMaxY(kHomeCellPicRect)+kHomeCellPadding
        let dateSize = calculateDateSize()
        self.kHomeCellDateRect = CGRect(x: kHomeCellPadding, y: toolBarY, width: dateSize.width, height: kHomeCellToolBarHeight)
        
        // 喜欢数
        let likeSize = calculateLikeSize()
        self.kHomeCellLikeRect = CGRect(x: UIConstant.SCREEN_WIDTH-kHomeCellPadding-likeSize.width, y: toolBarY, width: likeSize.width, height: kHomeCellToolBarHeight)
        self.kHomeCellLikeImgRect = CGRect(x: kHomeCellLikeRect.minX-kHomeCellPadding-kHomeCellToolBarHeight, y: toolBarY, width: kHomeCellToolBarHeight, height: kHomeCellToolBarHeight)
        
        // 计算标题高度
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        let titleAttributes = [NSFontAttributeName: UIFont.customFont_FZLTXIHJW(fontSize: 16), NSParagraphStyleAttributeName: paragraphStyle]
        let titleSize = (model.title as NSString).boundingRectWithSize(CGSize(width: cellPicWidth, height: CGFloat.max), options: .UsesLineFragmentOrigin, attributes: titleAttributes, context: nil).size
        self.kHomeCellTitleRect = CGRect(x: kHomeCellPadding, y: kHomeCellLikeRect.maxY+kHomeCellPadding, width: titleSize.width, height: titleSize.height)
        
        // 计算引文高度
        let textAttributes = [NSFontAttributeName: UIFont.customFont_FZLTXIHJW(fontSize: 12), NSParagraphStyleAttributeName: paragraphStyle]
        let textSize = (model.excerpt as NSString).boundingRectWithSize(CGSize(width: cellPicWidth, height: CGFloat.max), options: .UsesLineFragmentOrigin, attributes: textAttributes, context: nil).size
        self.kHomeCellTextRect = CGRect(x: kHomeCellPadding, y: kHomeCellTitleRect.maxY+kHomeCellPadding, width: textSize.width, height: textSize.height)
        
        // 总高度
        self.cellHeight = kHomeCellTextRect.maxY+kHomeCellBottoMInset
    }
    
    /**
     没图片的Cell(大声)
     */
    private mutating func setupTextLayout() {
        let contentWidth = UIConstant.SCREEN_WIDTH-2*kHomeCellPadding
        
        
        // 作者头像
        self.kHomeCellAuthorImgRect = CGRect(x: kHomeCellPadding, y: 2*kHomeCellTopMargin, width: authorSize, height: authorSize)
        
        // 时间和分类
        let dateSize = calculateDateSize()
        self.kHomeCellDateRect = CGRect(x: kHomeCellAuthorImgRect.maxX+kHomeCellPadding, y: kHomeCellAuthorImgRect.minY, width: dateSize.width, height: kHomeCellToolBarHeight)
        
        // 喜欢
        let likeSize = calculateLikeSize()
        self.kHomeCellLikeRect = CGRect(x: UIConstant.SCREEN_WIDTH-kHomeCellPadding-likeSize.width, y: kHomeCellDateRect.minY, width: likeSize.width, height: kHomeCellToolBarHeight)
        self.kHomeCellLikeImgRect = CGRect(x: kHomeCellLikeRect.minX-kHomeCellPadding-kHomeCellToolBarHeight, y: kHomeCellDateRect.minY, width: kHomeCellToolBarHeight, height: kHomeCellToolBarHeight)
        
        // 引文。先分割出作者和内容
        let excerpAttribute = [NSFontAttributeName: UIFont.customFont_FZLTXIHJW(fontSize: 16)]
        let excerpWidth = UIConstant.SCREEN_WIDTH-kHomeCellDateRect.minX-kHomeCellPadding
        let excerptAndAuthor = model.excerpt.componentsSeparatedByString(":")
        let excerptSize = (excerptAndAuthor.last! as NSString).boundingRectWithSize(CGSize(width: excerpWidth, height: CGFloat.max), options: .UsesLineFragmentOrigin, attributes: excerpAttribute, context: nil).size
        self.kHomeCellTextRect = CGRect(x: kHomeCellDateRect.minX, y: kHomeCellTopMargin+kHomeCellDateRect.maxY, width: excerptSize.width, height: excerptSize.height)
        
        // 作者
        let authorText = "—— \(excerptAndAuthor.first)"
        let authorTextSize = (authorText as NSString).boundingRectWithSize(CGSize(width: contentWidth, height: 20), options: .UsesLineFragmentOrigin, attributes: excerpAttribute, context: nil).size
        self.kHomeCellAuthorRect = CGRect(x: kHomeCellPadding, y: kHomeCellTextRect.maxY+kHomeCellTopMargin, width: contentWidth, height: authorTextSize.height)
        
        self.cellHeight = kHomeCellAuthorRect.maxY+2*kHomeCellBottoMInset
    }
    
    /**
     没图片（数读）
     */
    private mutating func setupDataLayout() {
        let contentWidth = UIConstant.SCREEN_WIDTH-2*kHomeCellPadding
        
        // 作者头像
        self.kHomeCellAuthorImgRect = CGRect(x: kHomeCellPadding, y: 2*kHomeCellTopMargin, width: authorSize, height: authorSize)
        
        // 时间和分类
        let dateSize = calculateDateSize()
        self.kHomeCellDateRect = CGRect(x: kHomeCellAuthorImgRect.maxX+kHomeCellPadding, y: kHomeCellAuthorImgRect.minY, width: dateSize.width, height: kHomeCellToolBarHeight)
        
        // 喜欢
        let likeSize = calculateLikeSize()
        self.kHomeCellLikeRect = CGRect(x: UIConstant.SCREEN_WIDTH-kHomeCellPadding-likeSize.width, y: kHomeCellDateRect.minY, width: likeSize.width, height: kHomeCellToolBarHeight)
        self.kHomeCellLikeImgRect = CGRect(x: kHomeCellLikeRect.minX-kHomeCellPadding-kHomeCellToolBarHeight, y: kHomeCellDateRect.minY, width: kHomeCellToolBarHeight, height: kHomeCellToolBarHeight)
        
        // 数字
        self.kHomeCellNumberRect = CGRect(x: kHomeCellDateRect.minX, y: kHomeCellTopMargin+kHomeCellDateRect.maxY, width: contentWidth-2*kHomeCellDateRect.minX, height: 40)
        
        // 标题
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        let titleAttributes = [NSFontAttributeName: UIFont.customFont_FZLTXIHJW(fontSize: 16), NSParagraphStyleAttributeName: paragraphStyle]
        let titleWidth = UIConstant.SCREEN_WIDTH-kHomeCellDateRect.minX-kHomeCellPadding
        let titleSize = (model.title as NSString).boundingRectWithSize(CGSize(width: titleWidth, height: CGFloat.max), options: .UsesLineFragmentOrigin, attributes: titleAttributes, context: nil).size
        self.kHomeCellTitleRect = CGRect(x: kHomeCellDateRect.minX, y: kHomeCellNumberRect.maxY+kHomeCellTopMargin, width: titleWidth, height:titleSize.height)
        
        // 引文 去除<p></p>
        let excerpText = model.content.stringByReplacingOccurrencesOfString("<p>", withString: "").stringByReplacingOccurrencesOfString("</p>", withString: "")
        let excerpAttribute = [NSFontAttributeName: UIFont.customFont_FZLTXIHJW(fontSize: 12)]
        let excerpSize = (excerpText as NSString).boundingRectWithSize(CGSize(width: titleWidth, height: CGFloat.max), options: .UsesLineFragmentOrigin, attributes: excerpAttribute, context: nil).size
        self.kHomeCellTextRect = CGRect(x: kHomeCellDateRect.minX, y: kHomeCellTopMargin+kHomeCellTitleRect.maxY, width: excerpSize.width, height: excerpSize.height)
        
        self.cellHeight = kHomeCellTextRect.maxY+2*kHomeCellBottoMInset
    }
    
     /**
     计算时间和分类
     */
    private func calculateDateSize() -> CGSize {
        let dateString = "\(model.category) | \(NSDate.getDate(model.pubDate)))"
        let toolBarAttribute = [NSFontAttributeName: UIFont.customFont_FZLTXIHJW(fontSize: 12)]
        return (dateString as NSString).boundingRectWithSize(CGSize(width: 200, height: kHomeCellToolBarHeight), options: .UsesLineFragmentOrigin, attributes: toolBarAttribute, context: nil).size
    }
    
    /**
     计算喜欢数
     */
    private func calculateLikeSize() -> CGSize {
        let likeAttribute = [NSFontAttributeName: UIFont.customFont_FZLTXIHJW(fontSize: 12)]
        return ("\(model.like)" as NSString).boundingRectWithSize(CGSize(width: 100, height: kHomeCellToolBarHeight), options: .UsesLineFragmentOrigin, attributes: likeAttribute, context: nil).size
    }
}