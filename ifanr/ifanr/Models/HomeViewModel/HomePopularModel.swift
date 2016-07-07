//
//  HomePopularModel.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/3.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
/**
 发布类型： 在计算cell高度是需要分类进行计算（目前只发现这几种）
 */
enum PostType {
    case post
    case data
    case dasheng
}
struct HomePopularModel {
    
    
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
        /// 发布类型(目前发现几种data, post, dasheng) 默认是post类型
    var post_type: PostType! = .post
        /// 分类网页
    var category_link: String!
        /// tag
    var tags: String!
        /// 喜欢数
    var like: Int!
    var is_ad: Int!
        /// 摘录
    var excerpt: String!
        /// 作者信息，有可能为空
    var authorModel: AuthorInfoModel?
        /// 大声作者
    var dasheng_author: String! = ""
        /// 数读
    var data_author: String! = ""
    var number: String! = ""
    var subfix: String! = ""
    
    init(dict: NSDictionary, isCalculate: Bool = false) {
        self.ID = dict["ID"] as? Int64 ?? 0
        self.title = dict["title"] as? String ?? ""
        self.author = dict["author"] as? String ?? ""
        self.pubDate = dict["pubDate"] as? String ?? ""
        self.post_modified = dict["post_modified"] as? String ?? ""
        self.image = dict["image"] as? String ?? ""
        self.content = dict["content"] as? String ?? ""
        self.introduce = dict["introduce"] as? String ?? ""
        self.link = dict["link"] as? String ?? ""
        self.comments = dict["comments"] as? String ?? ""
        self.category = dict["category"] as? String ?? ""
        if let type = dict["post_type"] as? String {
            if type == "post" {
                self.post_type = .post
            } else if type == "dasheng" {
                self.post_type = .dasheng
                self.dasheng_author = dict["dasheng_author"] as? String ?? ""
            } else if type == "data" {
                self.post_type = .data
                self.data_author = "数读"
                self.number = dict["number"] as? String ?? ""
                self.subfix = dict["subfix"] as? String ?? ""
            }
        }
        self.category_link = dict["category_link"] as? String ?? ""
        self.tags = dict["tags"] as? String ?? ""
        self.like = dict["like"] as? Int ?? 0
        self.is_ad = dict["is_ad"] as? Int ?? 0
        self.excerpt = dict["excerpt"] as? String ?? ""
        
        // 作者信息
        let authorDict = dict["author_info"] as! NSDictionary?
        if let authorDic = authorDict {
            self.authorModel = AuthorInfoModel(dict: authorDic)
        }
        
    }
    
    /**
     *  作者信息
     */
    struct AuthorInfoModel {
        var job: String!
        var name: String!
        var avatar: String!
        var description: String!
        
        init(dict: NSDictionary) {
            self.job = dict["job"] as? String ?? ""
            self.name = dict["name"] as? String ?? ""
            self.avatar = dict["avatar"] as? String ?? ""
            self.description = dict["description"] as? String ?? ""
        }
    }
}

