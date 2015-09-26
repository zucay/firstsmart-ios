//
//  ViewController.swift
//  firstsmart-ios
//
//  Created by zuka on 2015/08/04.
//  Copyright (c) 2015年 zuka. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    let safariUASuffix = " Safari/600.1.4 "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let socket = SocketDriver(roomName: "myroom")
        socket.onURLChange({ (url: String) -> Void in
            self.correctWebViewFrame()
            self.webView.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        correctWebViewFrame()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    override func viewWillAppear(animated: Bool) {
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //シャドウの設定
        self.view.layer.shadowOpacity = 0.5
        self.view.layer.shadowRadius = 5.0
        self.view.layer.shadowColor = UIColor.grayColor().CGColor
        
        // MenuViewControllerを取得して、ECSlidingViewControllerのunderLeftViewController に設定
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        appDelegate.slidingViewController?.underLeftViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Menu")
        
        self.view.addGestureRecognizer(appDelegate.slidingViewController!.panGesture)
        appDelegate.slidingViewController?.anchorRightPeekAmount = 50.0 // スライド時にTOPが見えてる範囲
        
    }
    
    private func correctWebViewFrame() {
        self.webView.frame = UIScreen.mainScreen().bounds
        self.webView.center = self.view.center
    }
    
    


}

