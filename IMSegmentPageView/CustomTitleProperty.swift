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
        
        self.indicatorColor = #colorLiteral(red: 0, green: 0.3185221255, blue: 0.5173624754, alpha: 1)
        self.titleNormalFont = UIFont.systemFont(ofSize: 15, weight: .regular)
        self.titleSelectFont = UIFont.systemFont(ofSize: 15, weight: .medium)
        self.indicatorExtension = 20
        self.indicatorHeight = 2
        self.titleNormalColor = #colorLiteral(red: 0.7059153914, green: 0.7501759529, blue: 0.7668043971, alpha: 1)
        self.titleSelectColor = #colorLiteral(red: 0, green: 0.3185221255, blue: 0.5173624754, alpha: 1)
    }
}
