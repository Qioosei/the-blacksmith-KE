//
//  MainViewModel.swift
//  keCalculator
//
//  Created by Qioosei on 12/04/2022.
//

import Foundation
import SwiftUI

class OverviewViewModel: ObservableObject {
    
    var pickedSlot: Int = -1
    var pickedType: Rune.RType = .Offense
    
    @Published var isShowingCharLvlPicker: Bool = false
    @Published var isShowingWeaponPicker: Bool = false
    @Published var isShowingSavePopup: Bool = false
    @Published var isShowingBuildLoadPopup: Bool = false
    @Published var isShowingSideMenu: Bool = false
    @Published var isShowingAbout: Bool = false
    
}
