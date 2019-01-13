//
//  Constants.swift
//  Tip Calculator
//
//  Created by Abid Amirali on 1/12/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import Foundation

struct Constants {
    struct UserDefaults {
        static let defaultTipIndex = "defaultTipIndex"
        static let darkModeEnabled = "darkModeEnabled"
    }
    
    struct Appearance {
        struct Light {
            static let viewBackgroundColor = "lightModeBackgroundColor"
            static let headerColor = "lightModeHeaderColor"
            static let inputViewColor = "lightModeInputColor"
        }
        
        struct Dark {
            static let inputViewColor = "darkModeInputColor"
        }
    }
    
}
