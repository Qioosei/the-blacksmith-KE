//
//  Rune.swift
//  keCalculator
//
//  Created by Qioosei on 13/04/2022.
//

import Foundation
import SwiftUI


struct Rune_Sample {
    static let Rune1: Rune = Rune(name: "CALLED TARGET", rarity: .Legendary, type: .Offense, rawBuff: "PW")
    static let EmptyOffense: Rune = Rune(name: "empty", rarity: .Normal, type: .Offense, rawBuff: "ER")
    static let EmptyDefense: Rune = Rune(name: "empty", rarity: .Normal, type: .Defense, rawBuff: "ER")

}

struct Rune : Codable, Identifiable{
    var id: String {
        return name
    }
    
    enum RType: String, Codable {
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
    
    enum Rarity: String, Codable {
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
    
    var effects: [StatStackBuff]?
    
    func effectsForStat(_ buff: Stat) -> [StatStackBuff] {
        var filteredEffects = [StatStackBuff]()
        
        if let effects = self.effects {
            for effect in effects {
                if(effect.stackForStat(buff).count > 0) {
                    filteredEffects.append(effect)
                }
            }
        }
        
        
        
        return filteredEffects
    }
    
    private enum CodingKeys: String, CodingKey {
        case name, rarity, type, rawBuff, effects
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
    var effectLevel: Int {
        var offset = 0
        if(rarity == .Legendary) {
            offset = 1
        }
        if(level < 7) {
            return 0
        } else if (level < 10) {
            return 1 - offset
        } else {
            return 2 - offset
        }
    }
    
    
    var rarity: Rarity
    
    var type: RType
    
    var rawBuff: String
    var passive: Buff {
        if let buff = GameModel.PassiveBuffs.first(where: {$0.id == self.rawBuff}) {
            return buff
        }
        return Buff(id: "ER", stat: .Power, value: 0)
    }
    
    
    
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
    
    var iconName: String {
        var iconName = self.name.lowercased()
        iconName = iconName.replacingOccurrences(of: " ", with: "_")
        return iconName
    }
    
    func Icon() -> Image {
        let nsImage = NSImage(named: NSImage.Name(self.iconName))
        if let image = nsImage {
            return Image(nsImage: image)
        }
        print("using default for \(self.name) (\(self.iconName))")
        return Image(self.type.iconName())
    }
}
