//
//  WeaponPicker.swift
//  KECalculator
//
//  Created by Qioosei on 06/05/2022.
//

import SwiftUI

struct WeaponPicker: View {
    
    @EnvironmentObject var gm: GameModel
    @EnvironmentObject var vm: OverviewViewModel
    @State var weaponType: Weapon.WType
    
    var body: some View {
        VStack {
            
            Text(LocalizedStringKey(weaponType.rawValue))
                .fontWeight(.bold)
                .font(.system(size: 13))
                .foregroundColor(Color.theme.regular)
                .padding(4)
            HStack {
                ForEach(Weapon.Element.allCases, id: \.rawValue) { item in
                    Image(Weapon(level: 0, type: self.weaponType, element: item).imageName)
                        .resizable()
                        .scaledToFit()
                        .frame( maxHeight: 100)
                        .onTapGesture {
                            gm.objectWillChange.send()
                            gm.build.weapon = Weapon(level: 40, type: self.weaponType, element: item)
                        }
                    
                    
                }
            }
        }
    }
}

struct WeaponPicker_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            WeaponPicker(weaponType: .Axe)
            WeaponPicker(weaponType: .Bow)
            WeaponPicker(weaponType: .Sword)
            WeaponPicker(weaponType: .Staff)
        }
    }
}
