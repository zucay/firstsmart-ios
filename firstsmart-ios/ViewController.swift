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
        SIOSocket.socketWithHost("wss://firstsmart-nodejs.herokuapp.com/", response:  { (_socket: SIOSocket!) in
            self.socket = _socket
            
            
            self.socket.onConnect = {() in
                println("connected")
                
                self.socket.emit("joinRoom", args: ["myroom"])
                // self.socket.emit("msg", args: ["hoge"])
            }
            
            self.socket.onDisconnect = {() in
                println("disconnected")
            }
            
            self.socket.on("msg", callback: {(data:[AnyObject]!)  in
                let url = data[0] as? String
                println(url!)
                
                self.webView.frame = UIScreen.mainScreen().bounds
                self.webView.center = self.view.center
                
                
                let userAgent:String! = self.webView.stringByEvaluatingJavaScriptFromString("navigator.userAgent")
                let customUserAgent:String = userAgent.stringByAppendingString(self.safariUASuffix)
                let dic:NSDictionary = ["UserAgent":customUserAgent]
                NSUserDefaults.standardUserDefaults().registerDefaults(dic as [NSObject:AnyObject])
                
                
                self.webView.loadRequest(NSURLRequest(URL: NSURL(string: url!)!))
            })
            
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

