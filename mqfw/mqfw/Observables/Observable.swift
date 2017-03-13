//
//  Observable.swift
//  mobilesdkfw
//
//  Created by Gal Blank on 3/4/16.
//  Copyright © 2016 Gal Blank. All rights reserved.
//

import UIKit



/// An object that has some tear-down logic
public protocol Disposable {
    func dispose()
}


/// An event provides a mechanism for raising notifications, together with some
/// associated data. Multiple function handlers can be added, with each being invoked,
/// with the event data, when the event is raised.
open class Event<T> {
    
    public typealias EventHandler = (T) -> ()
    
    fileprivate var eventHandlers = [Invocable]()
    
    public init() {
    }
    
    /// Raises the event, invoking all handlers
    open func raise(_ data: T) {
        for handler in self.eventHandlers {
            handler.invoke(data: data)
        }
    }
    
    /// Adds the given handler
    open func addHandler<U: AnyObject>(_ target: U, handler: @escaping (U) -> EventHandler) -> Disposable {
        let wrapper = EventHandlerWrapper(target: target, handler: handler, event: self)
        eventHandlers.append(wrapper)
        return wrapper
    }
}

// MARK:- Private

// A protocol for a type that can be invoked
public protocol Invocable: class {
    func invoke(_ data: Any)
}

// takes a reference to a handler, as a class method, allowing
// a weak reference to the owning type.
// see: http://oleb.net/blog/2014/07/swift-instance-methods-curried-functions/
private class EventHandlerWrapper<T: AnyObject, U> : Invocable, Disposable {
    weak var target: T?
    let handler: (T) -> (U) -> ()
    let event: Event<U>
    
    init(target: T?, handler: @escaping (T) -> (U) -> (), event: Event<U>){
        self.target = target
        self.handler = handler
        self.event = event;
    }
    
    func invoke(_ data: Any) -> () {
        if let t = target {
            handler(t)(data as! U)
        }
    }
    
    @objc func dispose() {
        event.eventHandlers = event.eventHandlers.filter { $0 !== self }
    }
}


open class Observable<T> {
    open let didChange = Event<(T)>()
    open var value: T
    
    public init(_ initialValue: T) {
        value = initialValue
    }
    
    
    open func set(_ newValue: T) {
        value = newValue
        didChange.raise(value)
    }
    
    open func get() -> T {
        return value
    }
}



