//
//  PresentationModule.swift
//  CountryList-iOS
//
//  Created by Md Avishek Ahmed on 11/15/22.
//

// Presentation Module holds data dependencies
// TODO use dependency injection library
import Foundation

class PresentationModule {
    
    static let instance: PresentationModule = PresentationModule()
    
    let getCountryListUseCase: GetCountryListUseCase
    
    let countryListViewModel: CountryListViewModel
    
    init() {
        getCountryListUseCase = GetCountryListUseCase(repository: DataModule.instance.countryRepository)
        countryListViewModel = CountryListViewModel(getCountryListUseCase: getCountryListUseCase)
    }
}
