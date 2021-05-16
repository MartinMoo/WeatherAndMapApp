//
//  DetailViewController.swift
//  WeatherAndMapApp
//
//  Created by Moo Maa on 15/05/2021.
//

import Foundation
import UIKit
import CoreLocation
import Combine

class DetailViewController: UIViewController {
    //MARK: - Private properties
    private let tableView = UITableView()
    private var spinnerView = UIActivityIndicatorView()
    private let header = DetailViewTableHead(frame: CGRect.zero)
    private let scrollView = UIScrollView()
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return button
    }()
    
    private var webService = WebService.shared
    private var subscription: AnyCancellable?
    
    private var dailyWeather: [Daily]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = .clear
        setupUI()
        setupTable()
        setupObservers()  
    }
    
    //MARK: - Private methods
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.register(DetailViewTableCell.self, forCellReuseIdentifier: "DetailCell")
    }
    
    private func setupObservers() {
        let location = CLLocation(latitude: 48, longitude: 17)
        subscription = webService.fetchWeather(for: location)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(.decode):
                        print("Decoding error")
                    case .failure(.unknown(let error)):
                        print("Unknown error", error.localizedDescription)
                    case .failure(.url(let error)):
                        print("URL error:", error?.errorCode ?? "")
                }
            }, receiveValue: { [weak self] data in
                self?.header.currentWeather = data.current
                var weekForecast = data.daily
                weekForecast.removeFirst()
                self?.dailyWeather = weekForecast
            })
    }
    
    //MARK: - UI Methods
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        tableView.backgroundColor = .systemBackground
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        header.translatesAutoresizingMaskIntoConstraints = false

//        header.alpha = 0
//        tableView.alpha = 0
        
        view.addSubview(scrollView)
        scrollView.addSubview(header)
        scrollView.addSubview(tableView)
        scrollView.addSubview(favoriteButton)
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            
        header.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        header.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        header.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        header.bottomAnchor.constraint(equalTo: tableView.topAnchor).isActive = true

        tableView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        tableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: favoriteButton.topAnchor,constant: -15).isActive = true
        
        favoriteButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 15).isActive = true
        favoriteButton.trailingAnchor.constraint(lessThanOrEqualTo: scrollView.trailingAnchor, constant: 0).isActive = true
        favoriteButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -15).isActive = true
        
        scrollView.alwaysBounceVertical = true
    }
}

//MARK: - TableView Delegate methods
extension DetailViewController: UITableViewDelegate {
    
}

//MARK: - TableView Datasource methods
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyWeather?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailViewTableCell
        cell.day = dailyWeather?[indexPath.row]
        return cell
    }
}
