//
//  GameModel.swift
//  keCalculator
//
//  Created by Qioosei on 16/04/2022.
//

import Foundation
import Combine

class GameModel: ObservableObject {
    
    @Published var player: Player
    @Published var build: Build
    var weapon: Weapon {
        return build.weapon
    }
    
    var basePower: Double {
        return player.power + weapon.power
    }
    var baseHealth: Double {
        player.health + weapon.health
    }
    var baseArmor: Double {
        player.armor + weapon.armor
    }
    
//    var inGamePower: Int {
//        return getInGameStat(.Power)
//    }
//
//    var inGameHealth: Int {
//        return getInGameStat(.Health)
//    }
//
//    var inGameArmor: Int {
//        return getInGameStat(.Armor)
    //    }
    
    func getBaseStat(_ buff: Buff.Stat) -> Double {
        
        var stat: Double = 0
        switch(buff) {
        case .Armor:
            stat = Double(baseArmor)
        case .Health:
            stat = Double(baseHealth)
        case .Power:
            stat = Double(basePower)
        case .CoolDownReduction:
            stat = player.cooldownReduction
        case .CritChance:
            stat = player.critChance
        case .CritDamage:
            stat = player.critDamage
        case .MoveSpeed:
            stat = player.moveSpeed
        }
        return stat
    }
    
    func getInGameStat(_ buff: Buff.Stat) -> Double {
        
        let stat = self.getBaseStat(buff)
        let bonus = self.getPassiveBonus(stat, self.getPassiveMultiplier(buff))
        return stat + bonus
    }
    
    func getPassiveBonus(_ buff: Buff.Stat) -> Double {
        
        if([Buff.Stat.Armor,Buff.Stat.Health,Buff.Stat.Power,Buff.Stat.MoveSpeed].contains(buff)) {
            let stat = self.getBaseStat(buff)
            let multiplier = self.getPassiveMultiplier(buff)
            
            let calculatedStat: Double = stat * (multiplier/100)
            print("\(buff.rawValue) passive bonus: \(calculatedStat) = \(stat) * (\(multiplier)/100)")
            return calculatedStat
        }
        else {
            return self.getPassiveMultiplier(buff)
        }
    }
    
    func getPassiveBonus(_ stat: Double, _ multiplier: Double) -> Double {
        let calculatedStat: Double = stat * (multiplier/100)
        
        return calculatedStat
    }
    
    func getPassiveMultiplier(_ buff: Buff.Stat) -> Double {
        var multiplier: Double = 0
        var passiveRunes: [Rune] = build.offenseRunes.filter ({ $0.passive.stat == buff })
        passiveRunes.append(contentsOf:build.defenseRunes.filter({$0.passive.stat == buff}))
        
        for rune: Rune in passiveRunes {
            multiplier += Double(rune.level) * rune.passive.value
        }
        print("\(buff.rawValue) = \(multiplier)")
        return multiplier
    }
    
    init() {
        self.player = Player()
        let lastBuild = PreferenceStore.lastBuild
        
        self.build = BuildManager.emptyBuild
        
        if(lastBuild.count > 0) {
            if let build = BuildManager.standard.BuildList.first(where: {$0.name == lastBuild}) {
                self.build = build
            }
        }
        
    }
    
    
    static let PassiveBuffs: [Buff] = Bundle.main.decode("PassiveBuff.json")
    static let Runes: [Rune] = Bundle.main.decode("Runes.json")
    
    static func RuneWithID( id: String) -> Rune {
        if let rune: Rune = GameModel.Runes.first(where: {$0.id == id}){
            return rune
        }
        return Rune_Sample.EmptyOffense
    }
    
    static func OffenseRunes() -> [Rune] {
        return GameModel.Runes.filter({ $0.type == .Offense})
    }
    static func DefenseRunes() -> [Rune] {
        return GameModel.Runes.filter({ $0.type == .Defense})
    }
    
    static func OffenseSample() -> [Rune] {
        var tmpRunes: [Rune] = [Rune]()
        tmpRunes.append(GameModel.OffenseRunes()[0])
        tmpRunes.append(GameModel.OffenseRunes()[1])
        tmpRunes.append(GameModel.OffenseRunes()[2])
        tmpRunes.append(GameModel.OffenseRunes()[3])
        return tmpRunes
    }
    static func DefenseSample() -> [Rune] {
        var tmpRunes: [Rune] = [Rune]()
        tmpRunes.append(GameModel.DefenseRunes()[0])
        tmpRunes.append(GameModel.DefenseRunes()[1])
        tmpRunes.append(GameModel.DefenseRunes()[2])
        tmpRunes.append(GameModel.DefenseRunes()[3])
        return tmpRunes
    }
    
    static func stat(withBase base: Double, level: Int) -> Double {
        let calculatedStat: Double = Double(pow(Double(1.02),Double(level))) * base
        return round(calculatedStat)
    }
    
}
