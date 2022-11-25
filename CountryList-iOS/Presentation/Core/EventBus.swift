//
//  EventBus.swift
//  CountryList-iOS
//
//  Created by Md Avishek Ahmed on 11/25/22.
//

import Foundation

// Event Bus
class EventBus<T> {
    
    private var subscriptions = [Subscription<T>]()
    
    // publish event
    func publish(event: T) {
        subscriptions.forEach { subscription in
            subscription.dispatchQueue.async {
                subscription.block(event)
            }
        }
    }
    
    // subscribe in non main thread with block
    func subscribe(block: @escaping ((T) -> Void)) {
        let subscription = Subscription<T>(
            dispatchQueue: DispatchQueue.global(),
            block: block)
        subscriptions.append(subscription)
    }
    
    // subscribe in main thread with block
    func subscribeOnMain(block: @escaping ((T) -> Void)) {
        let subscription = Subscription<T>(
            dispatchQueue: DispatchQueue.main,
            block: block)
        subscriptions.append(subscription)
    }
    
}

// Subscription
struct Subscription<T> {
    let dispatchQueue: DispatchQueue
    let block: ((T) -> Void)
}
