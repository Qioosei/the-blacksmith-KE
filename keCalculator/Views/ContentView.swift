//
//  ContentView.swift
//  keCalculator
//
//  Created by Qioosei on 12/04/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var gm: GameModel = GameModel.standard
    @StateObject var vm: OverviewViewModel = OverviewViewModel()
    @StateObject var bm: BuildManager = BuildManager.standard
    
    @State var showRunePicker: Bool = false
    
    enum Content: Int {
        case Build
        case Weapon
    }
    
    @State var content: Content = .Build
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                ZStack {
                    HStack {
                        Image("burger")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30, alignment: .center)
                            .onTapGesture {
                                vm.isShowingSideMenu = true
                            }
                        
                        Spacer()
                    }
                    Text("main_title")
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(Color.theme.regular)
                        .background(Color.theme.regular.opacity(0.1))
                        .lightBorder(cornerRadius: 5)
                    Spacer()
                }
                
                PlayerOverview()
                    .padding()
                
                HStack {
                    ContentButton(title: "Weapons") {
                        self.content = Content.Weapon
                    }
                    ContentButton(title: "Build") {
                        self.content = Content.Build
                    }
                }
                .padding()
                
                switch(content){
                case .Build:
                    HStack {
                        Spacer()
                        StrokeText(text: gm.build.name, width: 1, color: Color.black)
                        Spacer()
                    }
                    HStack {
                        ActiveEffectView()
                        Spacer()
                        VStack {
                            BuildRunesView(type: .Offense, showRunePicker: $showRunePicker)
                                .lightBorder(cornerRadius: 10)
                                .frame(width:425, height: 175, alignment: .center)
                            BuildRunesView(type: .Defense, showRunePicker: $showRunePicker)
                                .lightBorder(cornerRadius: 10)
                                .frame(width:425, height: 175, alignment: .center)
                        }
                    }
                    
                    HStack {
                        ContentButton(title: "Load") {
                            vm.isShowingBuildLoadPopup = true
                        }
                        ContentButton(title: "Save") {
                            vm.isShowingSavePopup = true
                        }
                        ContentButton(title: "Quick Save") {
                            bm.SaveBuild(build: gm.build)
                        }
                    }
                case .Weapon:
                    VStack {
                        HStack {
                            VStack {
                                WeaponPicker(weaponType: .Axe)
                                Spacer()
                                WeaponPicker(weaponType: .Sword)
                            }
                            .padding()
                            Spacer()
                            VStack {
                                WeaponPicker(weaponType: .Bow)
                                Spacer()
                                WeaponPicker(weaponType: .Staff)
                            }
                            .padding()
                        }
                    }
                    .background(Color.theme.regular.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                }
                
                Spacer()
            }
            .padding()
            
            if(showRunePicker) {
                RuneListView(isShowing: $showRunePicker, type: vm.pickedType)
            }
            if(vm.isShowingCharLvlPicker) {
                LevelPicker(level: $gm.player.level, type: .character, isShowing: $vm.isShowingCharLvlPicker)
            }
            if(vm.isShowingWeaponPicker) {
                LevelPicker(level: $gm.build.weapon.level, type: .weapon, isShowing: $vm.isShowingWeaponPicker)
            }
            if(vm.isShowingSavePopup) {
                SaveBuildPopup(isShowing: $vm.isShowingSavePopup)
            }
            if(vm.isShowingBuildLoadPopup) {
                LoadBuildPopup(isShowing: $vm.isShowingBuildLoadPopup)
            }
            if(vm.isShowingSideMenu) {
                HStack {
                    SideMenu()
                        .frame(width:200)
                        .padding()
                        .offset(x:-28,y:0)
                        .transition(.move(edge: .leading))
                    Spacer()
                    
                }
            }
            if(vm.isShowingAbout) {
                About(isShowing: $vm.isShowingAbout)
            }
        }
        .environmentObject(gm)
        .environmentObject(vm)
        .environmentObject(bm)
        
        
    }
}


struct ActiveEffectRow: View {
    @EnvironmentObject var gm: GameModel
    var buff: StatStackBuff.Stack
    var count: Int
    var effectLevel: Int
    
    var buttonSize: CGFloat = 20
    
    var singleBonus: Double {
        Double(buff.baseValue + Double(effectLevel) * buff.levelIncrement)
    }
    var singleBonusString: String {
        String(format:"%.2f",singleBonus)
    }
    var fullBonus: Double {
        singleBonus * Double(count)
    }
    var fullBonusString: String {
        String(format:"%.2f",fullBonus)
    }
    
    var body: some View {
        HStack{
            Text("\(singleBonusString) % * \(count) = \(fullBonusString)")

            Image(buff.stat.iconName())
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
            Spacer()
        }
    }
}

struct ActiveEffectView: View {
    
    @EnvironmentObject var gm: GameModel
    
    var body: some View {
        
        VStack(spacing:12) {
            
            Text("main_active_effects")
                .fontWeight(.bold)
                .font(.system(size: 13))
                .foregroundColor(Color.theme.regular)
                .padding(4)
            ScrollView {
                VStack(spacing:12) {
                    ForEach(gm.build.runes) { rune in
                        if let effects = rune.effects {
                            VStack(spacing:6){
                                ForEach(effects) { effect in
                                    HStack {
                                        Spacer()
                                        Text(effect.name)
                                        Spacer()
                                    }
                                    ForEach(effect.affect) { stack in
                                        ActiveEffectRow(buff: stack, count: effect.currentCount, effectLevel: rune.effectLevel)
                                    }
                                }
                            }
                            .padding(EdgeInsets(top: 8, leading: 10, bottom: 5, trailing: 10))
                            .background(Color.theme.itemBackground)
                            .lightBorder(cornerRadius: 2)
                        }
                    }
                }
            }
        }
        .frame(minWidth:300)
        .padding()
        .background(Color.theme.regular.opacity(0.1))
        .lightBorder(cornerRadius: 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}
