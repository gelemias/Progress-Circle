//
//  RDProgressCircle.swift
//
//  Created by https://github.com/gelemias on 21/02/2018.
//  MIT licence 2018
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software
//  and associated documentation files (the "Software"), to deal in the Software without restriction,
//  including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
//  TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
//  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
//  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import UIKit

extension Float {
    var degreesToRadians: CGFloat { return CGFloat(self) * CGFloat(Double.pi) / 180.0 }
    var radiansToDegrees: CGFloat { return CGFloat(self) * 180 / CGFloat(Double.pi) }
}

class RDProgressCircle: UIControl {

    public var strokeWidth: CGFloat  = 2
    public var strokeColor: UIColor = .black
    public var lineCapStyle: CGLineCap = .butt

    private var startAngle: Float = -90
    private var endAngle: Float = 0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializeUI()
    }

    init(width: CGFloat, strokeWidth: CGFloat, strokeColor: UIColor, startAngle: Float) {
        self.strokeWidth = strokeWidth
        self.startAngle = startAngle
        self.strokeColor = strokeColor

        super.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize(width: width, height: width)))
        self.initializeUI()
    }

    private func initializeUI() {
        self.isOpaque = false
        self.backgroundColor = .clear
    }

    override func draw(_ rect: CGRect) {

        let radius = CGFloat(rect.width / 2) - CGFloat(strokeWidth/2)

        let midPath = UIBezierPath(arcCenter: center,
                                   radius: radius,
                                   startAngle: startAngle.degreesToRadians,
                                   endAngle: Float(endAngle + startAngle).degreesToRadians,
                                   clockwise: true)

        midPath.lineWidth = strokeWidth
        midPath.lineCapStyle = lineCapStyle

        strokeColor.setStroke()
        midPath.stroke()
    }

    open func updateProgress(percentage: Float) {
        self.endAngle = percentage >= 360 ? 360 : percentage
        self.setNeedsDisplay()
    }
}
