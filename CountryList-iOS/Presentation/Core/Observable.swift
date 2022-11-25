//
//  Observable.swift
//  CountryList-iOS
//
//  Created by Md Avishek Ahmed on 11/15/22.
//

import Foundation

// Observable
class Observable<T> {
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    
    init(value: T?) {
        self.value = value
    }
    
    var listener: ((T?) -> Void)?
    
    // Observer with listener
    func observe(listener: @escaping (T?) -> Void) {
        self.listener = listener
    }
}
