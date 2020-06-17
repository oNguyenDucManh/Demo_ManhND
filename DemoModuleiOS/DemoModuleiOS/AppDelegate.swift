//
//  AppDelegate.swift
//  DemoModuleiOS
//
//  Created by Nguyen Duc Manh on 6/14/20.
//  Copyright © 2020 Nguyen Duc Manh. All rights reserved.
//

import UIKit
import Flutter
// Used to connect plugins (only if you have plugins with iOS platform code).
import FlutterPluginRegistrant


@UIApplicationMain
class AppDelegate: FlutterAppDelegate {
    
    
    
    //    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    //        return true
    //    }
    //
    //    // MARK: UISceneSession Lifecycle
    //
    //    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    //        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    //    }
    //
    //    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    //    }
    
    lazy var flutterEnginePartialScreen = FlutterEngine(name: "flutterEnginePartialScreen")
    lazy var flutterEngineFullScreen = FlutterEngine(name: "flutterEngineFullScreen")
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Runs the default Dart entrypoint with a default Flutter route.
        flutterEnginePartialScreen.run(withEntrypoint: "partialScreenEntryPoint");
        flutterEngineFullScreen.run();
        return super.application(application, didFinishLaunchingWithOptions: launchOptions);
    }
}

