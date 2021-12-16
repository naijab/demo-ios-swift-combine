//
//  AppDelegate.swift
//  DemoCombine
//
//  Created by Nattapon Pondongnok on 16/12/2564 BE.
//

import UIKit
import SwiftyBeaver

let log = SwiftyBeaver.self

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Show on xcode console
        let console = ConsoleDestination()
        log.addDestination(console)
        
        // Show on SwiftyBeaver Mac App
        let platform = SBPlatformDestination(
            appID: "7eZVL8",
            appSecret: "gykjajnrbN4Bftgnw3qdpnwaprhujLng",
            encryptionKey: "pcoq5upCsriduhmuYwe8vqkvkdw5mHuo"
        )

        log.addDestination(platform)
      
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

