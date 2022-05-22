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
            
            HStack {
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
                            StatText(buff:.Power)
                        }
                        Spacer()
                    }
                    HStack {
                        Image("hitpoints")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth:30)
                        VStack {
                            Text("main_health")
                                .font(.system(size: 10))
                                .foregroundColor(Color.theme.health)
                            StatText(buff:.Health)
                        }
                        Spacer()
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
                            StatText(buff:.Armor)
                        }
                        Spacer()
                    }
                }
                VStack {
                    HStack {
                        Image("crit_chance")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth:30)
                        VStack {
                            Text("main_crit_chance")
                                .font(.system(size: 10))
                                .foregroundColor(Color.theme.power)
                            StatText(buff:.CritChance)
                        }
                        Spacer()
                    }
                    HStack {
                        Image("crit_damage")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth:30)
                        VStack {
                            Text("main_crit_damage")
                                .font(.system(size: 10))
                                .foregroundColor(Color.theme.power)
                            StatText(buff:.CritDamage)
                        }
                        Spacer()
                    }
                }
                VStack {
                    HStack {
                        Image("cooldown")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth:30)
                        VStack {
                            Text("main_cooldown")
                                .font(.system(size: 10))
                                .foregroundColor(Color.theme.armor)
                            StatText(buff:.CoolDownReduction)
                        }
                        Spacer()
                    }
                    HStack {
                        Image("movespeed")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth:30)
                        VStack {
                            Text("main_movespeed")
                                .font(.system(size: 10))
                                .foregroundColor(Color.theme.armor)
                            StatText(buff:.MoveSpeed)
                        }
                        Spacer()
                    }
                }
            }
            .padding()
            .background(Color.theme.background)
            .lightBorder(cornerRadius: 5)
            
            Spacer()
            
            
            Spacer()
        }
        .frame(height:155)
        .padding()
        .background(Color.theme.regular.opacity(0.1))
        .lightBorder(cornerRadius: 10)
    }
}

struct StatText: View {
    
    
    @EnvironmentObject var gm: GameModel
    
    var buff: Buff.Stat
    
    var base: Double { gm.getBaseStat(buff)}
    var bonus: Double { gm.getPassiveBonus(buff)}
    var total: Double { base + bonus }
    
    
    var body: some View {
        HStack {
            Text(String(Int(total)))
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(Color.theme.regular)
            Text(" (\(Int(base)) + \(Int(bonus)) )")
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(Color.theme.regular.opacity(0.8))
        }
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
