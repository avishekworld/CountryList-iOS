//
//  Mapper.swift
//  CountryList-iOS
//
//  Created by Md Avishek Ahmed on 11/8/22.
//

import Foundation

// Mapper
protocol Mapper {
    associatedtype I
    associatedtype O
    
    /**
     Map input type to output type
     
     - parameter input: input to map.
     - returns: mapped output.
     
     */
    func map(input: I) -> O
}
