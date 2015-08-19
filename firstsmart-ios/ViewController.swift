//
//  ViewController.swift
//  firstsmart-ios
//
//  Created by zuka on 2015/08/04.
//  Copyright (c) 2015年 zuka. All rights reserved.
//

import UIKit
import SIOSocket

class ViewController: UIViewController {
    var socket:SIOSocket! = nil
    @IBOutlet weak var webView: UIWebView!
    let safariUASuffix = " Safari/600.1.4 "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        socketInit()
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
    
    private func correctWebViewFrame() {
        self.webView.frame = UIScreen.mainScreen().bounds
        self.webView.center = self.view.center
    }
    
    private func socketInit() {
        SIOSocket.socketWithHost("wss://firstsmart-nodejs.herokuapp.com/", reconnectAutomatically: true, attemptLimit: 10, withDelay: 3, maximumDelay: 120, timeout: 10, response:  { (_socket: SIOSocket!) in
            self.socket = _socket
            
            self.socket.onConnect = {() in
                println("connected")
                self.socket.emit("joinRoom", args: ["myroom"])
            }
            
            self.socket.onReconnect = {(attempts: Int) in
                println("re-connected")
            }
            
            self.socket.onDisconnect = {() in
                println("disconnected")
                
            }
            
            self.socket.on("msg", callback: {(data:[AnyObject]!)  in
                let url = data[0] as? String
                println(url!)
                self.correctWebViewFrame()
                self.webView.loadRequest(NSURLRequest(URL: NSURL(string: url!)!))
            })
        })
    }
    


}

