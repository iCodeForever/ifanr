//
//  MainViewController.swift
//  ifanr
//
//  Created by 梁亦明 on 16/6/29.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

/**
 主界面 这个控制器用来控制 首页，玩物志，快讯,Appso,MindStore和菜单界面
 */

import UIKit

/**
 控制器状态， 缩小-放大
 */
enum ControllerStatus {
    case Full
    case Small
}

class MainViewController: UIViewController {
    
    //MARK: --------------------------- Life Cycle --------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .None)
        
        initRootViewController()
        
        self.view.addSubview(menuController.view)
        self.view.addSubview(scrollView)
//        self.view.addSubview(fpsLabel)
        // 添加标题和红线
        self.view.addSubview(headerView)
        self.view.addSubview(redLine)
        // 添加两个菜单切换按钮
        self.view.addSubview(menuBtn)
        self.view.addSubview(classifyBtn)
        
        setUpLayout()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return statusBarStyle
    }
    override func prefersStatusBarHidden() -> Bool {
        return statusBarHidden
    }
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return .Slide
    }
    
    //MARK: --------------------------- Private Methods --------------------------
    // 布局
    private func setUpLayout() {

        self.menuBtn.snp_makeConstraints { (make) in
            make.right.equalTo(-15)
            make.top.equalTo(35)
            make.width.height.equalTo(45)
        }
        self.classifyBtn.snp_makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(35)
            make.width.height.equalTo(45)
        }
    }
    
    
    
    //MARK: --------------------------- Getter and Setter --------------------------
    // 首页
    private let homeViewController = HomeViewController()
    // 快讯
    private let newsFlashController = NewsFlashController()
    // Appso
    private let appSoController = AppSoViewController()
    // 玩物志
    private let playzhiController = PlayingZhiController()
    // MindStore
    private let mindStoreController = MindStoreViewController()
    // 菜单
    private let menuController = MenuViewController()
    
    private var viewArray = [UIView]()
    private var coverBtnArray = [UIButton]()
    
    /// 缩放值
    private let scale: CGFloat = 0.4
    /// 状态栏相关
    private var statusBarStyle: UIStatusBarStyle = .LightContent
    private var statusBarHidden: Bool = true
    /// 默认是填充状态
    private var vcState = ControllerStatus.Full
    
    
        /// fps标签
    private lazy var fpsLabel: YYFPSLabel = {
        var fpsLabel: YYFPSLabel = YYFPSLabel(frame: CGRect(x: UIConstant.UI_MARGIN_20, y: self.view.height-40, width: 0, height: 0))
        fpsLabel.sizeToFit()
        return fpsLabel
    }()
    
    private lazy var headerView: MainHeaderView = {
        var headerView: MainHeaderView = MainHeaderView(frame: CGRect(x: 0, y: 0, width: 5*UIConstant.SCREEN_WIDTH, height: 20))
        return headerView
    }()
    
    private lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView(frame: CGRect(x: 0, y: UIConstant.UI_MARGIN_20, width: self.view.width, height: self.view.height-UIConstant.UI_MARGIN_20))
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
        /// 菜单按钮
    private lazy var menuBtn : UIButton = {
        let menuBtn = UIButton()
        menuBtn.setImage(UIImage(imageLiteral:"ic_hamburg"), forState: .Normal)
        menuBtn.addTarget(self, action: #selector(MainViewController.menuBtnDidClick(_:)), forControlEvents: .TouchUpInside)
        return menuBtn
    }()
    
        /// 首页分类按钮
    private lazy var classifyBtn: UIButton = {
        let classifyBtn = UIButton()
        classifyBtn.setImage(UIImage(imageLiteral: "ic_circle"), forState: .Normal)
        classifyBtn.addTarget(self, action: #selector(MainViewController.classifyBtnDidClick), forControlEvents: .TouchUpInside)
        return classifyBtn
    }()

        /// 顶部红线
    private lazy var redLine: UIView = {
        let redLine = UIView()
        redLine.frame = CGRect(x: self.view.center.x-20, y: 0, width: 40, height: 1)
        redLine.backgroundColor = UIConstant.UI_COLOR_RedTheme
        return redLine
    }()
}

// MARK: - 初始化控件
extension MainViewController {
    private func initRootViewController() {
        newsFlashController.scrollViewReusableDataSource = self
        homeViewController.scrollViewReusableDataSource = self
        playzhiController.scrollViewReusableDataSource = self
        appSoController.scrollViewReusableDataSource = self
        mindStoreController.scrollViewReusableDataSource = self
        
        newsFlashController.scrollViewReusableDelegate = self
        homeViewController.scrollViewReusableDelegate = self
        playzhiController.scrollViewReusableDelegate = self
        appSoController.scrollViewReusableDelegate = self
        mindStoreController.scrollViewReusableDelegate = self
        
        menuController.view.frame = self.view.bounds
        self.addChildViewController(menuController)
        self.addChildViewController(newsFlashController)
        self.addChildViewController(homeViewController)
        self.addChildViewController(playzhiController)
        self.addChildViewController(appSoController)
        self.addChildViewController(mindStoreController)
        
        viewArray.append(newsFlashController.view)
        viewArray.append(homeViewController.view)
        viewArray.append(playzhiController.view)
        viewArray.append(appSoController.view)
        viewArray.append(mindStoreController.view)
        
        for i in 0..<viewArray.count {
            let view = viewArray[i]
            view.frame = CGRect(x: CGFloat(i)*self.view.width, y: 0, width: scrollView.width, height: scrollView.height)
            scrollView.addSubview(view)
        }
        scrollView.contentSize = CGSize(width: CGFloat(viewArray.count)*scrollView.width, height: 0)
        
        scrollView.setContentOffset(CGPoint(x: scrollView.width, y: 0), animated: false)
    }
}

//MARK: --------------------------- Event and Action --------------------------
// MARK: - 这里处理一些事件处理， 比如菜单和分类的按钮的事件
extension MainViewController {
    /**
     移除分类View
     
     - parameter categoryView: <#categoryView description#>
     */
    private func removeCategoryView(categoryView: CategoryView) {
        UIView.animateWithDuration(0.5, animations: {
            categoryView.alpha = 0
            self.headerView.alpha = 1
            }, completion: { (com) in
                categoryView.removeFromSuperview()
        })
    }
    
    /**
     点击分类按钮
     */
    @objc private func classifyBtnDidClick() {
        let categoryView = CategoryView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height))
        categoryView.alpha = 0
        self.view.addSubview(categoryView)
        UIView.animateWithDuration(0.5) {
            categoryView.alpha = 1
            self.headerView.alpha = 0
        }
        
        // 点击黑色区域隐藏
        categoryView.coverBtnClick { [unowned self] in
            self.removeCategoryView(categoryView)
            
        }
        // 点击item跳转界面
        categoryView.itemDidClick { [unowned self](collectionView, indexPath) in
            self.removeCategoryView(categoryView)
            if indexPath.row == 0 {
                return
            }
            
            self.navigationController?.pushViewController(CategoryController(categoryModel: CategoryModelArray[indexPath.row]), animated: true)
            
        }
    }
    
    @objc private func menuBtnDidClick(clickView: UIView) {
        
        
//        setupViewHidden()
        
        // 设置圆角
        setupViewCornerRadius()
        
        setupViewAnimation(clickView.tag)
    }
    
    /**
     执行放大收缩动画前需要隐藏和显示一些控件
     */
    private func setupViewHidden(tag: Int = 0) {
        
        // 设置状态栏
        statusBarHidden = vcState == .Small ?true:false
        setNeedsStatusBarAppearanceUpdate()
        // 设置菜单分类按钮,下拉刷新
        self.headerView.hidden = vcState == .Small ?false:true
        self.redLine.hidden = vcState == .Small ?false:true
        if tag == 1 {
            self.classifyBtn.alpha = 1
            self.classifyBtn.hidden = vcState == .Small ?false:true
        } else {
            self.classifyBtn.hidden = true
        }
        self.menuBtn.hidden = vcState == .Small ?false:true
    }
    
    /**
     设置圆角
     */
    private func setupViewCornerRadius() {
        UIView.animateWithDuration(0.1, animations: { [unowned self] in
            self.viewArray.forEach {
                let maskPath = UIBezierPath(roundedRect: $0.bounds, cornerRadius: self.vcState == .Small ?0:20)
                let maskLayer = CAShapeLayer()
                maskLayer.frame = $0.bounds
                maskLayer.path = maskPath.CGPath
                
                $0.layer.mask = maskLayer
            }
        })
    }
    
    /**
     这里是执行放大收缩的动画操作
     
     - parameter tag: 传入点击的view的tag。 如果点击的是menuBtn这个参数相当于作废。
     */
    private func setupViewAnimation(tag: Int = 0) {
        // 缩放后子控件的宽
        let scaleWidth = vcState == .Small ?scrollView.width:scrollView.width*scale
        // scorllview中心点变化后的值
        let transY = vcState == .Small ?self.view.center.y+UIConstant.UI_MARGIN_10:scrollView.center.y+scrollView.height*(1-scale)*0.5
        let scrollViewTransCenter = CGPoint(x: self.scrollView.center.x, y: transY)
        // contentsize
        let contentSize = vcState == .Small ?CGSize(width: self.view.width*CGFloat(viewArray.count), height: 0):CGSize(width: (scaleWidth+UIConstant.UI_MARGIN_5)*CGFloat(self.viewArray.count), height: 0)
        // transform
        let scrollviewtransform = vcState == .Small ? CGAffineTransformIdentity:CGAffineTransformMakeScale(1, self.scale)
        let scrollsubviewTransform = vcState == .Small ?CGAffineTransformIdentity:CGAffineTransformMakeScale(self.scale, 1)
        // 获取点击后scrollview的contentoffset位置
        let index = vcState == .Small ?tag:Int(scrollView.contentOffset.x/self.view.width)
        var contentOffx = vcState == .Small ?CGFloat(index)*self.view.width:0.5*UIConstant.UI_MARGIN_5+CGFloat(index)*(scaleWidth+UIConstant.UI_MARGIN_5)
        contentOffx = contentOffx > contentSize.width-self.view.width ?contentSize.width-self.view.width:contentOffx
        // 设置头部空间位移差
        if vcState == .Small {
            let headerViewScale = self.view.width/(self.view.width*0.5-headerView.labelArray.last!.width*0.5)
            headerView.x = -contentOffx/headerViewScale
        }
        
        UIView.animateWithDuration(0.4, delay: 0, options: .CurveEaseOut, animations: { [unowned self] in
            // scroollview动画
            self.scrollView.center = scrollViewTransCenter
            self.scrollView.transform = scrollviewtransform
            self.scrollView.contentSize = contentSize
            
            self.scrollView.setContentOffset(CGPoint(x: contentOffx,y: 0), animated: false)
            self.setupViewHidden(tag)
            // 设置srollview子控件的动画
            for i in 0..<self.viewArray.count {
                let view = self.viewArray[i]
                
                view.transform = scrollsubviewTransform
                let centerX = self.vcState == .Small ? scaleWidth*(CGFloat(i)+0.5):(scaleWidth+UIConstant.UI_MARGIN_5)*(CGFloat(i)+0.5)
                view.center = CGPoint(x: centerX, y: view.center.y)
            }
            }) {
                if $0 {

                    // 添加按钮用于点击
                    if self.vcState == .Small {
                        self.coverBtnArray.forEach {
                            $0.removeFromSuperview()
                        }
                    } else {
                        for i in 0..<self.viewArray.count {
                            let view = self.viewArray[i]
                            
                            let coverBtn = self.createCoverBtn()
                            coverBtn.tag = i
                            coverBtn.frame = view.bounds
                            self.coverBtnArray.append(coverBtn)
                            view.addSubview(coverBtn)
                        }
                    }
                    // 设置scrollview
                    self.scrollView.pagingEnabled = self.vcState == .Small ?true:false
                    
                    self.vcState = self.vcState == .Full ?.Small:.Full
                }
        }
    }
    
    /**
     创建一个按钮给Scrollview的5个控制器。便于点击之后恢复成填充状态  整个页面的控制器
     */
    private func createCoverBtn() -> UIButton {
        let coverBtn = UIButton()
        coverBtn.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.02)
        coverBtn.addTarget(self, action: #selector(MainViewController.menuBtnDidClick(_:)), forControlEvents: .TouchUpInside)
        return coverBtn
    }
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath) as MainCollectionViewCell
        cell.childVCView = viewArray[indexPath.row]
        return cell
    }
}

