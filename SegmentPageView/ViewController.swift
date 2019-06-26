//
//  ViewController.swift
//  SegmentPageView
//
//  Created by Mazy on 2019/6/24.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let property = SegmentTitleProperty()
        property.indicatorExtension = 20
        property.showBottomLine = false
        property.indicatorHeight = 2
        property.bottomLineHeight = 0.5
        property.bottomLineColor = .green
        property.isLeft = false
        property.showBottomLine = true
        property.bottomLineColor = .lightGray
        let titleView = SegmentTitleView(frame: CGRect(x: 0, y: 100, width: 375, height: 40), titles: ["首页", "新闻", "汽车", "首页推荐", "News", "汽车推荐", "美图"], property: property, indicatorType: .width)
        titleView.delegate = self
        titleView.selectIndex = 3
        view.addSubview(titleView)
    }
}

extension ViewController: SegmentTitleViewDelegate {
    func segmentTitleView(_ titleView: SegmentTitleView, startIndex: Int, endIndex: Int) {
        
    }
}

