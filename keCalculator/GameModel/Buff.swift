//
//  Buff.swift
//  keCalculator
//
//  Created by Qioosei on 13/04/2022.
//

import Foundation

struct Buff: Codable, Hashable, Identifiable {
    var id: String
    
    var stat: Stat
    var value: Double
    
    func Description() -> String {
        return "\(self.stat)<\(self.id)> - \(self.value)"
    }
    
}




