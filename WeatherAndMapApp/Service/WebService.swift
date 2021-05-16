//
//  WebService.swift
//  WeatherAndMapApp
//
//  Created by Moo Maa on 15/05/2021.
//

import Foundation
import Combine
import CoreLocation

enum WebServiceError: Error {
    case url(URLError?)
    case decode
    case unknown(Error)
}

class WebService {
    //MARK: - Public properties
    static let shared = WebService()
    
    //MARK: - Private properties
    private let seedURL = "https://api.openweathermap.org/data/2.5/onecall?appid=ff554f01a90bb15acaa4b59c8e15462e"
    
    //MARK: - Public methods
    func fetchWeather(for location: CLLocation) -> AnyPublisher<WeatherModel,WebServiceError> {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let language = Locale.current.languageCode!
        let stringURL = "\(seedURL)&units=metric&lat=\(latitude)&lon=\(longitude)&lang=\(language)&exclude=minutely,hourly,alerts"
        guard let url = URL(string: stringURL) else { fatalError("Invalid URL")}

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: WeatherModel.self, decoder: JSONDecoder())
            .mapError { error -> WebServiceError in
                switch error {
                    case is DecodingError: return WebServiceError.decode
                    case is URLError: return WebServiceError.url(error as? URLError)
                    default: return WebServiceError.unknown(error)
                }
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
