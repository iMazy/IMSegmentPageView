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
        
        let property = CustomTitleProperty()
//        property.indicatorExtension = 20
//        property.showBottomLine = false
        property.indicatorHeight = 3
        property.indicatorType = .width
//        property.bottomLineHeight = 0.5
//        property.bottomLineColor = .green
//        property.isLeft = false
//        property.showBottomLine = true
//        property.bottomLineColor = .lightGray
        property.isLeft = false
        property.showBottomLine = true
//        let titles = ["最受欢迎"]
//        let titles = ["ZIXUAN", "mingren", "huarenmingxing", "shuzihongren", "tongzhen", "KOL", "
        let titles = ["1天", "7天"]
        self.titleView = IMSegmentTitleView(frame: CGRect(x: 0, y: 100, width: 375, height: 40), titles: titles, property: property)
        titleView.delegate = self
//        titleView.backgroundColor = .red
//        titleView.selectIndex = 3
        view.addSubview(titleView!)
        
        var childVCs: [UIViewController] = []
        for i in titles {
            let childVC = UIViewController()
            childVC.view.backgroundColor = UIColor.random()
            childVC.title = i
            childVCs.append(childVC)
        }
        
        self.pageView = IMPageContentView(Frame: CGRect(x: 0, y: 150, width: 375, height: 400), childVCs: childVCs, parentVC: self)
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
        print(endIndex)
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
