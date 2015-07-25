//
//  TileViewModel.swift
//  Game-2048
//
//  Created by Tomasz Szulc on 25/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit

class TileViewModel {
    
    let value: Int
    
    init(value: Int) {
        self.value = value
    }
    
    var valueText: String {
        return "\(value)"
    }
    
    var backgroundColor: UIColor {
        switch value {
        case 2: return UIColor(red:0.5, green:0.77, blue:0.73, alpha:1)
        case 4: return UIColor(red:0.73, green:0.29, blue:0.42, alpha:1)
        case 8: return UIColor(red:0.58, green:0.73, blue:0.13, alpha:1)
        case 16: return UIColor(red:0.94, green:0.77, blue:0.34, alpha:1)
        case 32: return UIColor(red:0.84, green:0.49, blue:0.32, alpha:1)
        case 64: return UIColor(red:0.36, green:0.52, blue:0.84, alpha:1)
        case 128: return UIColor(red:0.46, green:0.74, blue:0.51, alpha:1)
        case 256: return UIColor(red:0.85, green:0.45, blue:0.13, alpha:1)
        case 512: return UIColor(red:0.5, green:0.27, blue:0.53, alpha:1)
        case 1024: return UIColor(red:0.83, green:0.27, blue:0.36, alpha:1)
        case 2048: return UIColor(red:0.88, green:0.6, blue:0.14, alpha:1)
        default: return UIColor.clearColor() // This will never happen.
        }
    }
}