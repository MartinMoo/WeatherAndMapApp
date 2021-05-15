//
//  WebService.swift
//  WeatherAndMapApp
//
//  Created by Moo Maa on 15/05/2021.
//

import Foundation
import Combine
import CoreLocation

enum ServiceError: Error {
    case url(URLError?)
    case decode
    case unknown(Error)
}

class WebService {
    private let seedURL = "https://api.openweathermap.org/data/2.5/onecall?appid=ff554f01a90bb15acaa4b59c8e15462e"
    func fetchWeather(for location: CLLocation) -> AnyPublisher<WeatherModel,ServiceError> {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let language = Locale.current.languageCode!
        let stringURL = "\(seedURL)&lat=\(latitude)&lon=\(longitude)&lang=\(language)&exclude=minutely,hourly,alerts"
        guard let url = URL(string: stringURL) else { fatalError("Invalid URL")}

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: WeatherModel.self, decoder: JSONDecoder())
            .mapError { error -> ServiceError in
                switch error {
                    case is DecodingError: return ServiceError.decode
                    case is URLError: return ServiceError.url(error as? URLError)
                    default: return ServiceError.unknown(error)
                }
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
