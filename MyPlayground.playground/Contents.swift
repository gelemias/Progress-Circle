//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

extension Float {
    var degreesToRadians: CGFloat { return CGFloat(self) * CGFloat(Double.pi) / 180.0 }
    var radiansToDegrees: CGFloat { return CGFloat(self) * 180 / CGFloat(Double.pi) }
}

class RDProgressCircle: UIControl {

    private let maxDegree = Float(Double.pi * 2).radiansToDegrees

    var strokeWidth: CGFloat  = 2
    var strokeColor: UIColor = .black
    var startAngle: Float = -90
    var endAngle: Float = 0

    init(width: CGFloat, strokeWidth: CGFloat, strokeColor: UIColor, startAngle: Float) {
        self.strokeWidth = strokeWidth
        self.startAngle = startAngle
        self.strokeColor = strokeColor

        super.init(frame: CGRect.init(origin: CGPoint.zero,
                                      size: CGSize(width: width, height: width)))
        self.isOpaque = false
        self.backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

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
        midPath.lineCapStyle = .butt

        strokeColor.setStroke()
        midPath.stroke()
    }

    // from 0 to 1
    open func updateProgress(percentage: Float) {
        self.endAngle = percentage >= 1 ? Float(maxDegree) : percentage * Float(maxDegree)
        self.setNeedsDisplay()
    }
}

class MyViewController : UIViewController {

    var percent: Float = 0
    let proCircle = RDProgressCircle.init(width: 200,
                               strokeWidth: 16,
                               strokeColor: .orange,
                               startAngle: -90)

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        view.addSubview(proCircle)        
        self.view = view

        Timer.scheduledTimer(timeInterval: 0.1,
                             target: self,
                             selector: #selector(updateCounting),
                             userInfo: nil, repeats: true)
    }


    @objc func updateCounting() {
        percent = percent > 1 ? 0 : percent + 0.01
        self.proCircle.updateProgress(percentage: percent)
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = MyViewController()
