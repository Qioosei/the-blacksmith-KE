//
//  workspace.swift
//  keCalculator
//
//  Created by Qioosei on 12/04/2022.
//

import SwiftUI

struct workspace: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                VStack {
                    Text("Default font design").font(Font.system(size:30, design: .default))
                    Text("Monospaced font design").font(Font.system(size:30, design: .monospaced))
                    Text("Rounded font design").font(Font.system(size:30, design: .rounded))
                    Text("Serif font design").font(Font.system(size:30, design: .serif))
                }
                VStack {
                    Text("Large Title").font(.largeTitle)
                    Text("Title").font(.title)
                    Text("Headline").font(.headline)
                    Text("SubHeadline").font(.subheadline)
                    Text("Body").font(.body)
                    Text("Callout").font(.callout)
                    Text("Caption").font(.caption)
                    Text("FootNote").font(.footnote)
                    
                    Text("Custom font").font(Font.custom("OpenSans-Bold", size: 12.3))
                }
            }
            .foregroundColor(Color.theme.regular)
            
        }
    }
}

struct workspace_Previews: PreviewProvider {
    static var previews: some View {
        workspace()
    }
}
