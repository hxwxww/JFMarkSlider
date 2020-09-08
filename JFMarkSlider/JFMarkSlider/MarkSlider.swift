//
//  MarkSlider.swift
//  JFMarkSlider
//
//  Created by HongXiangWen on 2020/9/8.
//  Copyright © 2020 WHX. All rights reserved.
//

import UIKit

open class MarkSlider: UISlider {

    public enum MarkStyle {
        case shape(width: CGFloat, height: CGFloat, cornerRadius: CGFloat)
        case image(image: UIImage)
    }
   
    open var markValues: [Float] = [] {
        didSet {
            adjustValue(for: value)
        }
    }
    
    open override var value: Float {
        didSet {
            adjustValue(for: value)
        }
    }
    
    open var isStayToMark: Bool = true
    
    open var markStyle: MarkStyle = .shape(width: 4, height: 8, cornerRadius: 2)
    
    open var minimumMarkTintColor: UIColor = .blue
    
    open var maximumMarkTintColor: UIColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)

    private var validMarkValues: [Float] {
        var _markValues = markValues.uniqued.filter { $0 > minimumValue && $0 < maximumValue }.sorted()
        // 加入两个端点
        _markValues.insert(minimumValue, at: 0)
        _markValues.append(maximumValue)
        return _markValues
    }
    
    private var markContentView: UIView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addTarget(self, action: #selector(valueDidChange), for: .valueChanged)
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawMarks(in: rect)
    }
    
    private func drawMarks(in rect: CGRect) {
        /** 由于UISlider的轨道都是Subview，使用CoreGraphics会使mark位于轨道之下，固不使用
         ```
         let context = UIGraphicsGetCurrentContext()!
         let trackFrame = trackRect(forBounds: rect)
         let _markValues = validMarkValues
         for i in 0 ..< _markValues.count {
             let markValue = _markValues[i]
             let thumbFrame = thumbRect(forBounds: rect, trackRect: trackFrame, value: markValue)
             switch markStyle {
             case .shape(let width, let height, let cornerRadius):
                 let markRect = CGRect(x: thumbFrame.midX - width / 2, y: thumbFrame.midY - height / 2, width: width, height: height)
                 let markPath = UIBezierPath(roundedRect: markRect, cornerRadius: cornerRadius)
                 context.addPath(markPath.cgPath)
                 context.setFillColor(markValue > value ? maximumMarkTintColor.cgColor : minimumMarkTintColor.cgColor)
                 context.fillPath()
             case .image(let image):
                 let imageWidth = image.size.width
                 let imageHeight = image.size.height
                 let markRect = CGRect(x: thumbFrame.midX - imageWidth / 2, y: thumbFrame.midY - imageHeight / 2, width: imageWidth, height: imageHeight)
                 (markValue > value ? maximumMarkTintColor : minimumMarkTintColor).setFill()
                 UIRectFill(markRect)
                 image.draw(in: markRect, blendMode: .destinationIn, alpha: 1)
             }
         }
         ```
         */
        if markContentView != nil {
            markContentView.removeFromSuperview()
        }
        markContentView = UIView(frame: rect)
        markContentView.backgroundColor = .clear
        markContentView.isUserInteractionEnabled = false
        let trackViews = getSubviews(UIView.self)
        if let minimumTrackView = trackViews.last {
            insertSubview(markContentView, aboveSubview: minimumTrackView)
        } else {
            addSubview(markContentView)
        }
        let trackFrame = trackRect(forBounds: rect)
        let _markValues = validMarkValues
        for i in 0 ..< _markValues.count {
            let markValue = _markValues[i]
            let thumbFrame = thumbRect(forBounds: rect, trackRect: trackFrame, value: markValue)
            switch markStyle {
            case .shape(let width, let height, let cornerRadius):
                let markRect = CGRect(x: thumbFrame.midX - width / 2, y: thumbFrame.midY - height / 2, width: width, height: height)
                let markView = UIView(frame: markRect)
                markView.layer.masksToBounds = true
                markView.layer.cornerRadius = cornerRadius
                markView.backgroundColor = markValue > value ? maximumMarkTintColor : minimumMarkTintColor
                markContentView.addSubview(markView)
            case .image(let image):
                let imageWidth = image.size.width
                let imageHeight = image.size.height
                let markRect = CGRect(x: thumbFrame.midX - imageWidth / 2, y: thumbFrame.midY - imageHeight / 2, width: imageWidth, height: imageHeight)
                let markView = UIImageView(frame: markRect)
                markView.image = image
                markView.tintColor = markValue > value ? maximumMarkTintColor : minimumMarkTintColor
                markContentView.addSubview(markView)
            }
        }
    }
}

extension MarkSlider {
    
    private func adjustValue(for currentValue: Float) {
        if isStayToMark {
            let adjustedValue = validMarkValues.sorted(by: { abs($0 - currentValue) < abs($1 - currentValue) }).first!
            setValue(adjustedValue, animated: false)
        } else {
            setValue(currentValue, animated: false)
        }
        setNeedsDisplay()
    }
    
    @objc private func valueDidChange() {
        adjustValue(for: value)
    }
    
    open override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let value = touchedValue(at: touch.location(in: self))
        adjustValue(for: value)
        return true
    }
    
    private func touchedValue(at location: CGPoint) -> Float {
        let trackFrame = trackRect(forBounds: bounds)
        let thumbFrame = thumbRect(forBounds: bounds, trackRect: trackFrame, value: minimumValue)
        let totalWidth = trackFrame.width - thumbFrame.width
        let convertedX = location.x - trackFrame.minX - thumbFrame.width / 2
        let value = Float(convertedX / totalWidth) * (maximumValue - minimumValue) + minimumValue
        return value
    }
}
