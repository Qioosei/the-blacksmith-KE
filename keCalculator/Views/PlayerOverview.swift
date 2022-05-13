//
//  PlayerOverview.swift
//  keCalculator
//
//  Created by Qioosei on 13/04/2022.
//

import SwiftUI

struct WeaponDisplay: View {
    
    @EnvironmentObject var gm: GameModel
    @EnvironmentObject var vm: OverviewViewModel
    
    var body: some View {
        
        ZStack {
            Image(gm.weapon.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 100)
                    .padding()
                    .onTapGesture {
                        vm.isShowingWeaponPicker = true
                }
            ZStack {
                Image("level_background")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth:35)
                Text("\(gm.weapon.level)")
                    .fontWeight(.bold)
                    .foregroundColor(Color.theme.regular)
            }.offset(x: 45, y: 52)
            
        }
    }
}

struct PlayerOverview: View {
    
    @EnvironmentObject var gm: GameModel
    @EnvironmentObject var vm: OverviewViewModel
    
    var body: some View {
        HStack {
            
            WeaponDisplay()
            VStack(spacing:2) {
                Text("main_level")
                    .font(.system(size: 10))
                    .foregroundColor(Color.theme.regular)
                ZStack {
                    Image("level_background")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth:50)
                    Text("\(gm.player.level)")
                        .fontWeight(.bold)
                        .foregroundColor(Color.theme.regular)
                }.onTapGesture {
                    // Display lvl picker
                    vm.isShowingCharLvlPicker = true
                }
            }
            
            VStack {
                HStack {
                    Image("power")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth:30)
                    VStack {
                        Text("main_power")
                            .font(.system(size: 10))
                            .foregroundColor(Color.theme.power)
                        Text(String(gm.basePower))
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.regular)
                    }
                }
                //                        .padding(EdgeInsets(top: 2, leading: 8, bottom: 2, trailing: 8))
                //                        .background(Color.theme.background)
                //                        .clipShape(RoundedRectangle(cornerRadius: 3))
                HStack {
                    Image("hitpoints")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth:30)
                    VStack {
                        Text("main_health")
                            .font(.system(size: 10))
                            .foregroundColor(Color.theme.health)
                        Text(String(gm.baseHealth))
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.regular)
                    }
                }
                HStack {
                    Image("armor")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth:30)
                    VStack {
                        Text("main_armor")
                            .font(.system(size: 10))
                            .foregroundColor(Color.theme.armor)
                        Text(String(gm.baseArmor))
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.regular)
                    }
                }
            }
            .padding()
            .background(Color.theme.background)
            .lightBorder(cornerRadius: 5)
            Spacer()
            
            HStack {
                VStack {
                    HStack {
                        VStack {
                            Text("main_ig_power")
                                .font(.system(size: 10))
                                .foregroundColor(Color.theme.power)
                            Text(String(gm.inGamePower))
                                .fontWeight(.bold)
                                .foregroundColor(Color.theme.regular)
                        }
                        Image("power")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth:30)
                    }
                    HStack {
                        VStack {
                            Text("main_ig_health")
                                .font(.system(size: 10))
                                .foregroundColor(Color.theme.health)
                            Text(String(gm.inGameHealth))
                                .fontWeight(.bold)
                                .foregroundColor(Color.theme.regular)
                        }
                        Image("hitpoints")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth:30)
                    }
                    HStack {
                        VStack {
                            Text("main_ig_armor")
                                .font(.system(size: 10))
                                .foregroundColor(Color.theme.armor)
                            Text(String(gm.inGameArmor))
                                .fontWeight(.bold)
                                .foregroundColor(Color.theme.regular)
                        }
                        Image("armor")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth:30)
                    }
                }
                .padding()
            }
            .background(Color.theme.background)
            .lightBorder(cornerRadius: 5)
            
            Spacer()
        }
        .frame(height:155)
        .padding()
        .background(Color.theme.regular.opacity(0.1))
        .lightBorder(cornerRadius: 10)
    }
}

struct PlayerOverview_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            PlayerOverview()
        }
        .environmentObject(GameModel())
        .environmentObject(OverviewViewModel())
    }
}
