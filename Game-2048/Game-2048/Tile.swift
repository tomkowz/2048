//
//  Tile.swift
//  Game-2048
//
//  Created by Tomasz Szulc on 25/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation
import CoreGraphics

func == (lhs: Position, rhs: Position) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}

struct Position: Equatable {
    var x, y: Int
    
    var CGPointRepresentation: CGPoint {
        return CGPointMake(CGFloat(x), CGFloat(y))
    }
}

class Tile {
    let position: Position
    var value: Int?
    
    var upTile: Tile?
    var rightTile: Tile?
    var bottomTile: Tile?
    var leftTile: Tile?
    
    init(position: Position, value: Int? = nil) {
        self.position = position
        self.value = value
    }
}
