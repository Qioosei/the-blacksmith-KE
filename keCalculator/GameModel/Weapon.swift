//
//  Weapon.swift
//  keCalculator
//
//  Created by Qioosei on 12/04/2022.
//

import Foundation

struct Weapon: Codable {
    
    enum WType: String, CaseIterable, Codable {
        case Sword
        case Axe
        case Bow
        case Staff
        
        func basePower() -> Double {
            switch(self){
            case .Sword:
                return 50
            case .Bow:
                return 60
            case .Axe:
                return 50
            case .Staff:
                return 70
            }
            
        }
        
        func baseHealth() -> Double {
            switch(self){
            case .Sword:
                return 500
            case .Bow:
                return 300
            case .Axe:
                return 700
            case .Staff:
                return 300
            }
        }
        
        
        func baseArmor() -> Double {
            switch(self){
            case .Sword:
                return 45
            case .Bow:
                return 25
            case .Axe:
                return 30
            case .Staff:
                return 20
            }
        }
    }
    
    
    enum Element: String, CaseIterable, Codable {
        case Fire
        case Ice
        case Lightning
        case Holy
        case Void
        case Royal
    }
    
    
    var level: Int
    
    var type: WType
    var element: Element
    
    var power: Double {
        GameModel.stat(withBase: type.basePower(), level: level)
    }
    
    var armor: Double {
        GameModel.stat(withBase: type.baseArmor(), level: level)
    }
    
    var health: Double {
        GameModel.stat(withBase: type.baseHealth(), level: level)
    }
    
    var imageName: String {
        let name: String = "\(self.type.rawValue)_\(self.element.rawValue)"
        return name.lowercased()
    }
    
}
