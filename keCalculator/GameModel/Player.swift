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
    
    var power: Int {
        GameModel.stat(withBase: 50, level: level)
    }
    var health: Int {
        GameModel.stat(withBase: 300, level: level)
    }
    var armor: Int {
        GameModel.stat(withBase: 20, level: level)
    }
    
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
