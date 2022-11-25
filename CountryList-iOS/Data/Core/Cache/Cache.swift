//
//  Cache.swift
//  CountryList-iOS
//
//  Created by Md Avishek Ahmed on 11/8/22.
//

import Foundation

// Cache
protocol Cache {
    associatedtype T
    
    /**
     Save data into cache.
     
     - parameter data: Cache to save.
     - returns: Void
     
     */
    func save(data: T) async -> Void
    
    /**
     Load cache.
     
     - returns: Cache of Type T?
     
     */
    func load() async -> T?
}
