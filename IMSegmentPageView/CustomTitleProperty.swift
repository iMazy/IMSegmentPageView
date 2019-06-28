//
//  CustomTitleProperty.swift
//  IMSegmentPageView
//
//  Created by Mazy on 2019/6/27.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

class CustomTitleProperty: IMSegmentTitleProperty {
    override init() {
        super.init()
        
        self.indicatorColor = .red
        self.titleNormalFont = UIFont.systemFont(ofSize: 15, weight: .regular)
        self.titleSelectFont = UIFont.systemFont(ofSize: 15, weight: .medium)
        self.indicatorExtension = 20
        self.indicatorHeight = 2
        self.bottomLineColor = UIColor.lightGray.withAlphaComponent(0.5)
        self.titleNormalColor = #colorLiteral(red: 0.7059153914, green: 0.7501759529, blue: 0.7668043971, alpha: 1)
        self.titleSelectColor = .red
    }
}
