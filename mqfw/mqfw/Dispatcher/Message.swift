//
//  Message.swift
//  POS
//
//  Created by Gal Blank on 1/27/16.
//  Copyright © 2016 Gal Blank. All rights reserved.
//

import UIKit
import CoreFoundation

open class Message:NSObject {
    open var routingKey:String = String("")
    open var httpMethod:String = String("")
    open var passthruAPI:String = String("")
    open var passthruParams:AnyObject?
    open var callBackPoint:String = String("")
    open var authtoken:String = String("")
    open var params:AnyObject?
    open var ttl:Float = 0.1
        {
        didSet{
            if(ttl > 0.1){
                Timer.scheduledTimer(timeInterval: Double(ttl), target: self, selector: #selector(Message.dispatchSelf), userInfo: nil, repeats: false)
            }
        }
    }
    open var shouldselfdestruct:Bool = false
    public init(routKey:String) {
        super.init()
        self.routingKey = routKey
    }
    
    
    open func routeFromRoutingKey() -> String {
        var keyitems:[String]? = self.routingKey.components(separatedBy: ".")
        if keyitems != nil {
            return keyitems![0] as! String
        }
        return ""
    }
    
    open func messageFromRoutingKey() -> String {
        let keyitems:[String]? = self.routingKey.components(separatedBy: ".")
        if keyitems != nil {
            return (keyitems?.last)! as! String
        }
        return ""
    }
    
    open func dispatchSelf()
    {
        ttl = 0.1
        MessageDispatcher.sharedDispacherInstance.addMessageToBus(self)
    }
    
    open func selfDestruct()
    {
        routingKey = "msg.selfdestruct"
        MessageDispatcher.sharedDispacherInstance.addMessageToBus(self)
    }
}
