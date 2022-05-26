//
//  Player.swift
//  keCalculator
//
//  Created by Qioosei on 12/04/2022.
//

import Foundation
import SwiftUI


class Player {
    
    var level: Int {
        didSet {
            PreferenceStore.playerLevel = level
        }
    }
    init() {
        self.level = PreferenceStore.playerLevel
    }
    
    var power: Double {
        GameModel.stat(withBase: 50, level: level)
    }
    var health: Double {
        GameModel.stat(withBase: 300, level: level)
    }
    var armor: Double {
        GameModel.stat(withBase: 20, level: level)
    }
    
    var cooldownReduction: Double = 0
    var critChance: Double = 10
    var critDamage: Double = 50
    var moveSpeed: Double = 100
    var expRate: Double = 1
    
    func levelUp() {
        self.level += 1
    }
    
    func levelDown() {
        if(self.level > 1)
        {
            self.level -= 1
        }
    }
    
}
