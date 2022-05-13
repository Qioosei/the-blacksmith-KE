//
//  SaveBuildPopup.swift
//  KECalculator
//
//  Created by Qioosei on 07/05/2022.
//

import SwiftUI
//

struct SaveBuildPopup: View {
    
    @EnvironmentObject var gm: GameModel
    @EnvironmentObject var vm: OverviewViewModel
    @EnvironmentObject var bm: BuildManager
    
    @State var buildName: String = ""
    @Binding var isShowing: Bool
    
//    @FocusState var focus: Bool
    
    func onCancel() -> Void {
        self.isShowing = false
    }
    
    func onSave() -> Void {
        print("onSave")
        let build: Build = gm.build
        build.name = buildName
        bm.SaveBuild(build: build)
        
//        let builds = BuildManager.BuildList
//        for build in builds {
//            print("\(build.Description())")
//        }
        print("onSave out")
        self.isShowing = false
    }
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.black.opacity(0.4))
            .opacity(self.isShowing ? 1.0 : 0.0)
            .onTapGesture {
                withAnimation {
                    self.isShowing = false
                }
            }
            VStack {
                HStack {
                    TextField("build name",text: $buildName)
//                        .focused($focus)
                        .frame(width: 180, height: 40)
                }
                HStack(spacing: 0) {
                    ContentButton(title: "cancel") {
                        if(self.buildName.count > 0) {
                            self.onSave()
                        }
                    }
                    ContentButton(title: "save") {
                        if(self.buildName.count > 0) {
                            self.onSave()
                        }
                    }
                }
                
                
            }
            .padding()
            .background(Color.theme.background)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder().foregroundColor(Color.theme.regular.opacity(0.2)))
        }
        .onAppear {
            self.buildName = gm.build.name
        }
    }
}

//struct LevelPicker_Previews: PreviewProvider {
//
//    static func onLevelSet(level: Int) -> Void {
//        print("test")
//    }
//
//    static var previews: some View {
//        VStack {
//            LevelPicker(level: .constant(1), type: .character, isShowing: .constant(true))
//
//        }.frame(width: 500, height: 500)
//    }
//}


struct SaveBuildPopup_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
//            LevelPicker(level: .constant(1), type: .character, isShowing: .constant(true))
            
            SaveBuildPopup(isShowing: .constant(true))
            
        }.frame(width: 500, height: 500)
    }
}
