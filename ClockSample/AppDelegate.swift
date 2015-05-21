//
//  AppDelegate.swift
//  ClockSample
//
//  Created by adm on 5/18/15.
//  Copyright (c) 2015 inDabusiness. All rights reserved.
//

import UIKit

let infinity = Float.infinity

let secondShapeLayer = CAShapeLayer()
let minuteShapeLayer = CAShapeLayer()
let hourShapeLayer = CAShapeLayer()

let strokeStart = CABasicAnimation(keyPath: "strokeStart")
let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
let minuteStrokeStart = CABasicAnimation(keyPath: "strokeStart")
let minuteStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
let hourStrokeStart = CABasicAnimation(keyPath: "strokeStart")
let hourStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")

var startAngle = 0.0
var minuteStartAngle = 0.0
var hourStartAngle = 0.0

var midX : CGFloat  = 0.0
var midY : CGFloat  = 0.0


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        hourShapeLayer.hidden = true
        minuteShapeLayer.hidden = true
        secondShapeLayer.hidden = true
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        hourShapeLayer.hidden = false
        minuteShapeLayer.hidden = false
        secondShapeLayer.hidden = false
        let now = NSDate().components
        startAngle = (( Double(now.second) + Double(now.nanosecond) / 1000000000.0 )
            * 6) - 90.0
        minuteStartAngle = ( (Double(now.minute) + (Double(now.second)/60.0) ) * 6) - 90.0
        hourStartAngle = ( (Double(now.hour) + (Double(now.minute)/60.0) ) * 30) - 90.0
        
        hourShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: midX , y: midY), radius:
            40, startAngle: hourStartAngle.degreesToRadians, endAngle: (hourStartAngle+360.0).degreesToRadians, clockwise: true).CGPath
        minuteShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: midX , y: midY), radius:
            60, startAngle: minuteStartAngle.degreesToRadians, endAngle: (minuteStartAngle+360.0).degreesToRadians, clockwise: true).CGPath
        secondShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: midX , y: midY), radius:
            100, startAngle: startAngle.degreesToRadians, endAngle: (startAngle+360.0).degreesToRadians, clockwise: true).CGPath

        
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
        
        
//        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateTime", userInfo: nil, repeats: true)

    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

