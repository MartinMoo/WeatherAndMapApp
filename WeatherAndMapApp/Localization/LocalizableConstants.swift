//
//  LocalizableConstants.swift
//  WeatherAndMapApp
//
//  Created by Moo Maa on 14/05/2021.
//

import Foundation

struct Localize {
    struct TabBar {
        static let Map = "TabBar.Map".localized();
        static let Search = "TabBar.Search".localized();
        static let Favorites = "TabBar.Favorites".localized();
    }
    struct Map {
        static let Standard = "Map.Standard".localized();
        static let Satellite = "Map.Satellite".localized();
    }
    struct Detail {
        static let FeelsLike = "Detail.FeelsLike".localized();
    }
    struct Alert {
        static let Ok = "Alert.Ok".localized();
        static let UpdateSettings = "Alert.UpdateSettings".localized();
        struct Location {
            static let Title = "Alert.Location.Title".localized();
            static let Message = "Alert.Location.Message".localized();
        }
    }
}
