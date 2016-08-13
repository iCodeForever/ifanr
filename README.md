<p align="center">
<a href="#截图">截图</a> -
<a href="#第三方库">第三方库</a> -
<a href="#UI">UI</a> -
<a href="#Networking">Networking</a> -
<a href="#Contribution">Contribution</a> -
<a href="#后续更新">后续更新</a> -
<a href="#更新日志">更新日志</a>
</p>

<p align="center">
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/language-swift2-f48041.svg?style=flat"></a>
<a href="https://developer.apple.com/ios"><img src="https://img.shields.io/badge/platform-iOS8-blue.svg?style=flat"></a>
<a href="https://https://github.com/iCodeForever/ifanr/blob/develop/LICENSE"><img src="http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat"></a>
</p>

# 高仿 爱范儿3.0

## 截图


![1.gif](https://github.com/iCodeForever/ifanr/blob/master/ifanr/ifanr/Resources/1.gif)


![2.gif](https://github.com/iCodeForever/ifanr/blob/master/ifanr/ifanr/Resources/2.gif)


![3.gif](https://github.com/iCodeForever/ifanr/blob/master/ifanr/ifanr/Resources/3.gif)


![4.gif](https://github.com/iCodeForever/ifanr/blob/master/ifanr/ifanr/Resources/4.gif)


![5.gif](https://github.com/iCodeForever/ifanr/blob/master/ifanr/ifanr/Resources/5.gif)


## 第三方库

- ![Alamofire](https://github.com/Alamofire/Alamofire)      网络请求
- ![MonkeyKing](https://github.com/nixzhu/MonkeyKing)       社交分享
- ![Moya](https://github.com/Moya/Moya)                     与Alamofire结合完成网络请求，爽0.0
- ![SnapKit](https://github.com/SnapKit/SnapKit)            屏幕适配
- ![YYWebImage](https://github.com/ibireme/YYWebImage)      图片加载

## UI

UI采用纯代码编写+![SnapKit](https://github.com/SnapKit/SnapKit)屏幕适配，控制器结构图如下

<img src="https://github.com/iCodeForever/ifanr/blob/master/ifanr/ifanr/Resources/controllerNavgation.png" width="50%" height="50%" />

## Networking

网络请求是采用![Alamofire](https://github.com/Alamofire/Alamofire)+![Moya](https://github.com/Moya/Moya),只需要创建一个`enum`去实现`Moya`的`TargetType`协议，然后配置`URL`和`parameters`等即可完成网络请求。详情可以看![APIConstant.swift](https://github.com/iCodeForever/ifanr/blob/master/ifanr/ifanr/Constants/APIConstant.swift)

## Contribution

- [dby](https://github.com/dby) 邮箱：1052856576@qq.com, [lyimin](https://github.com/lyimin) 邮箱：1142343535@qq.com
- 如果你需要帮助或者遇到Bug，请[创建issue](https://github.com/iCodeForever/ifanr/issues/new)

## 后续更新

- MindStore详情页和评论界面正在开发中

## 更新日志

- 完善IFanrService ----- 2016-08-13 by dby
- 修改详情页面的评论模块,调整代码 ----- 2016-08-07 by dby
- 将ShareSdk替换成MonkeyKing，修改分享代码 ----- 2016-08-07 by dby
- 初步完成详情页面的评论模块，有几处细节需要完善 -----2016-08-06 by dby
- 优化一些细节问题   ----- 2016-08-05 by lyiming
- 完成设置界面  ----- 2016-08-05 by lyiming
- 优化菜单按钮的动画   ----- 2016-08-04 by lyiming
- 完成点击菜单的动画   ----- 2016-08-04 by lyiming
- 点击菜单动画 （初版)       ----- 2016-08-04 by lyiming
- 完成分类界面导航栏淡入淡出动画     ----- 2016-08-02 by lyiming
- 完成分类界面（细节未处理，动画之类）,更改Model代码,处理手势返回...等等    ----- 2016-08-02 by lyiming
- 调整ShareView的实现方式,在"快讯"中添加微信分享,在"AppSo"、"Home"中添加详情界面 ----- 2016-07-31 by dby
- "玩物志"中集成微信分享的代码，调整相关的动画 ----- 2016-07-30 by dby
- 优化Model中代码，将共同的代码抽取出来 ----- 2016-07-28 by dby
- 修改“快讯”详情界面的URL ----- 2016-07-27 by dby
- 首页分类界面（未完成）  ----- 2016-07-25 by lyiming
- 集成ShareSDK  ----- 2016-07-25 by lyiming
- 完成菜单，分类按钮的滑动动画  ----- 2016-07-24 by lyiming
- 完成"玩物志"详情界面，下步完成底部工具栏的四个功能 ----- 2016-07-23 by dby
- "玩物志"详情界面中，添加了headerview，正在开发BottomBar，相关动画效果还有待改进 ----- 2016-07-23 by dby
- 完成新特性视频介绍页面  ----- 2016-07-22    by lyiming
- 优化网络请求框架，完成快讯，首页，玩物志，appso,mindstore下拉刷新。发现model太乱了有空再优化 ----- 2016-07-21    by lyiming
- 改了字体样式 ----- 2016-07-20    by lyiming
- 完成上拉加载更多（参考首页界面），优化修改ScrollViewControllerReusable协议 ----- 2016-07-20    by lyiming
- 更改BasePageController成Protocol, 完善下拉刷新框架（上拉加载更多还在开发中） ----- 2016-07-19    by lyiming
- 添加玩物志详情界面（BottomToolBar遇到了问题）----- 2016-07-19 by dby
- 抽取一个公共类BasePageController， 改用Protocol(初步) ----- 2016-07-18    by lyiming
- 添加快讯详情界面（缺少分享）----- 2016-07-18 by dby
- 重新撸了一个下拉刷新（上拉刷新还没做，代码还不太优雅）----- 2016-07-16    by lyiming
- 修改MindStore界面 ----- 2016.07.14 by dby
- 新增下拉刷新框架，加载进度动画。完成MainviewController顶部的界面   ----- 2016-07-13    by lyiming
- 微调AppSoView，调整HeaderView
- 微调界面 ----- by dby 2016-07-12  
- 1.改了一下Appicon 2.正在开发MainViewController头部  ----- 2016-07-12    by lyiming
- 微调AppSo的模型，调整HeaderView ----- 2016-07-11 by dby
- 正在开发MainViewController, 新增FPS标签，修改Mindstore约束造成错误 ----- 2016-07-11    by lyiming
- 初步完成AppSo、玩物志、MindStore页面，一些细节仍然需要完善 ----- 2016-07-10 by dby
- (正在开发) 正在搭建主框架MainViewController ----- 2016-07-08    by lyiming
- 完成首页界面 ----- 2016-07-07    by lyiming
- （基本完成）首页界面（还有一种cell没做） ----- 2016-07-07    by lyiming
- 1.（正在开发）首页界面, 2.封装网络请求库     ----- 2016-07.04    by lyiming
- （正在开发）首页界面 ----- 2016-07.03    by lyiming
- （初步）完成快讯的界面 ----- 2016.07.03   by dby
- 添加moya库，上传快讯，首页玩物志，appso,minstore页面的api ----- 2016-06-30    by lyiming
- 完成点击菜单后的界面                        ----- 2016-06-30    by lyiming
- 1.新建项目目录框架, 2.appIcon,launch图片设置 ----- 2016-06-29    by lyiming
    

