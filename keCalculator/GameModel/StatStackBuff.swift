//
//  StatStackBuff.swift
//  KECalculator
//
//  Created by Guillaume Brahier on 23/05/2022.
//

import Foundation


struct StatStackBuff: Codable, Identifiable {
    
    var id: String {
        return self.name
    }
    
    var name: String
    var affect: [Stack]
    var condition: String
    var duration: Double
    var maxCount: Int
    var defaultCount: Int
    var currentCount: Int {
        get {
            return  PreferenceStore.getEffectCount(effect: self, default: self.defaultCount)
        }
        set {
            var count = newValue
            if(count < 0) {
                return
            } else if(count > self.maxCount) {
                count = self.maxCount
            }
            PreferenceStore.setEffectCount(effect: self, count: count)
        }
    }
    
    private enum CodingKeys: String,CodingKey {
        case name,affect,condition,duration,maxCount,defaultCount
    }
    
    func stackForStat(_ buff: Stat) -> [Stack] {
        return self.affect.filter {
            $0.stat == buff
        }
    }
    
    struct Stack: Codable, Identifiable {
        
        private enum CodingKeys: String, CodingKey {
            case stat, baseValue, levelIncrement
        }
        var id: UUID = UUID()
        var stat: Stat
        var baseValue: Double
        var levelIncrement: Double
    }
}
