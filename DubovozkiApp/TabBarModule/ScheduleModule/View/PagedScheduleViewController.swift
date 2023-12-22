//
//  ViewController.swift
//  DubovozkiApp
//
//  Created by Илья Володин on 30.11.2023.
//

import UIKit

class PagedScheduleViewController: UIViewController {
    private enum Constants {
        static let buttonsOffset: CGFloat = 5
    }
    
    var presenter: ScheduleViewPresenterProtocol!
    
    private let loadingView: UIActivityIndicatorView = UIActivityIndicatorView()
    
    let mskTableView: ScheduleTableView = ScheduleTableView()
    let dubkiTableView: ScheduleTableView = ScheduleTableView()
    
    private lazy var stationSelector: SelectButton = {
        let options: [(String, String)] = Filters.station.allCases.map { ($0.title.localized(), $0.rawValue) }
        return SelectButton(opitions: options) {[weak self] str in
            if let date: String = self?.dateSelector.currentSelection {
                self?.presenter.filterData(station: str, date: date)
            }
        }
    }()
    private lazy var dateSelector: SelectButton = {
        let options: [(String, String)] = Filters.date.allCases.map { ($0.title.localized(), String($0.rawValue)) }
        return SelectButton(opitions: options) {[weak self] str in
            if let station: String = self?.stationSelector.currentSelection {
                self?.presenter.filterData(station: station, date: str)
            }
        }
    }()
    
    private lazy var viewPager: ViewPager = {
        let viewPager = ViewPager()
        
        viewPager.tabbedView.tabs = [
            TabView(title: Filters.direction.msk.title.localized()),
            TabView(title: Filters.direction.dbk.title.localized()),
        ]
        
        mskTableView.dataSource = presenter as? UITableViewDataSource
        dubkiTableView.dataSource = presenter as? UITableViewDataSource
        
        viewPager.pagedView.pages = [
            mskTableView,
            dubkiTableView
        ]
        
        viewPager.translatesAutoresizingMaskIntoConstraints = false
        return viewPager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        presenter.getData()
    }
   
    private func configureUI() {
        view.backgroundColor = .app
        
        configureLoading()
        configureTabs()
    }
    
    private func configureTabs() {
        view.addSubview(viewPager)
        view.addSubview(stationSelector)
        view.addSubview(dateSelector)
        
        stationSelector.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.buttonsOffset).isActive = true
        stationSelector.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.buttonsOffset).isActive = true
        stationSelector.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -Constants.buttonsOffset).isActive = true
        
        dateSelector.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.buttonsOffset).isActive = true
        dateSelector.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: Constants.buttonsOffset).isActive = true
        dateSelector.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.buttonsOffset).isActive = true
        
        viewPager.topAnchor.constraint(equalTo: stationSelector.bottomAnchor, constant: Constants.buttonsOffset).isActive = true
        viewPager.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewPager.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        viewPager.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func configureLoading() {
        view.addSubview(loadingView)
        
        viewPager.isHidden = true
        loadingView.center = view.center
        loadingView.hidesWhenStopped = true
        loadingView.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

extension PagedScheduleViewController: ScheduleViewProtocol {
    func setSchedule() {
        viewPager.isHidden = false
        loadingView.stopAnimating()
    }
}


