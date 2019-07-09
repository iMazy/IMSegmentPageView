//
//  ViewController.swift
//  SegmentPageView
//
//  Created by Mazy on 2019/6/24.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var titleView: IMSegmentTitleView!
    var pageView: IMPageContentView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        
        let titles0 = ["电影", "影院"]
        let property0 = CustomTitleProperty()
        property0.indicatorType = .none
        property0.isLeft = false
        let titleView0 = IMSegmentTitleView(frame: CGRect(x: 0, y: 0, width: 120, height: 40), titles: titles0, property: property0)
        self.navigationItem.titleView = titleView0
        
        let titles1 = ["今日票房"]
        let property1 = CustomTitleProperty()
        property1.indicatorType = .none
        let titleView1 = IMSegmentTitleView(frame: CGRect(x: 0, y: 0, width: 375, height: 40), titles: titles1, property: property1)
        titleView1.selectIndex = 0
        view.addSubview(titleView1)
        
        let titles2 = ["影剧", "影人", "影院"]
        let property2 = CustomTitleProperty()
        property2.indicatorType = .equalTitle
        property2.indicatorExtension = 40
        let titleView2 = IMSegmentTitleView(frame: CGRect(x: 0, y: 40, width: 375, height: 40), titles: titles2, property: property2)
        view.addSubview(titleView2)
        
        let titles4 = ["正在热映", "即将上映", "经典影片"]
        let property4 = CustomTitleProperty()
        property4.isLeft = false
        property4.indicatorType = .width
        property4.indicatorExtension = 20
        let titleView4 = IMSegmentTitleView(frame: CGRect(x: 0, y: 80, width: 375, height: 40), titles: titles4, property: property4)
        view.addSubview(titleView4)
        
        let titles3 = ["爱情", "喜剧", "动作", "恐怖", "动画"]
        let property3 = CustomTitleProperty()
        property3.isLeft = false
        property3.indicatorExtension = 30
        property3.showBottomLine = true
        property3.indicatorHeight = 1.5
        property3.indicatorType = .width
        let titleView3 = IMSegmentTitleView(frame: CGRect(x: 0, y: 120, width: 375, height: 40), titles: titles3, property: property3)
        view.addSubview(titleView3)
        
        let property = CustomTitleProperty()
        property.indicatorHeight = 3
        property.indicatorType = .width
        property.isLeft = false
        property.showBottomLine = true
        let titles = ["首页", "电影", "影院", "演出", "MV", "榜单", "热点", "商城"]
        self.titleView = IMSegmentTitleView(frame: CGRect(x: 0, y: 160, width: 375, height: 40), titles: titles, property: property)
        titleView.delegate = self
        view.addSubview(titleView!)
        
        var childVCs: [UIViewController] = []
        for title in titles {
            let childVC = DemoTableViewController()
            childVC.title = title
            childVCs.append(childVC)
        }
        
        self.pageView = IMPageContentView(Frame: CGRect(x: 0, y: 40 * 5, width: 375, height: view.bounds.height - 40 * 5 - 64), childVCs: childVCs, parentVC: self)
        pageView.delegate = self
        view.addSubview(pageView!)
    }
}

extension ViewController: IMSegmentTitleViewDelegate {
    
    func segmentTitleView(_ titleView: IMSegmentTitleView, startIndex: Int, endIndex: Int) {
        print(endIndex)
        pageView.contentViewCurrentIndex = endIndex
    }
}

extension ViewController: IMPageContentDelegate {
    
    func contentViewDidScroll(_ contentView: IMPageContentView, startIndex: Int, endIndex: Int, progress: CGFloat) {
        
    }
    
    func contenViewDidEndDecelerating(_ contentView: IMPageContentView, startIndex: Int, endIndex: Int) {
        titleView.selectIndex = endIndex
    }
}

public extension CGFloat {
    /// SwiftRandom extension
    public static func random(_ lower: CGFloat = 0, _ upper: CGFloat = 1) -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (upper - lower) + lower
    }
}

public extension UIColor {
    /// SwiftRandom extension
    static func random(_ randomAlpha: Bool = false) -> UIColor {
        let randomRed   = CGFloat.random()
        let randomGreen = CGFloat.random()
        let randomBlue  = CGFloat.random()
        let alpha       = randomAlpha ? CGFloat.random() : 1.0
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: alpha)
    }
}