/*
"author_info":{
    "job":"编辑",
    "name":"nemo603",
    "avatar":"http://images.ifanr.cn/wp-content/uploads/2015/09/3.pic_hd1.jpg",
    "description":"相逢意气为君饮，系马高楼垂柳边。"
}
*/
/*
 
 
 /*
 {
 "data": [
 {
 "ID": 678364,
 "title": "血洗万科？宝万之争你必须知道的那些事",
 "author": "麦玮琪",
 "pubDate": "2016-06-30 19:44:46",
 "post_modified": "2016-07-01 11:45:50",
 "image": "http://images.ifanr.cn/wp-content/uploads/2016/06/wanke-3.jpg",
 "cwb_image_url": "http:////images.ifanr.cn/wp-content/uploads/changweibo/678364.jpg",
 "content": "<p><img class=\"alignnone size-full wp-image-678382\" src=\"http://ifanr-cdn.b0.upaiyun.com/wp-content/uploads/2016/06/wanke-1.jpg\" alt=\"wanke\" width=\"1200\" height=\"750\" /></p>\n<p>撕逼向来是和装逼在一起的。以大佬王石为中心展开的宝万之争，充分验证了这一点！连躲都躲不开！</p>\n<p>譬如我们，作为贵科技创投圈的业内人士，不对这出正在上映的“港产商业大片”说上两句，朋友圈血条会立马减半，就像是中了巫师诅咒似的！</p>\n<p>但是，从田小姐到王石千万年薪，从宝能系怎样才能血洗万科再到 Facebook 的 AB 股权架构，从独董华生何许人到野蛮人到底指什么，愣说难免发虚。</p>\n<p>在这个时候，爱范儿（微信号 ifanr )和大家一样，都需要一篇“装逼（撕逼）指北”。</p>\n<p>阅读本文，大概需要耗时十一分钟。</p>\n<h3>田小姐抢戏与真.董事长王石</h3>\n<p><img class=\"size-full wp-image-678391 aligncenter\" src=\"http://ifanr-cdn.b0.upaiyun.com/wp-content/uploads/2016/06/wanke4.jpg\" alt=\"wanke4\" width=\"550\" height=\"412\" /></p>\n<p style=\"text-align: center;\">图片来自 <a href=\"http://finance.ifeng.com/a/20141225/13383642_0.shtml#p=1\">凤凰网</a></p>\n<p>在宝万之争中，一个特殊的现象是，田小姐抢戏！</p>\n<p>有人就嘲讽写到：王石现在是“美人白头，英雄迟暮，前列腺堵住。”</p>\n<p>吃瓜群众，最爱看这一幕。</p>\n<p>王石登山、留学、找小明星，很多人早已被重伤！心下想，如此潇洒的董事长，还有田小姐，我也想干，我也能干！</p>\n<p>跟王石针锋相对的另一位大佬——宝能系大老板姚振华，会不会也这样想？不好揣测。</p>\n<p>反正，在<a href=\"http://finance.sina.com.cn/roll/2016-01-04/doc-ifxneept3613821.shtml\">最新报道</a>里，姚振华给宝能员工留下的形象，绝对是艰苦奋斗型的。譬如，他会因为秘书给买了七千元的鞋子而大发雷霆，当即要求退换成两千元的。（也不便宜！）</p>\n<p>所以，当宝能系公开指责“王石在 2011-2014 年间，长期脱离工作岗位，未经股东大会批准获取 5000 余万元薪酬。”时，很多人老怀大慰，纷纷跳出来说三道四！从道德情操，再扯到职业性！</p>\n<p>但这样来说，实在智商堪忧。宝能系为干掉王石，憋出这样一个大招，也是个大昏招。</p>\n<p><img class=\"alignnone size-full wp-image-678448 aligncenter\" src=\"http://ifanr-cdn.b0.upaiyun.com/wp-content/uploads/2016/06/wanke12.jpg\" alt=\"wanke12\" width=\"390\" height=\"291\" /></p>\n<p style=\"text-align: center;\">1988 年万科股票首期发行，图片来自 <a href=\"http://www.szse.cn/main/ppjs/xwzl/ds.html\">深交所</a></p>\n<div class=\"layoutArea\">\n<div class=\"column\">\n<p>为什么这样说？</p>\n<p>不说 1988 年不要股权的事，王石真爱钱，就应该长期把持权位，搞点黑箱操作，多折腾几套低价房。这样捞到的钱，比这区区 5000 万不知道高到哪里去！但偏偏，王石在万科搞的是公开透明、治理规范这一套，还扶持了一个不甘屈居人下的郁亮出来。</p>\n<p>优秀的程度，甚至连全国政协常委、中石化集团公司原董事长傅成玉也说：</p>\n<blockquote><p>万科长期致力于全体股东的长期利益和社会效益，是中国资本市场稀缺的良治公司之一。</p></blockquote>\n<p>此情此景之下，爱范儿小司机想，能说王石贪婪？</p>\n<p>更为关键的是，王石，拿的是工资，而且已经披露了好多年！薪水的高低，也是通过董事会、股东同意的。</p>\n<p>在 6 月 27 日万科的股东大会上，王石也说了，他一直承担的是管理层的分工，而不是董事会的分工，一直拿的就是工资。</p>\n<p>因此，以五千万定罪王石拿薪水太多，连当当 CEO 李国庆都看不过眼：</p>\n<blockquote><p>西方体制，董事长就是半退休，但王还在东西方为万科做形象代言，年 1000 万收入，不高。</p></blockquote>\n<p>至于王石是不是真.董事长，不在于他是否游山玩水，为田小姐做红烧肉，而在于他管理的企业好不好。什么是合格的董事长？关键是管好大事，价值观、制度、战略等等，而不是事事亲力亲为。</p>\n<p>王石也自辩到：</p>\n<blockquote><p>作为董事长，我的责任是监督公司的战略决策是否存在偏差。作为一个董事长，该对公司进行战略上的把握。如执行董事长的决策是否有偏差等方面。</p></blockquote>\n<p>总体来看，万科是不是个好企业？如果不是，那为什么宝能与华润还要争夺万科的管理权？</p>\n<p>私事归私事，私德不缺就好。八卦太多，格局就不够，反而露出自己皮袄下藏着的“小”。</p>\n<h3>只有 24.29% 股份的宝能系，为何有能力血洗万科？</h3>\n<p><img class=\"alignnone size-full wp-image-678437 aligncenter\" src=\"http://ifanr-cdn.b0.upaiyun.com/wp-content/uploads/2016/06/wanke11.jpg\" alt=\"wanke11\" width=\"580\" height=\"300\" /></p>\n<p style=\"text-align: center;\">姚振华，图片来自<a href=\"http://www.yicai.com/news/4734231.html\"> 第一财经</a></p>\n<p>王石及万科管理层不喜欢宝能系，众人皆知。</p>\n<p>但是，为何被指称为”野蛮人“的宝能系，在只占据 24.29% 万科股份时，就有权提出召开临时股东大会，提请罢免王石等人的董监高职务？而所有的舆论，又为何评估此事为“血洗万科管理层”，王石进而也要在 6 月 27 日股东大会上委婉低头，公开道歉？</p>\n<p>在一般人的印象中，要做到“秒杀一切”，单个股东拥有公司的股权，必须超过 50% ，也就是所谓的“绝对控股”。</p>\n<p>但实际上，要做到“秒杀一切”，并不需要如此。</p>\n<p>按照《中华人民共和国公司法》 第一百零四条和第一百零六条，只要“<strong>持有公司股份百分之十以上的股东请求时可以召开临时股东大会。</strong>”而只要“<strong>出席会议（股东大会）的股东所持表决权的半数以上通过</strong>”，股东大会的决议就生效了。</p>\n<p>因而，占据 24.29% 万科股份的宝能系，首先有权力提请召开临时股东大会，并提请罢免王石等人。</p>\n<p>而要真正罢免成功，宝能系还需要其他条件。</p>\n<p><img class=\"alignnone size-full wp-image-678427 aligncenter\" src=\"http://ifanr-cdn.b0.upaiyun.com/wp-content/uploads/2016/06/wanke9.jpg\" alt=\"wanke9\" width=\"600\" height=\"400\" /></p>\n<p style=\"text-align: center;\">图片来自 <a href=\"http://finance.sina.com.cn/focus/wankeyubaoneng/\">新浪</a></p>\n<p>譬如，华润的“撕破脸皮”。</p>\n<p>实际上，宝能系的此次逼宫，就恰好发生在华润公开表达对万科的不满，并称会继续投反对票之际。</p>\n<p>作为曾经的第一大股东，华润目前手头持有 15.24% 的万科股份。</p>\n<p>假使在临时股东大会上，华宝两家真的联手，其占有的股份会高达 39.53% 。而现实中，出席股东大会的股东人数几乎不可能达到 80% 的比例。这也就意味着，华宝两家完全有足够的投票权通过任何决议。</p>\n<p>当然，这仅仅是相对合理的揣测。期间的变数还很大。</p>\n<p>譬如，新华社就喊话道，宝万之争要告别“任性”的火药。身为全国政协常委的傅成玉也表态称：</p>\n<blockquote><p>从宝能发出罢免万科全体董事及高管层的公开要求那一刻起，华宝与万科之争的长远影响，已上升到社会利益和一个健康资本市场的发展建设层面。</p></blockquote>\n<p>在傅成玉看来，华宝与万科之争已经出现了类似英国公投退欧的迹象。也就是说，虽然程序没问题，但结果却为大多数人所不认可，会导致不可承受之结果。</p>\n<p><img class=\"alignnone size-full wp-image-678387 aligncenter\" src=\"http://ifanr-cdn.b0.upaiyun.com/wp-content/uploads/2016/06/wanke2.jpg\" alt=\"wanke2\" width=\"550\" height=\"361\" /></p>\n<p style=\"text-align: center;\">图片来自 <a href=\"http://stock.qq.com/a/20160630/028202.htm\">腾讯</a></p>\n<p>而最新的报道是，华润在 6 月 30 日发布公告，对罢免万科全部董事监事提案提出异议，但会从有利于公司发展的角度，考虑未来董事会，监事会的改组。</p>\n<h3>主角华生：一个特立独行的独董</h3>\n<p>一场大戏，总是有主角有配角。</p>\n</div>\n<div class=\"column\">\n<p>大家印象中，在董事会里，独董，向来都是干配角的命。但在这一次的宝万之争中，由于万科深铁重组方案的“通过”，万科两名独董——华生与张利平，却罕见地成为关键人物。</p>\n<p>尤其是前者华生，写了三篇《我为什么不支持大股东意见》长文，以当事人身份，披露了许多非内幕却非常关键的信息，并详细解释了为什么会支持万科管理层，而不是配合大股东，做一名花瓶独董！</p>\n<p>看完三篇长文，爱范儿小司机很想知道：华生，到底何许人也？</p>\n<p><img class=\"size-full wp-image-678418 aligncenter\" src=\"http://ifanr-cdn.b0.upaiyun.com/wp-content/uploads/2016/06/wanke7.jpg\" alt=\"wanke7\" width=\"800\" height=\"500\" /></p>\n<p style=\"text-align: center;\">图片来自 <a href=\"http://stock.hexun.com/2016-06-26/184595392.html\">和讯</a></p>\n<p>教授、校长、高层智囊、上市公司董事长、个体户经济学家、价格双轨制的发明者之一、万科不收钱的独立董事.....关于华生的描述，太多了。</p>\n<p>先庸俗点说。</p>\n<p>华生有钱！被很多人认为是中国经济学家中的首富，身价数以十亿计；因为下过海，更曾多次创业，也有上市公司董事长的经验；</p>\n<p>华生有影响力。往来无白丁，是与王岐山、马凯、张维迎等人一道从 1984 年著名的“莫干山会议”上涌现的经济学才俊，至今对国家经济政策有一定影响力。妻子，则是作协主席铁凝。</p>\n<p>拔高到情怀来看。</p>\n<p>华生是一个非常特立独行的人。譬如，他自己说，看不惯王石的高调派头，跟王石关系其实不好。一个，是因为早年曾被王石在黑龙家亚布力当众嘲讽“哈哈，这个博士还怕冷？！”另一个，也在于他认为王石“失察、懈怠、麻痹大意、自满自得”。</p>\n<p>而根据南风窗的专访文章，在 1980 年最鼎盛时期，虽然只是一介初出茅庐的书生。但“陪着中央领导开会，他就觉得将来有机会，总理也不是不可以当。”</p>\n<p><img class=\"alignnone size-full wp-image-678420 aligncenter\" src=\"http://ifanr-cdn.b0.upaiyun.com/wp-content/uploads/2016/06/wanke8.jpg\" alt=\"wanke8\" width=\"640\" height=\"427\" /></p>\n<p style=\"text-align: center;\">华生与其妻子铁凝，图片来自 <a href=\"http://cnstjj.com/html/HO0OONDUNtHTQE4PNNjSPNVqKRSp.html\">Cnstjj</a></p>\n<p>对了，他还曾在东南大学的讲台上，对着妻子铁凝和年轻学子，谈自己年轻时的偷盗劣迹，自称“反正我不是一个道德完满的人。”</p>\n<p>现如今，华生正深陷风暴中心。有人称赞他不是花瓶独董，但宝能也同样指责其“独立董事不独立”。</p>\n<p>在 6 月 29 日的微博中，特立独行的华生说，</p>\n<blockquote><p>这次除发文章拒绝了所有媒体，故文章全完后我会开媒体见面会致歉，回答包括海归创业第一桶金、经商历程的任何问题。但不解为何每有人站出来说话就要按完人查历史？不完美的人就不能仗义执言？世界由常人组成，此文化陋习不改，进步何望？</p></blockquote>\n<h3>“门口野蛮人”是怎么回事？</h3>\n<p><img class=\"size-full wp-image-678413 aligncenter\" src=\"http://ifanr-cdn.b0.upaiyun.com/wp-content/uploads/2016/06/wanke5.jpg\" alt=\"wanke5\" width=\"800\" height=\"500\" /></p>\n<p style=\"text-align: center;\">图片来自 <a href=\"http://morsuemelgsingvin.gq/egipetskoe-prorochestvo-torrent.html\">Morsuemelgsingvin</a></p>\n<p>一场大戏，总会冒出很多热词。</p>\n<p>当下最热的，就是“野蛮人”一词。</p>\n<p>“野蛮人”这个说法，最早起源于布赖恩·伯勒的《门口的野蛮人》。这本书用写实的手法记录了 KKR 收购 RJR 纳贝斯克公司的世纪大战。此后，华尔街就开始用“门口的野蛮人”来形容那些不怀好意的收购者。</p>\n<p>2015 年 8 月 27 日，王石发表了一条微博，第一次提到他对万科遭遇疯狂举牌的态度。他写道：</p>\n<blockquote><p>滨海爆炸，万科三个小区首当其冲，一万多居民撤离家园；股市过山车，野蛮人强行入室...，此值特区成立 35 周年，万科进入 31 周年之际，万科人应对的姿态。</p></blockquote>\n<p>这条微博，毫无疑问显示王石已经把举牌者，也就是宝能系看作是“野蛮人”。</p>\n<p><img class=\"alignnone size-full wp-image-678386 aligncenter\" src=\"http://ifanr-cdn.b0.upaiyun.com/wp-content/uploads/2016/06/wanke1.png\" alt=\"wanke1\" width=\"602\" height=\"540\" /></p>\n<p>6 月 27 日，在宝能系逼宫之后，王石在万科股东大会上，第一次就”野蛮人“说法进行澄清。他说：“这个事件发生以来，我从未说过野蛮人。我说的是恶意收购。在这个过程中，和股东沟通的态度有需要反省的地方。如果因此使得姚先生被称为野蛮人的话，我向姚振华先生道歉。这是我表明自己的一个态度。”</p>\n<p>道歉归道歉，但是否是“恶意收购”，才是宝能系是不是“门口的野蛮人”的关键。</p>\n<p>从此次宝能系提请的罢免案来看，宝能虽然提请罢免王石郁亮等人，却没有合情合理地提出候选人名单，非常离奇。</p>\n<p>这样离奇的提请，自然会引发深交所的高度关注。</p>\n<p><img class=\"size-full wp-image-678414 aligncenter\" src=\"http://ifanr-cdn.b0.upaiyun.com/wp-content/uploads/2016/06/wanke6.jpg\" alt=\"wanke6\" width=\"800\" height=\"500\" /></p>\n<p style=\"text-align: center;\">图片来自 <a href=\"http://news.now.com/home/finance/player?newsId=142292\">Now</a></p>\n<p>于是，深交所向宝能系和华润分别下发关注函，要求双方各自说明：</p>\n<blockquote><p>二者是否存在协议或其他安排等形式，以共同扩大所能支配的万科股份表决权数量的行为或事实；须对照《上市公司收购管理办法》说明是否互为一致行动人及其理由。</p></blockquote>\n<p>深交所另外还要求宝能系说明：</p>\n<blockquote><p>提出罢免万科董事监事却未同时提名候选人的原因；罢免董事监事对万科日常经营的影响；为消除影响拟采取的措施。</p></blockquote>\n<p>而全国政协常委、中石化集团公司原董事长傅成玉则称，做为保险公司的宝能，很大部分资金是倒短资金，且不论短期保险资金投资上市公司是否合规，从其尽快偿还短期债务压力看也必须要通过万科来尽快变现，因此，其很难从万科长远发展思考问题，从而迫使万科偏离长期坚持的公司价值观。</p>\n<p>他进而认为，对万科来说，担心宝能介入会毁掉万科的核心价值是有理由的。</p>\n<p style=\"text-align: center;\"><img class=\"alignnone size-full wp-image-678388\" src=\"http://ifanr-cdn.b0.upaiyun.com/wp-content/uploads/2016/06/wanke3.jpg\" alt=\"wanke3\" width=\"550\" height=\"733\" /></p>\n<p style=\"text-align: center;\">图片来自 <a href=\"http://business.sohu.com/20160630/n457064018.shtml\">搜狐</a></p>\n<p>这，也正是《门口的野蛮人》曾经描述过的历史。</p>\n<p>最后，宝万之争中， AB 股也是一个非常火热的话题。想了解更多信息，可以移步《<a href=\"http://www.ifanr.com/676061\">王石正遭遇乔布斯雨夜之变！扎克伯格和马云却为什么不会被驱逐？</a>》</p>\n<p>题图来自 <a href=\"http://edu.ifeng.com/a/20150430/41072640_0.shtml\">凤凰网</a></p>\n</div>\n</div>\n",
 "introduce": "撕逼向来是和装逼在一起的。以大佬王石为中心展开的宝万之争，充分验证了这一点！连躲都躲不开！",
 "link": "http://www.ifanr.com/678364",
 "comments": "17",
 "category": "商业",
 "post_type": "post",
 "category_link": "http://www.ifanr.com/category/special/business",
 "tags": "万科|华生|姚振华|王石|股权",
 "like": 0,
 "is_ad": 0,
 "excerpt": "撕逼向来是和装逼在一起的。以大佬王石为中心展开的宝万之争，充分验证了这一点！连躲都躲不开！"
 }
 
 
 ],
 "status": 1
 }
 
 */
 */