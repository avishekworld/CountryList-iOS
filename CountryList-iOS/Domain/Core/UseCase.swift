//
//  UseCase.swift
//  CountryList-iOS
//
//  Created by Md Avishek Ahmed on 11/7/22.
//

import Foundation

// Use Case
protocol UseCase {
    associatedtype I
    associatedtype O
}

// Async Use Case
protocol AsyncUseCase : UseCase {
    func run(input: I) async -> O
}

// Regular Use Case
protocol RegularUseCase : UseCase {
    func run(input: I) -> O
}
