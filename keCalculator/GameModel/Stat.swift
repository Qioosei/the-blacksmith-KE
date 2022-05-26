//
//  Stat.swift
//  KECalculator
//
//  Created by Guillaume Brahier on 23/05/2022.
//

import Foundation


enum Stat: String, Codable {
    case Power = "Power"
    case Armor = "Armor"
    case Health = "Health"
    case CritChance = "CritChance"
    case CritDamage = "CritDamage"
    case MoveSpeed = "MoveSpeed"
    case CoolDownReduction = "CoolDownReduction"
    case ExpBonus = "ExpBonus"
    
    func iconName() -> String {
        switch(self) {
        case .Power:
            return "power"
        case .Armor:
            return "armor"
        case .Health:
            return "health"
        case .CritChance:
            return "crit_chance"
        case .CritDamage:
            return "crit_damage"
        case .MoveSpeed:
            return "movespeed"
        case .CoolDownReduction:
            return "cooldown"
        case .ExpBonus:
            return ""
        }
    }
}
