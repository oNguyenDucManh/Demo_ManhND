//
//  ViewController.swift
//  DemoModuleiOS
//
//  Created by Nguyen Duc Manh on 6/14/20.
//  Copyright © 2020 Nguyen Duc Manh. All rights reserved.
//

import UIKit
import Flutter

class ViewController: UIViewController {
    
    var flutterEnginePartialScreen: FlutterEngine!
    var flutterEngineFullScreen: FlutterEngine!
    var flutterViewController: FlutterViewController!
    var flutterChannel: FlutterMethodChannel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func gotoHome(_ sender: UIButton) {
        flutterEngineFullScreen = (UIApplication.shared.delegate as! AppDelegate).flutterEngineFullScreen
        let myflutterVC = MyFlutterVC(engine: flutterEngineFullScreen, nibName: nil, bundle: nil)
        myflutterVC.modalPresentationStyle = .fullScreen
        //        myflutterVC.param = tfString.text
        //        myflutterVC.screenChose = screenChose
        myflutterVC.screenChose = "HomePage"
        self.present(myflutterVC, animated: true, completion: nil)
    }
    
    
    @IBAction func goToDetail(_ sender: UIButton) {
        flutterEngineFullScreen = (UIApplication.shared.delegate as! AppDelegate).flutterEngineFullScreen
        let myflutterVC = MyFlutterVC(engine: flutterEngineFullScreen, nibName: nil, bundle: nil)
        myflutterVC.modalPresentationStyle = .fullScreen
        myflutterVC.param = "456"
        myflutterVC.screenChose = "DetailPage"
        self.present(myflutterVC, animated: true, completion: nil)
    }
    
}

