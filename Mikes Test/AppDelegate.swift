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

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("didFinishLaunchingWithOptions method called")

        let branch: Branch = Branch.getInstance()
        
        //Enable network logging
        branch.enableLogging()
        
        //disable ad network callout flags
        branch.disableAdNetworkCallouts(false)
        
        //$adobe_visitor_id will appear in open event network call
        branch.setRequestMetadataKey("$adobe_visitor_id", value: "123423")
        //$marketing_cloud_visitor_id will appear in OPEN network call
        let mid: String = "3456"
        branch.setRequestMetadataKey("$marketing_cloud_visitor_id", value:mid as NSObject?);
        //arbitrary values can be set in event metadata (check liveview)
        branch.setRequestMetadataKey("$rbuid", value:"yo");
        
        //Disable tracking
        //Branch.setTrackingDisabled(true)

        
        //Re-enable tracking (must be called)
        //Branch.setTrackingDisabled(false)
        
        
        //FB SDK callout
        //branch.registerFacebookDeepLinkingClass(<#T##FBSDKAppLinkUtility: Any!##Any!#>);
        
        
        //Unit testing simulation with quick link where link created with custom subdomain, and domain changed to app.link
        //branch.handleDeepLink(withNewSession: URL(string: "https://app.chewy.com/sT0riCToW7"))
        

        //Unit testing simulation with quick link (analytics values hardcoded) with analytics & utm query params (dashboard analytics > query > utm) + $original_url set in dashboard link data won't be scraped
        branch.handleDeepLink(withNewSession: URL(string: "https://kwon36.app.link/almtLkYUO5?&~tags=set_in_query&~campaign=set_in_query&~feature=set_in_query&~channel=set_in_query&~keyword=set_in_query&utm_medium=set_in_utm&utm_campaign=set_in_utm&utm_source=set_in_utm&utm_content=set_in_utm&utm_term=set_in_utm"))
        

        //Unit testing $web_only link simulation
        //branch.handleDeepLink(withNewSession: URL(string: "https://kwon36.app.link?$web_only=true&$original_url=https%3A%2F%2Fmikekwon36.github.io%2F%3Futm_medium%3Dset_in_app&utm_campaign=set_in_app"))

        
        //Unit testing adwords short link (no analytics values hardcoded <-- always win out) with analytics & utm query params
        //branch.handleDeepLink(withNewSession: URL(string: "https://kwon36.app.link/1hNGqV6TO5?%243p=a_google_adwords&%24always_deeplink=false&gclid=set_in_query&lpurl=set_in_query&~ad_set_id=set_in_query&~campaign_id=set_in_query&~channel=set_in_query&~keyword=set_in_query&~placement=set_in_query&utm_medium=set_in_utm&utm_campaign=set_in_utm&utm_source=set_in_utm&utm_content=set_in_utm&utm_term=set_in_utm"))

        
        //Unit testing adwords LONG link (no analytics values hardcoded) with analytics & utm query params (utm queries take priority) <-- EO saves "paid advertising" in exports & dashboard (but LATD shows ~feature="set_in_utm"... bug??
        //branch.handleDeepLink(withNewSession: URL(string: "https://kwon36.app.link?publisher_ref_id=test&%243p=a_1plusads&%24always_deeplink=false&gclid=set_in_query&lpurl=set_in_query&~ad_set_id=set_in_query&~feature=set_in_query&~campaign_id=set_in_query&~channel=set_in_query&~keyword=set_in_query&~placement=set_in_query&utm_medium=set_in_utm&utm_campaign=set_in_utm&utm_source=set_in_utm&utm_content=set_in_utm&utm_term=set_in_utm"))

        
        print("branch object instantiated at " + branch.debugDescription)
        branch.initSession(launchOptions: launchOptions, andRegisterDeepLinkHandler: {params, error in
            print("Branch initSession function called")
            // If the key 'kwon' is present in the deep link dictionary
            if error == nil && params?["kwon"] != nil {
                self.GlobalDeepLinkTextVariable = params?["kwon"] as! String
                print(params ?? "init callback params")
            }
            
            if (params!["$web_only"] as? Bool) ?? false {
                print(params ?? "web only callback params")
            }
            
            print(params ?? "init callback params")
            branch.lastAttributedTouchData(withAttributionWindow:30) { (BranchLastAttributedTouchData) in
                print("LATD Callback executed")
                if let latd = BranchLastAttributedTouchData?.lastAttributedTouchJSON["data"] as? [String: Any] {
                    print(latd["~campaign"] ?? "LATD ~campaign")
                }
                print(BranchLastAttributedTouchData?.lastAttributedTouchJSON["data"] ?? "LATD data")
                //print(BranchLastAttributedTouchData?.lastAttributedTouchJSON.description ?? "LATD callback")
            }
        })
        
        return true
    }
    
    // Respond to URI scheme links
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // pass the url to the handle deep link call
        print("open url: URL, options: called")
        Branch.getInstance().application(app, open: url, options:options)
        
        // do other deep link routing for the Facebook SDK, Pinterest SDK, etc
        return true
    }
    
    // Respond to URI scheme links (deprecated - OLD)
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        print("open url: URL, sourceApplication: called")
        Branch.getInstance().application(application,
                                         open: url,
                                         sourceApplication: sourceApplication,
                                         annotation: annotation
        )
        return true
    }
    
    // Respond to URI scheme links (deprecated - OLDEST)
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        print("handleOpen url: URL called")
        Branch.getInstance().handleDeepLink(url)
        return true
    }
    
    // Respond to Universal Links
    private func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        print("continue userActivity: NSUserActivity called")
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

