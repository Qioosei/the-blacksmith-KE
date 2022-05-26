//
//  RuneListView.swift
//  keCalculator
//
//  Created by Qioosei on 16/04/2022.
//

import SwiftUI


struct RuneRow: View {
    
    @EnvironmentObject var gm: GameModel
    @State var rune: Rune
    var pickRune: (Rune) -> Void
    
    var buttonSize: CGFloat = 20
    
    var runePassiveEffect: String {
        let value: Double = Double(rune.level) * rune.passive.value
        return "\(value)% \(rune.passive.stat.rawValue)"
    }
    
    var body: some View {
        HStack{
            rune.Icon()
                .resizable()
                .scaledToFit()
                .frame(width: 45)
            Text(rune.name)
                .fontWeight(.bold)
                .foregroundColor(Color.theme.regular)
            Spacer()
            Text(runePassiveEffect)
                .foregroundColor(Color.theme.regular)
                .multilineTextAlignment(.trailing)
            ZStack {
                Image("button")
                    .resizable()
                    .scaledToFit()
                    .frame(width: buttonSize, height: buttonSize)
                Button {
                    gm.objectWillChange.send()
                    rune.level += 1
                } label: {
                    StrokeText(text: "+", width: 1, color: Color.black)
                        .frame(width: buttonSize, height: buttonSize)
                        .foregroundColor(Color.theme.regular)
                        .font(.system(size: 12,weight: .bold))
                        .contentShape(Rectangle())
                }
                .frame(width: buttonSize, height: buttonSize)
                .buttonStyle(PlainButtonStyle())
            }
            
            Text(String(rune.level))
                .fontWeight(.bold)
                .foregroundColor(Color.theme.regular)
                .multilineTextAlignment(.trailing)
            ZStack {
                Image("button")
                    .resizable()
                    .scaledToFit()
                    .frame(width: buttonSize, height: buttonSize)
                Button {
                    gm.objectWillChange.send()
                    rune.level -= 1
                } label: {
                    StrokeText(text: "-", width: 1, color: Color.black)
                        .frame(width: buttonSize, height: buttonSize)
                        .foregroundColor(Color.theme.regular)
                        .font(.system(size: 12,weight: .bold))
                        .contentShape(Rectangle())
                }
                .frame(width: buttonSize, height: buttonSize)
                .buttonStyle(PlainButtonStyle())
            }
            
        }
        .padding(EdgeInsets(top: 3, leading: 5, bottom: 3, trailing: 5))
        .background(rune.type == .Offense ? Color.theme.attackBG : Color.theme.defenseBG)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .overlay(RoundedRectangle(cornerRadius: 5).strokeBorder().foregroundColor(Color.theme.regular.opacity(0.2)))
        .onTapGesture {
            pickRune(rune)
        }
    }
}

struct RuneListView: View {
    
    // TODO: rework so it's not duplicated
    
    
    @EnvironmentObject var gm: GameModel
    @EnvironmentObject var vm: OverviewViewModel
    @Binding var isShowing: Bool
    @State var searchTerm: String = ""
    
    @State var filterPower: Bool = false
    @State var filterArmor: Bool = false
    @State var filterHealth: Bool = false
    @State var filterCritChance: Bool = false
    @State var filterCritDamage: Bool = false
    @State var filterCooldownReduction: Bool = false
    @State var filterMovespeed: Bool = false
    
    
    @State var type: Rune.RType
    
    func pick(rune: Rune) -> Void {
        print("\(rune.name) picked")
        gm.objectWillChange.send()
        gm.build.ChangeRune(type: self.type, at: vm.pickedSlot, rune: rune)
        withAnimation {
            self.isShowing = false
        }
    }
    
    
    
    var filteredRunes: [Rune] {
        var runes: [Rune]
        if(type == .Offense) {
            runes = GameModel.OffenseRunes()
        } else {
            runes = GameModel.DefenseRunes()
        }
        return runes.filter {
            self.isFiltered($0)
        }
    }
    
    func isFiltered(_ rune: Rune) -> Bool {
        let searchFiltered: Bool = searchTerm.isEmpty ? true : rune.name.lowercased().contains(searchTerm.lowercased())
        var filteredType: [Stat] = [Stat]()
        if(filterPower) {
            filteredType.append(Stat.Power)
        }
        if(filterArmor) {
            filteredType.append(Stat.Armor)
        }
        if(filterHealth) {
            filteredType.append(Stat.Health)
        }
        if(filterCritChance) {
            filteredType.append(Stat.CritChance)
        }
        if(filterCritDamage) {
            filteredType.append(Stat.CritDamage)
        }
        if(filterCooldownReduction) {
            filteredType.append(Stat.CoolDownReduction)
        }
        if(filterMovespeed) {
            filteredType.append(Stat.MoveSpeed)
        }
        
        let typeFiltered: Bool = filteredType.contains(rune.passive.stat)
        
        return searchFiltered && !typeFiltered
    }
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.black.opacity(0.4))
            .opacity(self.isShowing ? 1.0 : 0.0)
//            .animation(Animation.easeIn.delay(0.25))
            .onTapGesture {
                withAnimation {
                    self.isShowing = false
                }
            }
            
            VStack(spacing:2) {
                Spacer()
                VStack(spacing:12) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color.theme.regular)
                        TextField("Search Rune", text: $searchTerm)
                            .foregroundColor(Color.theme.regular)
                    }
                    
                    HStack {
                        StrokeText(text: "Filters:", width: 1, color: Color.black)
                            .font(.system(size: 14, weight: .bold))
                        Spacer()
                        HStack(spacing:20) {
                            FilterButton(filterIcon: "power", filterEnabled: $filterPower)
                            FilterButton(filterIcon: "hitpoints", filterEnabled: $filterHealth)
                            FilterButton(filterIcon: "armor", filterEnabled: $filterArmor)
                            FilterButton(filterIcon: "crit_chance", filterEnabled: $filterCritChance)
                            FilterButton(filterIcon: "crit_damage", filterEnabled: $filterCritDamage)
                            FilterButton(filterIcon: "cooldown", filterEnabled: $filterCooldownReduction)
                            FilterButton(filterIcon: "movespeed", filterEnabled: $filterMovespeed)
                        }
                        Spacer()
                    }
                }
                .padding(10)
                .background(Color.theme.regular.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            .background(Color.theme.background)
                
                
                ScrollView {
                    VStack(spacing:2) {// searchbar background here
                        
                        ForEach(filteredRunes){ rune in
                            RuneRow(rune: rune, pickRune: self.pick)
                                .padding(.horizontal,5)
                        }
                    }
                    .padding()
                }
                .frame(maxHeight:500)
                .background(Color.theme.background)
                .clipShape(RoundedRectangle(cornerRadius: 10))
//                .offset(y: self.isShowing ? 200 : 0)
                Spacer()
            }
            .padding(.horizontal,5)
        }
        
    }
}

struct FilterButton: View {
    var filterIcon: String
    @Binding var filterEnabled: Bool
    var body: some View {
        
            ZStack {
                Image("button")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                Image(filterIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                
            }
            .opacity(filterEnabled ? 0.3 : 1)
            .onTapGesture {
                filterEnabled.toggle()
            }
    }
}

struct RuneListView_Previews: PreviewProvider {
    
    static func pick() -> Void {
        print("exit picker")
    }
    
    static var previews: some View {
        RuneListView(isShowing: .constant(true), type: .Offense)
        RuneListView(isShowing: .constant(true), type: .Defense)
    }
}
