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
    
    var basePower: Int {
        return player.power + weapon.power
    }
    var baseHealth: Int {
        player.health + weapon.health
    }
    var baseArmor: Int {
        player.armor + weapon.armor
    }
    
    var inGamePower: Int {
        return getInGameStat(.Power)
    }
    
    var inGameHealth: Int {
        return getInGameStat(.Health)
    }
    
    var inGameArmor: Int {
        return getInGameStat(.Armor)
    }
    
    func getInGameStat(_ buff: Buff.Stat) -> Int {
            var multiplier: Double = 0
            var passiveRunes: [Rune] = build.offenseRunes.filter ({ $0.passive.stat == buff })
            passiveRunes.append(contentsOf:build.defenseRunes.filter({$0.passive.stat == buff}))
            
            for rune: Rune in passiveRunes {
                multiplier += Double(rune.level) * rune.passive.value
            }
        var stat: Double = 0
        if(buff == .Power) {
            stat = Double(basePower)
        } else if(buff == .Armor) {
            stat = Double(baseArmor)
        } else if(buff == .Health) {
            stat = Double(baseHealth)
        }
            let calculatedStat: Double = Double(stat) * (1 + multiplier/100)
            return Int(round(calculatedStat))
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
    
    static func stat(withBase base: Int, level: Int) -> Int {
        let calculatedStat: Double = Double(pow(Double(1.02),Double(level))) * Double(base)
        return Int(round(calculatedStat))
    }
    
}
