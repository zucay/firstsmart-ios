//
//  SocketDriver.swift
//  firstsmart-ios
//
//  Created by zuka on 2015/09/26.
//  Copyright © 2015年 zuka. All rights reserved.
//

import Foundation
import SIOSocket

class SocketDriver : NSObject
{
    var socket: SIOSocket! = nil
    var callbacks: [(String)->Void] = []
    
    init(roomName: String) {
        super.init()
        socketInit(roomName)
    }
    
    func onURLChange(callback:(String) -> Void) {
        callbacks += [callback]
    }
    
    private func socketInit(roomName:String = "myroom") {
        SIOSocket.socketWithHost("wss://firstsmart-nodejs.herokuapp.com/", reconnectAutomatically: true, attemptLimit: 10, withDelay: 3, maximumDelay: 120, timeout: 10, response:  { (_socket: SIOSocket!) in
            self.socket = _socket
            
            self.socket.onConnect = {() in
                print("connected")
                self.socket.emit("joinRoom", args: [roomName])
            }
            
            self.socket.onReconnect = {(attempts: Int) in
                print("re-connected")
            }
            
            self.socket.onDisconnect = {() in
                print("disconnected")
                
            }
            
            self.socket.on("msg", callback: {(data:[AnyObject]!)  in
                let url = data[0] as? String
                print(url!)
                for callback in self.callbacks {
                    callback(url!)
                }

            })
        })
    }

}