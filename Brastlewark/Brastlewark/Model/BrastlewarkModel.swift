//
//  BrastlewarkModel.swift
//  Brastlewark
//
//  Created by Cano Rudkin, Elliot Joseph on 15/6/22.
//

import Foundation


struct Brastlewark: Decodable {
    var brastlewark: [Gnome] = []
    
    enum CodingKeys: String, CodingKey {
        case brastlewark = "Brastlewark"
    }
}

struct Gnome: Decodable {
    var id: Int = 0
    var name: String = ""
    var thumbnail: URL?
    var age: Int = 0
    var weight: Double = 0
    var height: Double = 0
    var hair_color: String = ""
    var professions: [String] = []
    var friends: [String] = []
}