// MARK: - 这里处理collectionview左右滑动时的一些动画（头部控件位移差，菜单分类按钮）
extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // 这里设置hidden是为了处理下拉刷新的判断
        if vcState == .Full {
            // 处理分类按钮左右滑动时淡入淡出动画
            let contentoffx = scrollView.contentOffset.x
            let alpha = 1 - fabs((contentoffx-UIConstant.SCREEN_WIDTH) / UIConstant.SCREEN_WIDTH)
            classifyBtn.hidden = alpha <= 0 ?true: false
            classifyBtn.alpha = alpha
            // 设置头部空间位移差
            let scale = self.view.width/(self.view.width*0.5-headerView.labelArray.last!.width*0.5)
            headerView.x = -scrollView.contentOffset.x/scale

        }
    }
    
}

// MARK: - 这里传headerView给下拉刷新控件做处理
extension MainViewController: ScrollViewControllerReusableDataSource {
    func titleHeaderView() -> MainHeaderView {
        return self.headerView
    }
    
    func redLineView() -> UIView {
        return self.redLine
    }
    
    func menuButton() -> UIButton {
        return self.menuBtn
    }
    
    func classifyButton() -> UIButton {
        return self.classifyBtn
    }
}

//MARK: ------------ ScrollView上下滚动方向改变时调用，用于处理菜单按钮和分类按钮的动画 -----------
extension MainViewController: ScrollViewControllerReusableDelegate {
    func ScrollViewControllerDirectionDidChange(direction: ScrollViewDirection) {
        MenuBtnAnimation(direction)
    }
    
    /**
     菜单按钮动画
     */
    private func MenuBtnAnimation(dir: ScrollViewDirection) {
        // 位移
        let positionAnim = CABasicAnimation(keyPath: "position.y")
        positionAnim.fromValue = (dir == ScrollViewDirection.Down ?classifyBtn.y:-classifyBtn.height)
        // 这里不知为何要加上状态栏20高度
        positionAnim.toValue = (dir == ScrollViewDirection.Down ?(-classifyBtn.height):classifyBtn.y+20)
        
        // alpha
        let alphaAnim = CABasicAnimation(keyPath: "alpha")
        alphaAnim.fromValue = (dir == ScrollViewDirection.Down ?1:0)
        alphaAnim.toValue = (dir == ScrollViewDirection.Down ?0:1)
        
        let group = CAAnimationGroup()
        group.removedOnCompletion = false
        group.fillMode = kCAFillModeForwards
        group.animations = [positionAnim, alphaAnim]
        group.duration = 0.2
        
        classifyBtn.layer.addAnimation(group, forKey: "circleButtonDownAnimation")
        menuBtn.layer.addAnimation(group, forKey: "hamburgButtonAnimation")
    }

}