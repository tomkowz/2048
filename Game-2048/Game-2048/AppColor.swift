//
//  AppColor.swift
//  Game-2048
//
//  Created by Tomasz Szulc on 25/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit

enum AppColor {
    case Background
    case Button
    case Yellow
    
    var color: UIColor {
        switch self {
        case .Background: return UIColor(red:0.35, green:0.24, blue:0.47, alpha:1)
        case .Button: return UIColor(white: 1.0, alpha: 0.2)
        case .Yellow: return UIColor(red:0.94, green:0.77, blue:0.34, alpha:1)
        }
    }
}