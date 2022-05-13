//
//  About.swift
//  KECalculator
//
//  Created by Qioosei on 13/05/2022.
//

import SwiftUI

struct AboutTitle: View {
    
    @State var icon: String
    @State var text: String
    
    var body: some View {
            ZStack(alignment: .leading) {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width:15, height:15)
                    .foregroundColor(Color.theme.regular)
                    
                
                HStack {
                    StrokeText(text:text,width: 1,color: Color.black)
                        .font(.headline)
                    Spacer()
                }
                .offset(x: 25, y: 0)
            }
    }
}

struct AboutSplit: View {
    var body: some View {
        Spacer()
            .frame(minWidth: 100,maxWidth: 300, minHeight: 1,maxHeight: 1, alignment: .center)
            .background(Color.theme.regular.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 1))
    }
}

struct About: View {
    
    @EnvironmentObject var vm: OverviewViewModel
    
    @Binding var isShowing: Bool
    
    var body: some View {
        Popup(isShowing: $isShowing) {
            VStack(spacing:20) {
                StrokeText(text: "The Blacksmith V0.4", width: 1, color: Color.theme.background)
                    .font(.system(size: 35, weight: .bold, design: .default))
                    .padding()
                    .background(Color.black.opacity(0.2))
                    .lightBorder(cornerRadius: 5)
                
                VStack(spacing: 12) {
                    AboutTitle(icon: "questionmark.square.fill", text: "What is the Blacksmith?")
                    
                    HStack {
                        StrokeText(text: "The blacksmith is a build calculator for the mobile game Knight's edge. The blacksmith who sharpens your edge!",width:0.5,color: Color.black)
                        Spacer()
                    }
                    
                    AboutSplit()
                    
                    AboutTitle(icon: "questionmark.square.fill", text: "Who made it?")
                    
                    HStack {
                        StrokeText(text: "A fan of the game. You can find me on the game official discord: Qioosei#6532.\nI am NOT affiliated to LightFox Games and this app has been made for free for the community (and also because I had fun making it).",width:0.5,color: Color.black)
                        Spacer()
                    }
                    AboutSplit()
                    
                    HStack {
                        StrokeText(text: "Only use the latest version available at:", width: 0.5, color: Color.black)
                        Spacer()
                    }
                    Link("GitHub repository https://github.com/Qioosei/the-blacksmith-KE", destination: URL(string: "https://github.com/Qioosei/the-blacksmith-KE")!)
                    
                    
                }
                .padding()
                .background(Color.black.opacity(0.2))
                .lightBorder(cornerRadius: 5)
                
                
                
            }
            .padding()
            .background(Color.theme.itemBackground)
            .lightBorder(cornerRadius: 10)
            .frame(width:500)
        }
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            About(isShowing: .constant(true))
        }
    }
}
