//
//  CountryListViewModel.swift
//  CountryList-iOS
//
//  Created by Md Avishek Ahmed on 11/7/22.
//

import Foundation

//Country List View Model
class CountryListViewModel {
    
    private let eventBus: EventBus<CountryListViewEvent> // TODO DI inject
    
    var viewState: Observable<CountryListViewState> // TODO DI inject
    
    private let getCountryListUseCase: GetCountryListUseCase
    
    internal init(getCountryListUseCase: GetCountryListUseCase) {
        self.getCountryListUseCase = getCountryListUseCase
        viewState = Observable(value: CountryListViewState())
        eventBus = EventBus<CountryListViewEvent>()
        observerViewEvent()
    }
    
    func observerViewEvent() {
        eventBus.subscribeOnMain(block: { [weak self] event in
            print("observerViewEvent \(event)")
            switch event {
            case .viewLoaded: self?.getCountryList()
            case .countrySelected(let country): ""
            }
        })
    }
    
    func handleEvent(event: CountryListViewEvent) {
        eventBus.publish(event: event)
    }
    
    func updateViewState(viewStateUpdate: CountryListViewState) {
        viewState.value = viewStateUpdate
    }
    
    func getCountryList() {
        async {
            let countryListResult = await getCountryListUseCase.run(input: CountryRequest())
            print("getCountryList \(countryListResult)")
            switch countryListResult {
                case .success(let countryList):
                DispatchQueue.main.async { [weak self] in
                    self?.updateViewState(viewStateUpdate: self?.viewState.value?.copy(
                        countryList: countryList,
                        processingViewState: ViewState.Hidden,
                        errorViewState: ViewState.Hidden) ?? CountryListViewState(countryList: Array<Country>(), processingViewState: .Hidden, errorViewState: .Hidden))
                }

                
                case .failure(let error): ""
            }
        }
    }
    
    private let TAG = "CountryListViewModel"
}

struct CountryListViewState {
    let countryList: Array<Country>
    let processingViewState: ViewState
    let errorViewState: ViewState
    
    init(
        countryList: Array<Country> = Array<Country>(),
        processingViewState: ViewState = ViewState.Hidden,
        errorViewState: ViewState = ViewState.Hidden) {
            self.countryList = countryList
            self.processingViewState = processingViewState
            self.errorViewState = errorViewState
    }
    
    // TODO consider nil value assignment
    func copy(
        countryList: Array<Country>? = nil,
        processingViewState: ViewState? = nil,
        errorViewState: ViewState? = nil
    ) -> CountryListViewState {
        return CountryListViewState(
                    countryList: countryList ?? self.countryList,
                    processingViewState: processingViewState ?? self.processingViewState,
                    errorViewState: errorViewState ?? self.errorViewState)
    }
}

enum CountryListViewEvent {
    case viewLoaded
    case countrySelected(Country)
}

