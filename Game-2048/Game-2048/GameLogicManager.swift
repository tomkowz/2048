//
//  GameLogicManager.swift
//  Game-2048
//
//  Created by Tomasz Szulc on 25/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation
import CoreGraphics

public func ==(lhs: CGPoint, rhs: CGPoint) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}

class GameLogicManager {
    
    var tileNodes = [TileNode]()
    
    func prepare() {
        for row in 0..<4 {
            for column in 0..<4 {
                tileNodes.append(TileNode(position: CGPoint(x: row, y: column)))
            }
        }
    }
    
    func addRandomTile() {
        if let position = generatePosition() {
            let tileNode = tileForPosition(position)
            tileNode.value = 2
            print(tileNode.position)
        }
    }
    
    private func tileForPosition(position: CGPoint) -> TileNode {
        return tileNodes.filter({$0.position == position}).first!
    }
    
    private var freeTiles: Int {
        return tileNodes.filter({$0.value == nil}).count
    }
    
    private func generatePosition() -> CGPoint? {
        if freeTiles == 0 { return nil }

        func isEmpty(point: CGPoint) -> Bool {
            return tileForPosition(point).value == nil
        }
        
        var position: CGPoint?
        while (position == nil) {
            let x = Int(arc4random_uniform(4))
            let y = Int(arc4random_uniform(4))
            var p = CGPoint(x: x, y: y)
            if isEmpty(p) == true {
                position = p
                break
            }
        }
        
        return position
    }
}