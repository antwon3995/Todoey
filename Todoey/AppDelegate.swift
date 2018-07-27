//
//  AppDelegate.swift
//  Todoey
//
//  Created by Anthony Yan on 7/24/18.
//  Copyright © 2018 Anthony Yan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        //called when within the app, the user for example, gets a call. Makes sure the data is saved
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        //called when the app is exited but is running in the background
        print("applicationDidEnterBackground")
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("applicationWillTerminate") 
    }


}

