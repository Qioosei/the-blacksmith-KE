//
//  PreferenceStore.swift
//  keCalculator
//
//  Created by Qioosei on 21/04/2022.
//

import Foundation


class PreferenceStore {
    
    enum Keys: String, CaseIterable {
        case BUILDS
        case RUNE_LEVEL
        case LAST_BUILD
        case PLAYER_LEVEL
        case RUNES_VERSION
        case PASSIVES_VERSION
        case STACKS_COUNTS
        case RUNES
    }
    
    enum BundleKeys: String, CaseIterable {
        case GameVersion
        case RunesVersion
        case ResetStore
        case LogCategories
    }
    
    static var GameVersion: String {
        get{
            let gameVersion: String? = Bundle.main.object(forInfoDictionaryKey: BundleKeys.GameVersion.rawValue) as! String?
            return gameVersion ?? "0.0"
        }
    }
    static var RunesVersion: Double {
        get{
            let runesVersionString: String? = Bundle.main.object(forInfoDictionaryKey: BundleKeys.RunesVersion.rawValue) as! String?
            return Double(runesVersionString ?? "0") ?? 0
        }
    }
    static var ResetStore: Bool {
        get{
            let resetStore: Bool? = Bundle.main.object(forInfoDictionaryKey: BundleKeys.ResetStore.rawValue) as! Bool?
            return resetStore ?? true
        }
    }
    static var LogCategories: [Logger.Categories] {
        get{
            let categories: [Logger.Categories]? = Bundle.main.object(forInfoDictionaryKey: BundleKeys.LogCategories.rawValue) as! [Logger.Categories]?
            if let cat = categories {
                return cat
            }
            else {
                return [Logger.Categories]()
            }
        }
    }
    
    
    static func cleanStore() {
        for key in Keys.allCases {
            UserDefaults.standard.removeObject(forKey: key.rawValue)
        }
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
    
    
    static var Runes: [Rune] {
        get {
            var runes: [Rune] = [Rune]()
            let storedData = UserDefaults.standard.data(forKey: Keys.RUNES.rawValue)
            if let data = storedData {
                let decoder = JSONDecoder()
                do {
                    runes = try decoder.decode([Rune].self, from: data)
                } catch {
                    print(error)
                }
                return runes
            } else {
                return runes
            }
        }
        set {
            if(newValue.isEmpty) {
                return
            }
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(newValue)
                UserDefaults.standard.set(data, forKey: Keys.RUNES.rawValue)
            } catch {
                print("error: \(error)")
            }
        }
    }
    
    
//    
//    static var ActiveEffects: [StatStackBuff] {
//        get {
//            var effects: [StatStackBuff] = [StatStackBuff]()
//            
//            let storedData = UserDefaults.standard.data(forKey: Keys.ACTIVES.rawValue)
//            if let data = storedData {
//                let decoder = JSONDecoder()
//                do {
//                    effects = try decoder.decode([StatStackBuff].self,from:data)
//                } catch {
//                    print(error)
//                }
//                return effects
//            } else {
//                return effects
//            }
//        }
//        set {
//            if(newValue.isEmpty) {
//                return
//            }
//            let encoder = JSONEncoder()
//            do {
//                let data = try encoder.encode(newValue)
//                UserDefaults.standard.set(data, forKey: Keys.ACTIVES.rawValue)
//            } catch {
//                print("error: \(error)")
//            }
//            
//        }
//    }
    
    
    static var lastBuild: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.LAST_BUILD.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.LAST_BUILD.rawValue)
        }
    }
    
    
    static var lastRunesVersion: Int {
        get {
            return UserDefaults.standard.integer(forKey: Keys.RUNES_VERSION.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.RUNES_VERSION.rawValue)
        }
    }
    
    static var passivesVersion: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.PASSIVES_VERSION.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.PASSIVES_VERSION.rawValue)
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
    
    static func setEffectCount(effect: StatStackBuff, count: Int) {
        let key: String = "\(Keys.STACKS_COUNTS.rawValue)_\(effect.id)"
        UserDefaults.standard.set(count, forKey: key)
    }
    static func getEffectCount(effect: StatStackBuff,default defaultValue: Int = -1) -> Int {
        let key: String = "\(Keys.STACKS_COUNTS.rawValue)_\(effect.id)"
        if(!UserDefaults.standard.valueExists(forKey: key)) {
            return defaultValue
        }
        let storedCount = UserDefaults.standard.integer(forKey: key)
        return storedCount
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
