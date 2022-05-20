//
//  BuildRunesView.swift
//  keCalculator
//
//  Created by Qioosei on 13/04/2022.
//

import SwiftUI

struct BuildRunesView: View {
    
    @EnvironmentObject var gm: GameModel
    @EnvironmentObject var vm: OverviewViewModel
    
    @State var type: Rune.RType
    @Binding var showRunePicker: Bool
    
    
    
    var runes: [Rune] {
        self.type == .Offense ? gm.build.offenseRunes : gm.build.defenseRunes
    }
    
    func pick() -> Void {
        self.showRunePicker = false
    }
    
    var body: some View {
        VStack(spacing:0){
            Text(LocalizedStringKey(type.title()))
                .fontWeight(.bold)
                .font(.system(size: 13))
                .foregroundColor(Color.theme.regular)
                .padding(4)
            HStack {
                Spacer()
                ForEach(runes.indices){ i in
                    VStack {
                        runes[i].Icon()
                            .resizable()
                            .scaledToFit()
                            .frame(width:75)
                        Text(runes[i].name)
                            .font(.system(size: 11))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.theme.regular)
                    }
                    .onTapGesture {
                        withAnimation {
                            self.showRunePicker = true
                            vm.pickedSlot = i
                            vm.pickedType = runes[i].type
                        }
                    }
//                    .sheet(isPresented: $showRunePicker){
//                        RuneListView(type: runes[i].type, pickRune: pick)
//                    }
                }
                Spacer()
            }
            .padding()
        }
        .background(self.type.backgroundColor())
    }
}

struct BuildRunesView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                BuildRunesView(type: .Offense, showRunePicker: .constant(false))
                BuildRunesView(type: .Defense, showRunePicker: .constant(false))
            }
        }
        .environmentObject(GameModel())
        .environmentObject(OverviewViewModel())
    }
}
