//
//  Tile.swift
//  Game-2048
//
//  Created by Tomasz Szulc on 25/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation
import CoreGraphics

class Tile {
    
    var position: CGPoint
    var value: Int?
    
    init(position: CGPoint, value: Int? = nil) {
        self.position = position
        self.value = value
    }
}