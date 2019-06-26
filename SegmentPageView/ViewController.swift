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
        
        let titleView = SegmentTitleView(frame: CGRect(x: 0, y: 100, width: 200, height: 40), titles: ["首页", "新闻", "汽车"], delegate: self, indicatorType: .width)
        titleView.indicatorExtension = 20
        titleView.isLeft = false
        view.addSubview(titleView)
    }
}

extension ViewController: SegmentTitleViewDelegate {
    func segmentTitleView(_ titleView: SegmentTitleView, startIndex: Int, endIndex: Int) {
        
    }
}

