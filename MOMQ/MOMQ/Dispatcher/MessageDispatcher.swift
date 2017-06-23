//
//  MessageDispatcher.swift
//
//  Created by Gal Blank on 1/15/16.
//

import UIKit

open class MessageDispatcher:NSObject {
    
    open var dispsatchTimer:Timer? = nil
    open var messageBus:[Message] = [Message]()
    open var dispatchedMessages:[Message] = [Message]()
    
    override init() {
        super.init()
        startDispatching()
    }
    
    
    open static let sharedDispacherInstance = MessageDispatcher()

    
    struct Static {
        static var token: Int = 0
    }
    
    open func consumeMessage(notif:Notification){
        let msg:Message = notif.userInfo!["message"] as! Message
        switch(msg.routingKey){
        case "msg.selfdestruct":
            let Index = messageBus.index(of: msg)
            if(Index! >= 0){
                messageBus.remove(at: Index!)
            }
            break
        default:
            break
        }
    }
    
    open func addMessageToBus(_ newmessage: Message) {
        if(newmessage.shouldselfdestruct == false && newmessage.routingKey.caseInsensitiveCompare("msg.selfdestruct") == ComparisonResult.orderedSame)
        {
            let index:Int = messageBus.index(of: newmessage)!
            if(index >= 0 ){
                messageBus.remove(at: index)
            }
        }
        
        messageBus.append(newmessage)
    }
    
    open func clearDispastchedMessages() {
        for msg:Message in dispatchedMessages {
            let Index = messageBus.index(of: msg)
            if(Index! >= 0){
                messageBus.remove(at: Index!)
            }
        }
        dispatchedMessages.removeAll()
    }
    
    
    open func startDispatching() {
        NotificationCenter.default.addObserver(self, selector: #selector(MessageDispatcher.consumeMessage(notif:)), name: NSNotification.Name(rawValue: "msg.selfdestruct"), object: nil)
        dispsatchTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(MessageDispatcher.leave), userInfo: nil, repeats: true)
    }
    
    public func stopDispathing() {
        if dispsatchTimer != nil {
            dispsatchTimer!.invalidate()
            dispsatchTimer = nil
        }
    }
    
    public func leave() {
        let goingAwayBus:[Message] = NSArray(array: messageBus) as! [Message]
        for msg: Message in goingAwayBus {
            if(msg.ttl > 0.1){
                continue
            }
            if(msg.shouldselfdestruct == false){
                self.dispatchMessage(message: msg)
                msg.shouldselfdestruct = true
                let index:Int = messageBus.index(of: msg)!
                if(index != NSNotFound){
                    messageBus.remove(at: index)
                }
            }
            
        }
    }
    
    public func dispatchMessage(message: Message) {
        var messageDic: [String : Message] = [String : Message]()
        messageDic["message"] = message
        if(message.routingKey == "api.*"){
            //make sure comms are initialized
            //CommManager.sharedCommSingletonDelegate
        }

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: message.routingKey), object: nil, userInfo: messageDic)
    }
    
    
    public func canSendMessage(message: Message) -> Bool {
        return true
    }
}
