//
//  AppSoModel.swift
//  ifanr
//
//  Created by sys on 16/7/9.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

struct AppSoModel {
    /// id
    var ID: Int64!
    /// 标题
    var title: String!
    /// 作者
    var author: String!
    /// 时间
    var pubDate: String!
    /// 发布时间
    var post_modified: String!
    /// 图片
    var image: String!
    /// cwb_image_url
    var cwb_image_url: String!
    /// 内容
    var content: String!
    /// 引文
    var introduce: String!
    /// 网页版
    var link: String!
    /// 评论数
    var comments: String!
    /// 分类
    var category: String!
    /// 发布类型
    var post_type: String!
    /// 分类网页
    var category_link: String!
    /// tag
    var tags: String!
    /// 喜欢数
    var like: Int!
    var is_ad: Int!
    /// 摘录
    var excerpt: String!
    
    init(dict: NSDictionary) {
        self.ID = dict["ID"] as? Int64 ?? 0
        self.title = dict["title"] as? String ?? ""
        self.author = dict["author"] as? String ?? ""
        self.pubDate = dict["pubDate"] as? String ?? ""
        self.post_modified = dict["post_modified"] as? String ?? ""
        self.image = dict["image"] as? String ?? ""
        self.cwb_image_url = dict["cwb_image_url"] as? String ?? ""
        self.content = dict["content"] as? String ?? ""
        self.introduce = dict["introduce"] as? String ?? ""
        self.link = dict["link"] as? String ?? ""
        self.comments = dict["comments"] as? String ?? ""
        self.category = dict["category"] as? String ?? ""
        self.post_type = dict["post_type"] as? String ?? ""
        self.category_link = dict["category_link"] as? String ?? ""
        self.tags = dict["tags"] as? String ?? ""
        self.like = dict["like"] as? Int ?? 0
        self.is_ad = dict["is_ad"] as? Int ?? 0
        self.excerpt = dict["excerpt"] as? String ?? ""
    }
}

/*
 ID: 679381,
 title: "Smart Wallpaper : 聪明的壁纸 App，让你每次打开手机都有惊喜 #Android",
 app_icon_url: "http://lh3.googleusercontent.com/z9TeDiaoQcDeVTFRZRZZBD99cSVRcx2YAKNZb6Vi8Q1bQJ4y9NYQ9QL-Pz3yQKF6t1g=w300",
 author: "颜 溪莎",
 pubDate: "2016-07-05 11:56:35",
 post_modified: "2016-07-05 11:56:35",
 image: "http://ifanr-cdn.b0.upaiyun.com/wp-content/uploads/2016/07/sw_0_1000_copy.jpg",
 cwb_image_url: "http:////images.ifanr.cn/wp-content/uploads/changweibo/679381.jpg",
 content: "<p><img class="aligncenter wp-image-679452 size-full" src="http://ifanr-cdn.b0.upaiyun.com/wp-content/uploads/2016/07/sw_0_1000_copy.jpg" width="1000" height="625" /></p> <p>之前 AppSo（微信号 appsolution）的 Android 手机壁纸专题中，推荐了好几款酷炫的壁纸应用给大家。但有些人说想要相对简洁但颜值又高的壁纸应用，于是 AppSo 找到了 Smart Wallpaper。</p> <p><strong>Smart Wallpaper 是一款可以根据场景、时间自动切换壁纸的应用。</strong>或在炎炎夏日展示让人觉得酷爽冰凉的壁纸，或在大雪纷飞之时展示让人觉得暖意盎然的壁纸，或在工作场合变身成能激励人的壁纸……</p> <p><img class="aligncenter size-full wp-image-679383" src="http://ifanr-cdn.b0.upaiyun.com/wp-content/uploads/2016/07/sw_1_icon.jpg" alt="sw_1_icon" width="1000" height="884" /></p> <p>如图所示，它可以根据不同的情境来切换壁纸：</p> <ol> <li>一天内的不同时段</li> <li>一周 7 天</li> <li>每个月</li> <li>不同的天气</li> <li>Wi-Fi 环境</li> <li>随机</li> </ol> <p>其中 2、3、4 项情景中还可以附加日夜壁纸展示，白天可以选择相对活泼鲜明的壁纸，夜晚可以选择相对暗色的壁纸来保护眼睛。</p> <p>我们进入主界面选择对应情景即可开始设置壁纸，当你设置完成之后，壁纸就会按你所想来展示了，是不是很贴心呢？</p> <p><img class="aligncenter wp-image-679454 size-full" src="http://images.ifanr.cn/wp-content/uploads/2016/07/sw_2_icon-2.jpg" width="1000" height="884" /></p> <p>Smart Wallpaper 大小不超过 5 MB，而且不是实时更换壁纸，所以你不必过于担心耗电等问题。</p> <p>AppSo（微信号 appsolution）认为值得一提的是，随机壁纸的展示中提供了一个很有趣的切换壁纸的方式：<strong>连击屏幕三次即可更换一张</strong>。</p> <p><img class="size-full wp-image-680175 aligncenter" src="http://ifanr-cdn.b0.upaiyun.com/wp-content/uploads/2016/07/smartwallpaper.gif" alt="smartwallpaper" width="640" height="480" /></p> <p><span style="line-height: 1.5;">需要注意的是，Smart Wallpaper 目前支持从本地相册、Google Drive、Dropbox 中提取图片设置壁纸。另外，它所提供的情景模式每次只能选择一种。</span></p> <p><span style="line-height: 1.5;">当你激活了 Smart Wallpaper 时，可以对自己说：这一次，我的壁纸我做主。</span></p> <p>Smart Wallpaper 适用于 Android 4.1+ 的设备，大小 4.6 MB，完全免费。</p> <p>本文由让手机更好用的 AppSo 原创出品，关注微信号 appsolution，回复「壁纸」获取文章《5 款 Android 壁纸应用，给你的手机换张好脸》。</p> ",
 excerpt: "Smart Wallpaper 是一款能根据天气、时间、Wi-Fi 环境来自动切换壁纸的应用。从此，你的手机会随着生活场景的变化，呈现最适合氛围的壁纸。",
 introduce: "Smart Wallpaper 是一款能根据天气、时间、Wi-Fi 环境来自动切换壁纸的应用。从此，你的手机会随着生活场景的变化，呈现最适合氛围的壁纸。",
 link: "http://www.ifanr.com/app/679381",
 comments: "1",
 category: "AppSolution",
 post_type: "app",
 category_link: "",
 app_download_links: {
 googleplay: "https://play.google.com/store/apps/details?id=com.feedk.smartwallpaper",
 android: "http://dl.ifanr.cn/app/apk/smartwallpaper.appso-vqBVoobWH8.apk"
 },
 tags: "壁纸|手机壁纸|桌面|桌面壁纸",
 like: 0,
 is_ad: 0,
 author_info: {
 job: "AppSolution 天才作家",
 name: "mewkeisa",
 avatar: "http://images.ifanr.cn/wp-content/uploads/2015/07/MEW.jpg",
 description: "NEVERLAND."
 }
 */