//
//  AppDelegate.swift
//  tips
//
//  Created by Christian Deonier on 12/24/15.
//  Copyright © 2015 codepath. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let DEFAULT_BILL_AMOUNT = "bill_amount"
    let DEFAULT_BILL_SAVED_TIME = "bill_saved_time"
    let NUM_SECONDS_TO_SAVE_BILL_AMOUNT = 10 * 60;
    
    let theme = Theme()

    var window: UIWindow?
    var billAmount: Double?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if billAmount != nil {
            defaults.setDouble(billAmount!, forKey: DEFAULT_BILL_AMOUNT)
            defaults.setObject(NSDate(), forKey: DEFAULT_BILL_SAVED_TIME)
            defaults.synchronize()
        }
    }

    func applicationDidBecomeActive(application: UIApplication) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if  let savedBillDate = defaults.objectForKey(DEFAULT_BILL_SAVED_TIME) {
            if Int(NSDate().timeIntervalSinceDate(savedBillDate as! NSDate)) < NUM_SECONDS_TO_SAVE_BILL_AMOUNT {
                billAmount = defaults.doubleForKey(DEFAULT_BILL_AMOUNT)
            }
        } else {
            billAmount = nil
        }
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

