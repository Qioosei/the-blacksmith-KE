//
//  BuildManager.swift
//  keCalculator
//
//  Created by Qioosei on 16/04/2022.
//

import Foundation

class BuildManager: ObservableObject {
    
    static let standard: BuildManager = BuildManager()
    
    private init() {
        
    }
    
    var BuildList: [Build] {
        return PreferenceStore.Builds
    }
   
    func SaveBuild (build: Build) {
        PreferenceStore.lastBuild = build.name
        
        self.objectWillChange.send()
        var builds: [Build] = self.BuildList
        if let i = builds.firstIndex(where: {$0.name == build.name}) {
            builds[i] = build
        } else {
            builds.append(build)
        }
        PreferenceStore.Builds = builds
    }
    func RemoveBuild (build: Build) {
        self.objectWillChange.send()
        var builds: [Build] = self.BuildList
        if let i = builds.firstIndex(where: {$0.name == build.name}) {
            builds.remove(at: i)
            PreferenceStore.Builds = builds
        }
    }
    
    static var emptyBuild: Build {
        var offRunes: [Rune] = [Rune]()
        offRunes.append(Rune_Sample.EmptyOffense)
        offRunes.append(Rune_Sample.EmptyOffense)
        offRunes.append(Rune_Sample.EmptyOffense)
        offRunes.append(Rune_Sample.EmptyOffense)
        
        var defRunes: [Rune] = [Rune]()
        defRunes.append(Rune_Sample.EmptyDefense)
        defRunes.append(Rune_Sample.EmptyDefense)
        defRunes.append(Rune_Sample.EmptyDefense)
        defRunes.append(Rune_Sample.EmptyDefense)
        
        return Build(name: "testBuild1", offenseRunes: offRunes, defenseRunes: defRunes,weapon: Weapon(level: 1, type: .Sword, element: .Royal))
    }
    
//    static func Encode(build: Build) -> Data {
//        var buildPrint: String = "\(build.name);"
//        for rune: Rune in build.offenseRunes {
//            buildPrint.append("\(rune.id)/")
//        }
//        buildPrint.append(";")
//        for rune: Rune in build.defenseRunes {
//            buildPrint.append("\(rune.id)/")
//        }
//        print("Build encoded: \(buildPrint)")
//        return buildPrint.data(using:.utf8)!
//    }
//
//    static func Decode(data: Data) -> Build {
//        let buildPrint:String = String(data: data, encoding: .utf8)!
//        let splitBuild: [String] = buildPrint.components(separatedBy: ";")
//
//        for elem: String in splitBuild {
//            print(elem)
//        }
//
//        let name: String = splitBuild[0]
//        var offenseRunes: [Rune] = [Rune]()
//        for idString: String in splitBuild[1].components(separatedBy: "/") {
//            if(idString.count > 0) {
//                offenseRunes.append(GameModel.RuneWithID(id:idString))
//
//            }
//        }
//        var defenseRunes: [Rune] = [Rune]()
//        for idString: String in splitBuild[2].components(separatedBy: "/") {
//            if(idString.count > 0) {
//                defenseRunes.append(GameModel.RuneWithID(id:idString))
//            }
//        }
//
//        return Build(name: name, offenseRunes: offenseRunes, defenseRunes: defenseRunes,weapon:  Weapon(level: 1, type: .Sword, element: .Royal))
//    }
}

class Build: Codable, Identifiable {
    
    var id: UUID = UUID()
    
    var name: String {
        didSet {
            self.id = UUID()
        }
    }
    var offenseRunes: [Rune]
    var defenseRunes: [Rune]
    var weapon: Weapon
    
    init(name: String, offenseRunes: [Rune], defenseRunes: [Rune], weapon: Weapon) {
        self.name = name
        self.offenseRunes = offenseRunes
        self.defenseRunes = defenseRunes
        self.weapon = weapon
    }
    
    func ChangeRune( type: Rune.RType,at index: Int, rune:Rune) -> Void {
        
        if(index == -1) {
            print("build change index error.")
            return
        }
        
        print(self.Description())
        print("changing \(type) rune#\(index) with \(rune.name)")
        var runes: [Rune] = type == .Offense ? offenseRunes : defenseRunes
        runes.remove(at: index)
        runes.insert(rune, at: index)
        if(type == .Offense)
        {
            self.offenseRunes = runes
        }
        else {
            self.defenseRunes = runes
        }
        print(self.Description())
    }
    
    func Description() -> String {
        var desc : String = ""
        desc.append(self.name)
        desc.append("\nOffense:\n")
        for rune: Rune in self.offenseRunes {
            desc.append("\(rune.name)\n")
        }
        desc.append("Defense:\n")
        for rune: Rune in self.defenseRunes {
            desc.append("\(rune.name)\n")
        }
        return desc
    }
    
}

