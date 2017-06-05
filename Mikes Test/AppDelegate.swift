//
//  AppDelegate.swift
//  Mikes Test
//
//  Created by Michael Kwon on 6/4/17.
//  Copyright © 2017 Michael Kwon. All rights reserved.
//

import UIKit
import Branch

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var GlobalDeepLinkTextVariable: String = "Deep Link Data empty"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let branch = Branch.getInstance()
        print("didFinishLaunching method called & branch object instantiated at " + branch.debugDescription)
        branch?.initSession(launchOptions: launchOptions, andRegisterDeepLinkHandler: {params, error in
            print("Branch initSession function called")
            // If the key 'kwon' is present in the deep link dictionary
            if error == nil && params?["kwon"] != nil {
                self.GlobalDeepLinkTextVariable = params?["kwon"] as! String
            }
            print(params?["kwon"] ?? "no deep link data found in branch object")
        })
        
        return true
    }
    
    // Respond to URI scheme links
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        // pass the url to the handle deep link call
        print("URI Scheme function called")
        Branch.getInstance().application(application,
                                         open: url,
                                         sourceApplication: sourceApplication,
                                         annotation: annotation
        )
        
        // do other deep link routing for the Facebook SDK, Pinterest SDK, etc
        return true
    }
    
    // Respond to Universal Links
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        // pass the url to the handle deep link call
        print("Universal Links function called")
        Branch.getInstance().continue(userActivity)
        
        return true
    }
    
    
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        print("applicationWillResignActive function called")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("applicationDidEnterBackground function called")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        print("applicationWillEnterForeground function called")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("applicationDidBecomeActive function called")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("applicationWillTerminate function called")
    }


}

