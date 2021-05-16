//
//  UIExtension.swift
//  WeatherAndMapApp
//
//  Created by Moo Maa on 14/05/2021.
//

import Foundation
import UIKit

extension UIColor {
    struct Custom {
        static let black = UIColor(named: "black")
        static let blue = UIColor(named: "blue")
        static let gray = UIColor(named: "gray")
        static let purple = UIColor(named: "purple")
        static let red = UIColor(named: "red")
        static let white = UIColor(named: "white")
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
