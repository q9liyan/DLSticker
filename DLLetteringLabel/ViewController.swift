//
//  ViewController.swift
//  DLLetteringLabel
//
//  Created by mac1012 on 2017/7/28.
//  Copyright © 2017年 DianlE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let rect = CGRect(x: 150, y: 150, width: 200, height: 150)
        let labelView = DLLabelView(frame: rect, superView: self.view)
        self.view.addSubview(labelView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

