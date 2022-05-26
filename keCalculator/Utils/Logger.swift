//
//  Logger.swift
//  KECalculator
//
//  Created by Guillaume Brahier on 26/05/2022.
//

import Foundation

class Logger {
    
    struct Categories: OptionSet {

        let rawValue: Int
        
        static let Debug = Categories(rawValue: 1 << 0)
        static let Data = Categories(rawValue: 1 << 1)
        static let GameModel = Categories(rawValue: 1 << 2)
        static let allCategories = [Categories.Debug,Categories.Data,Categories.GameModel]
        
    }
    
    static var standard: Logger = Logger()
    private var categories: [Categories]
    private init() {
        self.categories = PreferenceStore.LogCategories
    }
    
    static func log(_ message: String, _ categories: Categories = Categories()) {
        if(standard.categories.contains(categories)) {
            print(message)
        }
    }
    
}
