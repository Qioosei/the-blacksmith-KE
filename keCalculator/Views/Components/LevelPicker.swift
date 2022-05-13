//
//  LevelPicker.swift
//  keCalculator
//
//  Created by Qioosei on 03/05/2022.
//

import SwiftUI

struct LevelButton: View {
    
    @State var value: Int
    var onClick: (Int) -> Void
    
    var body: some View {
        
        ZStack {
            Image("button")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            Button {
                self.onClick(value)
            } label: {
                StrokeText(text: String(value), width: 1, color: Color.black)
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.theme.regular)
                    .font(.system(size: 12,weight: .bold))
                    .contentShape(Rectangle())
            }
            .frame(width: 50, height: 50)
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct LevelPicker: View {
    
    enum PickerType {
        case character
        case weapon
        case rune
    }
    
    @Binding var level: Int
    @State var type: PickerType
    @State var enteredLevel: String = ""
    
    
    @Binding var isShowing: Bool
    
    func onLevelSet(level: Int) -> Void {
        self.level = level
        self.isShowing = false
    }
    
    func onSaveLevel() -> Void {
        self.level = Int(enteredLevel) ?? 1
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
                    TextField("level",text: $enteredLevel)
                        .frame(width: 150, height: 40)
                    ZStack {
                        Image("button")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Button {
                            self.onSaveLevel()
                        } label: {
                            Image(systemName: "checkmark")
                                .resizable()
                                .scaledToFit()
                                .shadow(color: .black, radius: 1, x: 0, y: 0)
                                .shadow(color: .black, radius: 1, x: 0, y: 0)
                                .frame(width: 15, height: 15)
                            
                        }
                        .frame(width: 50, height: 50)
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                
                
                switch(type) {
                case .character:
                    HStack {
                        LevelButton(value: 1, onClick: onLevelSet)
                        LevelButton(value: 30, onClick: onLevelSet)
                        LevelButton(value: 40, onClick: onLevelSet)
                        LevelButton(value: 50, onClick: onLevelSet)
                    }
                case .weapon:
                    HStack {
                        LevelButton(value: 1, onClick: onLevelSet)
                        LevelButton(value: 30, onClick: onLevelSet)
                        LevelButton(value: 40, onClick: onLevelSet)
                        LevelButton(value: 50, onClick: onLevelSet)
                    }
                case .rune:
                    HStack {
                        LevelButton(value: 1, onClick: onLevelSet)
                        LevelButton(value: 5, onClick: onLevelSet)
                        LevelButton(value: 7, onClick: onLevelSet)
                        LevelButton(value: 10, onClick: onLevelSet)
                    }
                }
            }
            .padding()
            .background(Color.theme.background)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder().foregroundColor(Color.theme.regular.opacity(0.2)))
        }
    }
}

struct LevelPicker_Previews: PreviewProvider {
    
    static func onLevelSet(level: Int) -> Void {
        print("test")
    }
    
    static var previews: some View {
        VStack {
            LevelPicker(level: .constant(1), type: .character, isShowing: .constant(true))
            
        }.frame(width: 500, height: 500)
    }
}
