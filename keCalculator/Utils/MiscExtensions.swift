//
//  MiscExtensions.swift
//  keCalculator
//
//  Created by Qioosei on 12/04/2022.
//

import Foundation
import SwiftUI



extension Color {
    static let theme = Color.Theme()
    
    struct Theme {
        let background = Color("main_background")
        let focused = Color("focused_control")
        let normal = Color("normal_control")
        let accent = Color("accent")
        let regular = Color("main_text")
        let health = Color("health")
        let armor = Color("armor")
        let power = Color("power")
        let attackBG = Color("attack_background")
        let defenseBG = Color("defense_background")
        let itemBackground = Color("item_background")
    }
}


//
//struct LightBorder: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .overlay(RoundedRectangle(cornerRadius: 10)
//                        .strokeBorder()
//                        .foregroundColor(Color.theme.regular
//                                            .opacity(0.2)
//                                        )
//            )
//            .shadow(color: .black, radius: 1, x: 0, y: 0)
//    }
//}

extension View {
    func lightBorder(cornerRadius: CGFloat = 10, color: Color = Color.theme.regular.opacity(0.2)) -> some View {
        clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10)
                    .strokeBorder()
                    .foregroundColor(color)
        )
        .shadow(color: .black, radius: 1, x: 0, y: 0)
    }
}

extension UserDefaults {

    func valueExists(forKey key: String) -> Bool {
        return object(forKey: key) != nil
    }

}
