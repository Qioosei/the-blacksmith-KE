//
//  ContentButton.swift
//  KECalculator
//
//  Created by Qioosei on 07/05/2022.
//

import SwiftUI

struct ContentButton : View {
    @State var title: String
    var onClick:() -> Void
    var body: some View {
        ZStack {
            Image("largebutton")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 30)
            Button {
                self.onClick()
            } label: {
                StrokeText(text: title, width: 1, color: Color.black)
                    .frame(width: 75, height: 30)
                    .foregroundColor(Color.theme.regular)
                    .font(.system(size: 12,weight: .bold))
                    .contentShape(Rectangle())
            }
            .frame(width: 75, height: 30)
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct ContentButton_Previews: PreviewProvider {
    static var previews: some View {
        ContentButton(title: "title", onClick: {})
    }
}
