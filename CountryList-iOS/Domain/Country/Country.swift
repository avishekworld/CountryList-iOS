//
//  Country.swift
//  CountryList-iOS
//
//  Created by Md Avishek Ahmed on 11/7/22.
//

import Foundation

// Get Country List Use Case
class GetCountryListUseCase : AsyncUseCase {
    
    typealias I = CountryRequest
    typealias O = Result<Array<Country>, Error>
    
    let repository: CountryRepository
    
    init(repository: CountryRepository) {
        self.repository = repository
    }
    
    func run(input: I) async -> Result<Array<Country>, Error> {
        return await repository.getCountryList(countryRequest: input)
    }
}

// Country Repository
protocol CountryRepository {
    // Get Country List
    func getCountryList(countryRequest: CountryRequest) async -> Result<Array<Country>, Error>
}

// Country Request
struct CountryRequest {
    let forceRefresh: Bool = false
}

// Country
struct Country {
    let name: String
    let code: String
    let capital: String
    let region: String
}
