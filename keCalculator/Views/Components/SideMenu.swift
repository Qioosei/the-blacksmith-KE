//
//  SideMenu.swift
//  KECalculator
//
//  Created by Qioosei on 13/05/2022.
//

import SwiftUI

struct SideMenu: View {
    
    @EnvironmentObject var vm: OverviewViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Spacer()
                Image("burger")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30, alignment: .trailing)
                    .onTapGesture {
                        withAnimation {
                            vm.isShowingSideMenu = false
                        }
                    }
            }
            ContentButton(title: "About") {
                withAnimation {
                    vm.isShowingSideMenu = false
                    vm.isShowingAbout = true
                }
                
            }
            ContentButton(title: "Settings") {
                
            }
            
            Spacer()
        }
        .padding(EdgeInsets(top: 12, leading: 22, bottom: 12, trailing: 12))
        .background(Color.theme.background)
        .lightBorder(cornerRadius: 10)
        .frame(maxWidth:.infinity,maxHeight:.infinity, alignment: .leading)
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu()
    }
}
