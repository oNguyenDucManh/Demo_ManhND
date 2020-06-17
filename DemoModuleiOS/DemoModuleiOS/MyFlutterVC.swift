//
//  MyFlutterVC.swift
//  DemoModuleiOS
//
//  Created by Nguyen Duc Manh on 6/14/20.
//  Copyright © 2020 Nguyen Duc Manh. All rights reserved.
//

import Foundation
import Flutter

class MyFlutterVC: FlutterViewController{
    var flutterChannel: FlutterMethodChannel!
    var param: String!
    var screenChose: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flutterChannel = FlutterMethodChannel(name: Bundle.main.bundleIdentifier!,binaryMessenger: self.binaryMessenger)
        
        flutterChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch call.method {
            case "getParam":
                result(self?.param)
            case "exitFlutter":
                self?.exitFlutter()
            case "gotoSecondPage":
                self?.gotoSecondPage(call: call)
            default:
                result(FlutterMethodNotImplemented)
                return
            }
        })
        flutterChannel.invokeMethod("notifyNavToFlutter", arguments: screenChose)
    }
    
    func exitFlutter() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func gotoSecondPage(call: FlutterMethodCall){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        guard let args = call.arguments else {
            return
        }
        if let myArgs = args as? [String: Any],
            let id = myArgs["id"] as? Int,
            let name = myArgs["name"] as? String {
            newViewController.id = id
            newViewController.name = name
        } else {
          
        }
        self.present(newViewController, animated: true, completion: nil)
    }
}
