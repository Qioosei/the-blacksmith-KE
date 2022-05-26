//
//  LoadBuildPopup.swift
//  KECalculator
//
//  Created by Qioosei on 08/05/2022.
//

import SwiftUI

struct BuildRow: View {
    
    @EnvironmentObject var bm: BuildManager
    
    @State var build: Build
    var pickBuild: (Build) -> Void
    
    var body: some View {
        HStack{
            Image(build.weapon.imageName)
                .resizable()
                .scaledToFit()
                .frame( height: 25)
            Spacer()
            StrokeText(text: build.name, width: 1, color: Color.black)
                .foregroundColor(Color.theme.regular)
                .font(.system(size: 12,weight: .bold))
            Spacer()
            
            ContentButton(title: "delete") {
                bm.RemoveBuild(build: build)
                
            }
        }
        .padding(EdgeInsets(top: 3, leading: 5, bottom: 3, trailing: 5))
        .background(Color.theme.itemBackground)
        .lightBorder(cornerRadius: 5)
        .onTapGesture {
            self.pickBuild(build)
        }
    }
}

struct LoadBuildPopup: View {
    @EnvironmentObject var gm: GameModel
    @EnvironmentObject var vm: OverviewViewModel
    @EnvironmentObject var bm: BuildManager
    
    @Binding var isShowing: Bool
    @State var searchTerm: String = ""
    
    var filteredBuilds: [Build] {
        bm.BuildList.filter {
            searchTerm.isEmpty ? true : $0.name.lowercased().contains(searchTerm.lowercased())
        }
    }
    
    func pick(build: Build) -> Void {
        print("\(build.name) picked")
        gm.build = build
        withAnimation {
            self.isShowing = false
        }
    }
    
    var body: some View {
        Popup(isShowing: $isShowing) {
            VStack(spacing:2) {
                Spacer()
                ScrollView {
                    VStack(spacing:2) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color.theme.regular)
                            TextField("Search Build", text: $searchTerm)
                                .foregroundColor(Color.theme.regular)
                        }
                        .padding(10) // searchbar background here
                        .background(Color.theme.regular.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .background(Color.theme.background)
                        
                        ForEach(filteredBuilds){ build in
                            BuildRow(build: build, pickBuild: self.pick)
                                .padding(.horizontal,5)
                        }
                    }
                    .padding()
                }
                .frame(maxHeight:500)
                .background(Color.theme.background)
                .lightBorder(cornerRadius: 10)
//                .offset(y: self.isShowing ? 200 : 0)
                Spacer()
            }
            .padding(.horizontal,5)
            .frame(maxWidth: 300)
        }
    }
}

struct LoadBuildPopup_Previews: PreviewProvider {
    
    static func pick() -> Void {
        print("exit picker")
    }
    
    static var previews: some View {
        LoadBuildPopup(isShowing: .constant(true))
            .environmentObject(GameModel.standard)
            .environmentObject(BuildManager.standard)
            .environmentObject(OverviewViewModel())
    }
}
