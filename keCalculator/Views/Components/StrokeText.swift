//
//  StrokeText.swift
//  keCalculator
//
//  Created by Qioosei on 03/05/2022.
//

import SwiftUI

struct StrokeText: View {
    let text: String
    var localizedText: LocalizedStringKey {
        LocalizedStringKey(text)
    }
    let width: CGFloat
    let color: Color

    var body: some View {
        ZStack{
            ZStack{
                Text(localizedText).offset(x:  width, y:  width)
                Text(localizedText).offset(x: -width, y: -width)
                Text(localizedText).offset(x: -width, y:  width)
                Text(localizedText).offset(x:  width, y: -width)
            }
            .foregroundColor(color)
            Text(localizedText)
        }
    }
}

