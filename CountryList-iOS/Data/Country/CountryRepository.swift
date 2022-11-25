//
//  CountryRepository.swift
//  CountryList-iOS
//
//  Created by Md Avishek Ahmed on 11/8/22.
//

import Foundation

// Country Repository Impl
class CountryRepositoryImpl : CountryRepository {
    
    private let countryApi: CountryApi
    
    init(countryApi: CountryApi) {
        self.countryApi = countryApi
    }
    
    // TODO add Cache support
    func getCountryList(countryRequest: CountryRequest) async -> Result<Array<Country>, Error> {
        return await countryApi.getCountryList(request: countryRequest)
    }
}
