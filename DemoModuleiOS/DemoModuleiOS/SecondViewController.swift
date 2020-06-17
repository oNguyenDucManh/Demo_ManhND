//
//  SecondViewController.swift
//  DemoModuleiOS
//
//  Created by Nguyen Duc Manh on 6/14/20.
//  Copyright © 2020 Nguyen Duc Manh. All rights reserved.
//

import UIKit

class SecondViewController: ViewController{
    var id: Int = 0
    var name: String = ""
    
    @IBOutlet weak var tvParam: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tvParam.text = String(id)+"--"+name
    }
}
