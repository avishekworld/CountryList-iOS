//
//  ViewController.swift
//  CountryList-iOS
//
//  Created by Md Avishek Ahmed on 11/7/22.
//

import UIKit

// Country List View Controller
class CountryListViewController: UIViewController {

    private let viewModel: CountryListViewModel = PresentationModule.instance.countryListViewModel // TODO DI Inject
    
    @IBOutlet var tableView: UITableView?
    
    @IBOutlet var processingView: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        
        tableView?.register(
            UINib(nibName: "CountryTableViewCell", bundle: nil),
            forCellReuseIdentifier: "cell")

        // observer view state update
        viewModel.viewState.observe { [weak self] viewState in
            self?.renderCountryList(countryList: viewState?.countryList ?? Array<Country>())
            self?.renderProcessingView(processingViewState: viewState?.processingViewState ?? ViewState.Hidden)
            self?.renderErrorView(errorViewState: viewState?.errorViewState ?? ViewState.Hidden)

        }
        
        viewModel.handleEvent(event: CountryListViewEvent.viewLoaded)
    }

    
    func renderCountryList(countryList: Array<Country>) {
        switch countryList.count {
        case 0: tableView?.isHidden = true
        default:
            tableView?.isHidden = false
            tableView?.reloadData()
        }
        
    }
    
    func renderProcessingView(processingViewState: ViewState) {
        switch processingViewState {
        case .Show:
            processingView?.isHidden = false
        case .Disable:
            processingView?.isHidden = false
        case .Hidden:
            processingView?.isHidden = true
        }
    }
    
    func renderErrorView(errorViewState: ViewState) {
        
    }
}

extension CountryListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.viewState.value?.countryList.count ?? 0
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CountryTableViewCell
        let country = viewModel.viewState.value?.countryList[indexPath.row] ?? nil
        if country != nil {
            cell.countryLabel?.text = "Country: \(country?.name ?? "Name")"
            cell.capitalLabel?.text = "Capital: \(country?.capital ?? "Capital")"
        }
        return cell
    }
}

extension CountryListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("countrySelected \(indexPath.row)")
    }
}

