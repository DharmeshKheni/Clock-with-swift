//
//  ViewController.swift
//  ClockSample
//
//  Created by adm on 5/18/15.
//  Copyright (c) 2015 inDabusiness. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let clockShapeLayer = CAShapeLayer()
    
    var timeLeft: NSTimeInterval = 60.0
    var endTime: NSDate!
    var timeLabel =  UILabel()
    var timer = NSTimer()
    
    
    func drawClockShape() {
        clockShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: midX , y: midY), radius:
            130, startAngle: minuteStartAngle.degreesToRadians, endAngle: (minuteStartAngle+360.0).degreesToRadians, clockwise: true).CGPath
        clockShapeLayer.fillColor = UIColor.whiteColor().CGColor
        view.layer.addSublayer(clockShapeLayer)
    }
    
    
    func drawhourShape() {
        hourShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: midX , y: midY), radius:
            40, startAngle: hourStartAngle.degreesToRadians, endAngle: (hourStartAngle+360.0).degreesToRadians, clockwise: true).CGPath
        hourShapeLayer.strokeColor = UIColor.blackColor().CGColor
        hourShapeLayer.fillColor = UIColor.clearColor().CGColor
        hourShapeLayer.lineWidth = 30
        view.layer.addSublayer(hourShapeLayer)
    }
    func drawMinuteShape() {
        minuteShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: midX , y: midY), radius:
            60, startAngle: minuteStartAngle.degreesToRadians, endAngle: (minuteStartAngle+360.0).degreesToRadians, clockwise: true).CGPath
        minuteShapeLayer.strokeColor = UIColor.blackColor().CGColor
        minuteShapeLayer.fillColor = UIColor.clearColor().CGColor
        minuteShapeLayer.lineWidth = 50
        view.layer.addSublayer(minuteShapeLayer)
    }
    func drawTimeLeftShape() {
        secondShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: midX , y: midY), radius:
            100, startAngle: startAngle.degreesToRadians, endAngle: (startAngle+360.0).degreesToRadians, clockwise: true).CGPath
        secondShapeLayer.strokeColor = UIColor.redColor().CGColor
        secondShapeLayer.fillColor = UIColor.clearColor().CGColor
        secondShapeLayer.lineWidth = 50
        view.layer.addSublayer(secondShapeLayer)
    }
    func addTimeLabel() {
        timeLabel = UILabel(frame: CGRectMake(midX-50 , midY-25, 100, 50))
        timeLabel.textAlignment = .Center
        timeLabel.text = NSDate().formated
        view.addSubview(timeLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        midX = view.frame.midX
        midY = view.frame.midY
        view.backgroundColor = UIColor(white: 0.94, alpha: 1.0)
        let now = NSDate().components
        startAngle = (( Double(now.second) + Double(now.nanosecond) / 1000000000.0 )
            * 6) - 90.0
        minuteStartAngle = ( (Double(now.minute) + (Double(now.second)/60.0) ) * 6) - 90.0
        hourStartAngle = ( (Double(now.hour) + (Double(now.minute)/60.0) ) * 30) - 90.0
        drawClockShape()
        
        drawMinuteShape()
        drawhourShape()
        drawTimeLeftShape()
        
        addTimeLabel()
        
        strokeEnd.fromValue = 0.001
        strokeEnd.toValue = 1.0
        strokeEnd.duration = 60.0
        strokeEnd.repeatCount = infinity
        
        strokeStart.fromValue = 0.0
        strokeStart.toValue = 0.999
        strokeStart.duration = 60.0
        strokeStart.repeatCount = infinity
        
        minuteStrokeEnd.fromValue = 0.003
        minuteStrokeEnd.toValue = 1.0
        minuteStrokeEnd.duration = 3600.0
        minuteStrokeEnd.repeatCount = infinity
        
        minuteStrokeStart.fromValue = 0.0
        minuteStrokeStart.toValue = 0.997
        minuteStrokeStart.duration = 3600.0
        minuteStrokeStart.repeatCount = infinity
        
        hourStrokeEnd.fromValue = 0.003
        hourStrokeEnd.toValue = 1.0
        hourStrokeEnd.duration = 43200.0
        hourStrokeEnd.repeatCount = infinity
        
        hourStrokeStart.fromValue = 0.0
        hourStrokeStart.toValue = 0.997
        hourStrokeStart.duration = 43200.0
        hourStrokeStart.repeatCount = infinity
        
        
        secondShapeLayer.addAnimation(strokeEnd, forKey: nil)
        secondShapeLayer.addAnimation(strokeStart, forKey: nil)
        
        minuteShapeLayer.addAnimation(minuteStrokeEnd, forKey: nil)
        minuteShapeLayer.addAnimation(minuteStrokeStart, forKey: nil)
        
        hourShapeLayer.addAnimation(hourStrokeEnd, forKey: nil)
        hourShapeLayer.addAnimation(hourStrokeStart, forKey: nil)
        
        
        endTime = NSDate().dateByAddingTimeInterval(timeLeft)
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateTime", userInfo: nil, repeats: true)
    }
    func updateTime() {
        timeLabel.text = NSDate().formated
    }
    
    
}
extension NSDate {
    var components: NSDateComponents {
        return NSCalendar.currentCalendar().components(NSCalendarUnit(UInt.max), fromDate: self)
    }
    var formated: String {
        return String(format: "%02d:%02d.%02d", components.hour, components.minute, components.second )
    }
}
//extension NSTimeInterval {
//    var time:String {
//        return String(format:"%02d:%02d", Int(self/60.0),  Int(ceil(self%60)) )
//    }
//}
extension Double {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * CGFloat(M_PI) / 180.0
    }
}

