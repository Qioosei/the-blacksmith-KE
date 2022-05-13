//
//  Buff.swift
//  keCalculator
//
//  Created by Qioosei on 13/04/2022.
//

import Foundation

struct Buff: Codable, Hashable, Identifiable {
    enum Stat: String {
        case Power = "Power"
        case Armor = "Armor"
        case Health = "Health"
        case CritChance = "CritChance"
        case CritDamage = "CritDamage"
        case MoveSpeed = "MoveSpeed"
        case CoolDownReduction = "CoolDownReduction"
    }
    var id: String
    var rawStat: String
    var stat: Stat {
        Stat(rawValue: self.rawStat)!
    }
    var value: Double
    
    func Description() -> String {
        return "\(self.stat)<\(self.id)> - \(self.value)"
    }
    
}
