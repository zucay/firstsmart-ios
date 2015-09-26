//
//  MenuViewController.swift
//  firstsmart-ios
//
//  Created by zuka on 2015/09/02.
//  Copyright (c) 2015年 zuka. All rights reserved.
//

import UIKit
class MenuViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var connectionTokenField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.connectionTokenField.delegate = self;
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true);
        return false;
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        print(textField.text, terminator: "")
    }
}

