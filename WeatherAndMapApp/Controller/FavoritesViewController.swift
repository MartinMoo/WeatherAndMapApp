//
//  FavoritesViewController.swift
//  WeatherAndMapApp
//
//  Created by Moo Maa on 14/05/2021.
//

import UIKit
import Combine
import CoreLocation

class FavoritesViewController: UIViewController {
    private var subscritpion: AnyCancellable?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let location = CLLocation(latitude: 48, longitude: 17)
        subscritpion = WebService().fetchWeather(for: location)
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
            }, receiveValue: {print("Data obtained: ", $0)})
    }
}
