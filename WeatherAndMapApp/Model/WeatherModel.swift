//
//  WeatherData.swift
//  WeatherAndMapApp
//
//  Created by Moo Maa on 14/05/2021.
//

import Foundation


struct WeatherModel: Decodable {
    let current: Current
    let daily: [Daily]
}

struct Current: Decodable {
    // Flat model
    let actualTemp: Double
    let sensoryTemp: Double
    let description: String
    let id: Int

    private enum CurrentKeys: String, CodingKey {
        case actualTemp = "temp"
        case sensoryTemp = "feels_like"
        case weather
    }
    // Coding keys for nested dictionarry
    private enum WeatherKeys: String, CodingKey {
        case description
        case id
    }
    
    init(from decoder: Decoder) throws {
        let currentContainer = try decoder.container(keyedBy: CurrentKeys.self)
        self.actualTemp = try currentContainer.decode(Double.self, forKey: .actualTemp)
        self.sensoryTemp = try currentContainer.decode(Double.self, forKey: .sensoryTemp)
        
        // Data from nested array and dictionarry
        var weatherArray = try currentContainer.nestedUnkeyedContainer(forKey: .weather)
        let weatherContainer = try weatherArray.nestedContainer(keyedBy: WeatherKeys.self)
        self.description = try weatherContainer.decode(String.self, forKey: .description)
        self.id = try weatherContainer.decode(Int.self, forKey: .id)
    }
}

struct Daily: Decodable {
    // Flat model
    let dayDate: NSDate
    let humidity: Int
    let actualTemp: Double
    let description: String
    let id: Int

    private enum DailyKeys: String, CodingKey {
        case date = "dt"
        case humidity
        case temp
        case weather
    }
    // Coding keys for nested dictionarry
    private enum WeatherKeys: String, CodingKey {
        case description
        case id
    }
    // Coding keys for nested dictionarry
    private enum TempKeys: String, CodingKey {
        case day
    }
       
    init(from decoder: Decoder) throws {
        let dailyContainer = try decoder.container(keyedBy: DailyKeys.self)
        self.humidity = try dailyContainer.decode(Int.self, forKey: .humidity)
        // Convert Double to Date
        let dateDouble = try dailyContainer.decode(Double.self, forKey: .date)
        self.dayDate = NSDate(timeIntervalSince1970: dateDouble)
        
        // Data from nested array and dictionarry
        var weatherArray = try dailyContainer.nestedUnkeyedContainer(forKey: .weather)
        let weatherContainer = try weatherArray.nestedContainer(keyedBy: WeatherKeys.self)
        self.description = try weatherContainer.decode(String.self, forKey: .description)
        self.id = try weatherContainer.decode(Int.self, forKey: .id)
        
        // Data from nested dictionarry
        let tempContainer = try dailyContainer.nestedContainer(keyedBy: TempKeys.self, forKey: .temp)
        self.actualTemp = try tempContainer.decode(Double.self, forKey: .day)

    }
}

