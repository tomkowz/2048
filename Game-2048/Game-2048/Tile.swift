//
//  Tile.swift
//  Game-2048
//
//  Created by Tomasz Szulc on 25/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation
import CoreGraphics

func ==(lhs: Tile, rhs: Tile) -> Bool {
    return lhs.position == rhs.position
}

class Tile: Equatable {
    
    var position: CGPoint
    var value: Int?
    
    var upTile: Tile?
    var rightTile: Tile?
    var bottomTile: Tile?
    var leftTile: Tile?
    
    init(position: CGPoint, value: Int? = nil) {
        self.position = position
        self.value = value
    }
    
    
}