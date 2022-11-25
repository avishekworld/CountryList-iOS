//
//  CountryApi.swift
//  CountryList-iOS
//
//  Created by Md Avishek Ahmed on 11/8/22.
//

import Foundation

// Country Api
protocol CountryApi {
    func getCountryList(request: CountryRequest) async -> Result<Array<Country>, Error>
}

class CountryApiImpl : CountryApi {
    
    private let url = "https://tinyurl.com/country-list-api"
    
    private let networkApi: NetworkApi
    
    private let mapper: CountryMapper
    
    init(networkApi: NetworkApi, mapper: CountryMapper) {
        self.networkApi = networkApi
        self.mapper = mapper
    }
    
    func getCountryList(request: CountryRequest) async -> Result<Array<Country>, Error> {
        do {
            let  result = await networkApi.get(request: GetRequest(url: url))
            switch result {
            case .success(let response):
                let countryDTO = try JSONDecoder().decode([CountryDTO].self, from: response.data)
                let countryList = countryDTO.map {
                    mapper.map(input: $0)
                }
                return Result.success(countryList)
            case .failure(let error): return Result.failure(error)
            }
        } catch {
            return Result.failure(error)
        }
    }
    
}

internal class CountryMapper : Mapper {
    typealias I = CountryDTO
    typealias O = Country
    
    func map(input: I) -> O {
        let country = Country(
            name: input.name,
            code: input.code,
            capital: input.capital,
            region: input.region
        )
        return country
    }
}

// Country Data Transfer Object
struct CountryDTO : Codable {
    let name: String
    let code: String
    let capital: String
    let region: String
}
