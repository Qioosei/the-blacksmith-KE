//
//  PreferenceStore.swift
//  keCalculator
//
//  Created by Qioosei on 21/04/2022.
//

import Foundation


class PreferenceStore {
    
    enum Keys: String {
        case BUILDS
        case RUNE_LEVEL
        case LAST_BUILD
        case PLAYER_LEVEL
    }
    
    
    static var Builds: [Build] {
        get {
            var builds: [Build] = [Build]()
            let storedData = UserDefaults.standard.data(forKey: Keys.BUILDS.rawValue)
            if let data = storedData {
                let decoder = JSONDecoder()
                do {
                    builds = try decoder.decode([Build].self, from: data)
                } catch {
                    print(error)
                }
                return builds
            } else {
                return builds
            }
        }
        set {
            if(newValue.isEmpty) {
                return
            }
            let encoder = JSONEncoder()
            do {
            let data = try encoder.encode(newValue)
            UserDefaults.standard.set(data, forKey: Keys.BUILDS.rawValue)
            } catch {
                print("error: \(error)")
            }
        }
    }
    static var lastBuild: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.LAST_BUILD.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.LAST_BUILD.rawValue)
        }
    }
    
    static var playerLevel: Int {
        get {
            return UserDefaults.standard.integer(forKey: Keys.PLAYER_LEVEL.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.PLAYER_LEVEL.rawValue)
        }
    }
    
    static func setRuneLevel(rune: Rune, level: Int) {
        let key: String = "\(Keys.RUNE_LEVEL.rawValue)_\(rune.id)"
        UserDefaults.standard.set(level, forKey: key)
    }
    static func getRuneLevel(rune: Rune) -> Int {
        let key: String = "\(Keys.RUNE_LEVEL.rawValue)_\(rune.id)"
        let storedLevel = UserDefaults.standard.integer(forKey: key)
        return storedLevel
    }
    
//    static func save(_ value: Codable, forKey key: String) {
//        let encoder = JSONEncoder()
//        do{
//            var data = try encoder.encode(value)
//            UserDefaults.standard.set(data, forKey: key)
//        }
//        catch {
//
//        }
//    }
//
//    static func read(key: String) -> Data? {
//        return UserDefaults.standard.data(forKey: key) ?? nil
//    }
    
    //    static var <#var#>: String {
//        get {
//            return UserDefaults.standard.string(forKey: Keys.<#key#>.rawValue) ?? ""
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: Keys.<#key#>.rawValue)
//        }
//    }
//
//    static var <#var#>: Bool {
//        get {
//            let terms: Bool = UserDefaults.standard.bool(forKey: Keys.<#key#>.rawValue)
//            return terms
//        }
//        set {
//            UserDefaults.standard.set(newValue,forKey: Keys.<#key#>.rawValue)
//        }
//    }
    

    
}
