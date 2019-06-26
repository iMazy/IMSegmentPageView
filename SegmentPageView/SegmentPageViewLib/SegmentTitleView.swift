//
//  SegmentTitleView.swift
//  SegmentPageView
//
//  Created by Mazy on 2019/6/24.
//  Copyright © 2019 Mazy. All rights reserved.
//

import UIKit

enum IndicatorType {
    case `default`
    case equalTitle
    case custom
    case width
    case none
}

protocol SegmentTitleViewDelegate: NSObjectProtocol {
    
    /// 切换标题
    ///
    /// - Parameters:
    ///   - titleView:
    ///   - startIndex: 切换前标题索引
    ///   - endIndex: 切换后标题索引
    func segmentTitleView(_ titleView: SegmentTitleView, startIndex: Int, endIndex: Int)
    
}

class SegmentTitleView: UIView {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    private var itemButtons: [UIButton] = []
    private var indicatorView: UIView = UIView()
    private var indicatorType: IndicatorType = .default

    weak var delegate: SegmentTitleViewDelegate?
    ///
    private var titles: [String] = []
    
    /// 是否靠左 默认是 yes
    var isLeft: Bool = true {
        didSet {
            itemButtons.forEach { (button) in
                if isLeft {
                    button.contentHorizontalAlignment = .left
                } else {
                    button.contentHorizontalAlignment = .center
                }
            }
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    /// 标题文字间距，默认20
    var itemMargin: CGFloat = 20
    /// 当前选中标题索引，默认0
    var selectIndex: Int = 0 {
        didSet {
            if selectIndex <= 0 || selectIndex > itemButtons.count - 1 {
                return
            }
            let lastButton = scrollView.viewWithTag(selectIndex + 666) as! UIButton
            lastButton.isSelected = false
            lastButton.titleLabel?.font = titleNormalFont
            
        }
    }
    /// 标题字体大小，默认15
    var titleNormalFont: UIFont = UIFont.systemFont(ofSize: 15) {
        didSet {
            itemButtons.forEach({ $0.titleLabel?.font = titleNormalFont })
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    /// 标题选中字体大小，默认15
    var titleSelectFont: UIFont = UIFont.systemFont(ofSize: 15) {
        didSet {
            itemButtons.forEach({ $0.titleLabel?.font = $0.isSelected ? titleSelectFont : titleNormalFont })
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    /// 标题正常颜色，默认black
    var titleNormalColor: UIColor = UIColor.black {
        didSet {
            itemButtons.forEach({ $0.setTitleColor(titleNormalColor, for: .normal) })
        }
    }
    /// 标题选中颜色，默认red
    var titleSelectColor: UIColor = UIColor.red {
        didSet {
            itemButtons.forEach({ $0.setTitleColor(titleSelectColor, for: .selected) })
        }
    }
    /// 指示器颜色，默认与titleSelectColor一样,在FSIndicatorTypeNone下无效
    var indicatorColor: UIColor = UIColor.red {
        didSet {
            indicatorView.backgroundColor = indicatorColor
        }
    }
    /// 在FSIndicatorTypeCustom时可自定义此属性，为指示器一端延伸长度，默认5
    /// IndicatorType.width 共用这个属性
    var indicatorExtension: CGFloat = 5 {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    /// indicator height 默认2
    var indicatorHeight: CGFloat = 2
    
    convenience init(frame: CGRect, titles: [String], delegate: SegmentTitleViewDelegate, indicatorType: IndicatorType) {
        self.init(frame: frame)
        
        self.titles = titles
        self.delegate = delegate
        self.indicatorType = indicatorType
        setupTitles()
        
    }
    
    private func setupTitles() {
        
        for title in titles {
            let button = UIButton(type: .custom)
            button.tag = self.itemButtons.count + 666
            button.setTitle(title, for: .normal)
            button.setTitleColor(titleNormalColor, for: .normal)
            button.setTitleColor(titleSelectColor, for: .selected)
            if isLeft {
                button.contentHorizontalAlignment = .left
            } else {
                button.contentHorizontalAlignment = .center
            }
            button.titleLabel?.font = titleNormalFont
            self.scrollView.addSubview(button)
            button.addTarget(self, action: #selector(buttonClickAction(sender:)), for: .touchUpInside)
            if itemButtons.count == self.selectIndex {
                button.isSelected  = true
            }
            itemButtons.append(button)
        }
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    
    @objc func buttonClickAction(sender: UIButton) {
        let index = sender.tag - 666
        if index == self.selectIndex {
            return
        }
        self.delegate?.segmentTitleView(self, startIndex: self.selectIndex, endIndex: index)
        self.selectIndex = index
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.scrollView.frame = self.bounds
        if self.itemButtons.count <= 0 {
            return
        }
        
        var totalButtonWidth: CGFloat = 0
        
        if titleNormalFont != titleSelectFont {
            for (i, title) in titles.enumerated() {
                let button = itemButtons[i]
                let titleFont  = button.isSelected ? titleSelectFont : titleNormalFont
                let itemButtonWidth = title.widthOfString(usingFont: titleFont) + itemMargin
                totalButtonWidth += itemButtonWidth
            }
        } else {
            for title in titles {
                let itemButtonWidth = title.widthOfString(usingFont: titleNormalFont) + itemMargin
                totalButtonWidth += itemButtonWidth
            }
        }
        
        if totalButtonWidth <= self.bounds.width { // //不能滑动
            if isLeft {
                var currentX: CGFloat = 0
                for (i, title) in titles.enumerated() {
                    let button = itemButtons[i]
                    let titleFont = button.isSelected ? titleSelectFont : titleNormalFont
                    let itemButtonWidth = title.widthOfString(usingFont: titleFont) + itemMargin
                    let itemButtonHeight = self.bounds.height
                    button.frame = CGRect(x: currentX, y: 0, width: itemButtonWidth, height: itemButtonHeight)
                    currentX += itemButtonWidth
                }
                scrollView.contentSize = CGSize(width: currentX, height: scrollView.bounds.height)
            } else {
                let itemButtonWidth = self.bounds.width / CGFloat(itemButtons.count)
                let itemButtonHeight = self.bounds.height
                itemButtons.enumerated().forEach { (index, button) in
                    button.frame = CGRect(x: CGFloat(index) * itemButtonWidth, y: 0, width: itemButtonWidth, height: itemButtonHeight)
                }
                scrollView.contentSize = CGSize(width: self.bounds.width, height: scrollView.bounds.height)
            }
        } else { //超出屏幕 可以滑动
            var currentX: CGFloat = 0
            for (i, title) in titles.enumerated() {
                let button = itemButtons[i]
                let titleFont  = button.isSelected ? titleSelectFont : titleNormalFont
                let itemButtonWidth = title.widthOfString(usingFont: titleFont) + itemMargin
                let itemButtonHeight = self.bounds.height
                button.frame = CGRect(x: currentX, y: 0, width: itemButtonWidth, height: itemButtonHeight)
                currentX += itemButtonWidth
            }
            scrollView.contentSize = CGSize(width: currentX, height: self.scrollView.bounds.height)
        }
        //
        moveIndicatorView(animated: true)
    }
    
    /// 移动指示器
    ///
    /// - Parameter animated: 是否有动画
    func moveIndicatorView(animated: Bool) {
        let selectButton = itemButtons[selectIndex]
        let titleFont = selectButton.isSelected ? titleSelectFont : titleNormalFont
        let indicatorWidth = titles[selectIndex].widthOfString(usingFont: titleFont)
        
        let scrollViewHeight = scrollView.bounds.height
        UIView.animate(withDuration: animated ? 0.25 : 0, animations: {
            switch self.indicatorType {
            case .default:
                self.indicatorView.frame = CGRect(x: selectButton.frame.origin.x, y: scrollViewHeight - self.indicatorHeight,
                                                  width: selectButton.bounds.width, height: self.indicatorHeight)
            case .equalTitle:
                self.indicatorView.center = CGPoint(x: selectButton.center.x, y: scrollViewHeight - self.indicatorHeight)
                self.indicatorView.bounds = CGRect(x: 0, y: 0, width: indicatorWidth, height: self.indicatorHeight)
            case .custom:
                self.indicatorView.center = CGPoint(x: selectButton.center.x, y: scrollViewHeight - self.indicatorHeight)
                self.indicatorView.bounds = CGRect(x: 0, y: 0, width: indicatorWidth + self.indicatorExtension * 2,
                                                   height: self.indicatorHeight)
            case .width:
                self.indicatorView.center = CGPoint(x: selectButton.center.x, y: scrollViewHeight - self.indicatorHeight)
                self.indicatorView.bounds = CGRect(x: 0, y: 0, width: self.indicatorExtension, height: self.indicatorHeight)
            case .none:
                self.indicatorView.frame = .zero
            }
        }, completion: { _ in
            self.scrollSelectButtonCenter(animated: animated)
        })
    }
    
    private func scrollSelectButtonCenter(animated: Bool) {
        let selectButton = itemButtons[selectIndex]
        let centerRect = CGRect(x: selectButton.center.x - scrollView.bounds.width / 2, y: 0,
                                width: scrollView.bounds.width, height: scrollView.bounds.height)
        scrollView.scrollRectToVisible(centerRect, animated: animated)
    }
}

private extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
}
