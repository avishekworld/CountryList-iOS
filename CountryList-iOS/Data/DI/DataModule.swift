//
//  DataModule.swift
//  CountryList-iOS
//
//  Created by Md Avishek Ahmed on 11/15/22.
//

import Foundation


// Data Module holds data dependencies
// TODO use dependency injection library
class DataModule {
    
    static let instance: DataModule = DataModule()
    
    private let networkApi: NetworkApiUrlSession
    
    private let countryMapper: CountryMapper
    
    private let countryApi: CountryApi
    
    let countryRepository: CountryRepository
    
    init() {
        networkApi = NetworkApiUrlSession()
    
        countryMapper = CountryMapper()
    
        countryApi = CountryApiImpl(networkApi: networkApi, mapper: countryMapper)
        
        countryRepository = CountryRepositoryImpl(countryApi: countryApi)
    }
}
