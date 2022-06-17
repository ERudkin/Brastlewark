//
//  Constants.swift
//  Brastlewark
//
//  Created by Cano Rudkin, Elliot Joseph on 15/6/22.
//

import Foundation
import UIKit.UIColor
struct Constants {
    
    static let cellIdentifier = "SearchViewCell"
    
    static let segueID = "goToDetail"
    
    static func getHairColor(with string: String) -> CGColor {
        switch string {
        case "Red":
            return UIColor.red.cgColor
        case "Gray":
            return UIColor.gray.cgColor
        case "Pink":
            return UIColor.systemPink.cgColor
        case "Green":
            return UIColor.green.cgColor
        default:
            return UIColor.black.cgColor
        }
    }
}
