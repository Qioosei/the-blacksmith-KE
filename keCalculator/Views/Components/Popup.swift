//
//  Popup.swift
//  KECalculator
//
//  Created by Qioosei on 08/05/2022.
//

import SwiftUI

struct Popup<Content: View>: View {
    
    @Binding var isShowing: Bool
    let content: Content
    
    init(isShowing: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isShowing = isShowing
        self.content = content()
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
            
            content
        }
    }
}

