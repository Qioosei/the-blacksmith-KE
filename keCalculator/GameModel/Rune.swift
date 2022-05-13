//
//  Rune.swift
//  keCalculator
//
//  Created by Qioosei on 13/04/2022.
//

import Foundation
import SwiftUI

struct Rune_Sample {
    static let Rune1: Rune = Rune(name: "CALLED TARGET", rawRarity: "Legendary", rawType: "Offense", rawBuff: "PW")
    static let EmptyOffense: Rune = Rune(name: "empty", rawRarity: "Normal", rawType: "Offense", rawBuff: "ER")
    static let EmptyDefense: Rune = Rune(name: "empty", rawRarity: "Normal", rawType: "Defense", rawBuff: "ER")

}

struct Rune : Codable, Identifiable{
    var id: String {
        return name
    }
    
    enum RType: String {
        case Offense = "Offense"
        case Defense = "Defense"
        
        func iconName() -> String {
            self == .Offense ? "attack_rune" : "defense_rune"
        }
        func title() -> String {
            self == .Offense ? "main_offense" : "main_defense"
        }
        func backgroundColor() -> Color {
            self == .Offense ? Color.theme.attackBG : Color.theme.defenseBG
        }
    }
    
    enum Rarity: String {
        case Normal = "Normal"
        case Rare = "Rare"
        case Epic = "Epic"
        case Legendary = "Legendary"
        
        func defaultLevel() -> Int {
            switch(self){
            case .Normal:
                return 5
            case .Rare:
                return 7
            case .Epic:
                return 7
            case .Legendary:
                return 7
            }
        }
        
        func minLevel() -> Int {
            switch(self) {
            case .Normal:
                return 1
            case .Rare:
                return 3
            case .Epic:
                return 5
            case .Legendary:
                return 7
            }
        }
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case name, rawRarity, rawType, rawBuff
    }
    
    var name: String
    
    var level: Int {
        get {
            let defaultLevel: Int = self.rarity.defaultLevel()
            let storedLevel: Int = PreferenceStore.getRuneLevel(rune: self)
            return  storedLevel == 0 ? defaultLevel: storedLevel
        }
        set {
            var level = newValue
            if(level < self.rarity.minLevel()) {
                level = self.rarity.minLevel()
            } else if(level > 10) {
                level = 10
            }
            PreferenceStore.setRuneLevel(rune: self, level: level)
        }
    }
    
    
    var rawRarity: String
    var rarity: Rarity {
        Rarity(rawValue: self.rawRarity)!
    }
    
    var rawType: String
    var type: RType {
        RType(rawValue: self.rawType)!
    }
    
    var rawBuff: String
    var passive: Buff {
        if let buff = GameModel.PassiveBuffs.first(where: {$0.id == self.rawBuff}) {
            return buff
        }
        return Buff(id: "ER", rawStat: "Power", value: 0)
    }
//    var active: Buff
    
    func Description() -> String {
        return "\(self.name) (\(self.rarity)):\n\(self.type)\n\(self.passive.Description())"
    }
    var passiveDescription: String {
        var desc: String = ""
        desc.append(self.passive.stat.rawValue)
        desc.append(" - ")
        desc.append(String(self.passive.value))
        desc.append("/lvl")
        return desc
    }
    
}
