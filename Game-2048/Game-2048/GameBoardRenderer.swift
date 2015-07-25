//
//  GameBoardRenderer.swift
//  Game-2048
//
//  Created by Tomasz Szulc on 25/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import Foundation
import UIKit

class GameBoardRenderer {
    private weak var boardView: GameBoardView?
    private var tileViews = [TileView]()
    
    init(boardView: GameBoardView) {
        self.boardView = boardView
    }
    
    func renderTiles(tiles: [Tile]) {
        for tileView in tileViews {
            tileView.removeFromSuperview()
        }
        tileViews.removeAll(keepCapacity: true)
        
        for tile in tiles.filter({$0.value != nil}) {
            let tileView = TileView.createView()
            tileView.valueLabel.text = "\(tile.value!)"
            tileView.backgroundColor = TileViewModel().backgroundColor(tile.value!)
            var frame = CGRectZero
            frame.origin = originForTile(tile.position)
            frame.size = tileSize
            tileView.frame = frame

            boardView!.addSubview(tileView)
            tileViews.append(tileView)
        }
    }
    
    private func originForTile(position: CGPoint) -> CGPoint {
        let x = (offset * position.x) + (tileSize.width * position.x)
        let y = (offset * position.y) + (tileSize.height * position.y)
        return CGPoint(x: x, y: y)
    }
    
    // offsets between tiles
    private var offset: CGFloat {
        return 8.0
    }
    
    private var tileSize: CGSize {
        return CGSize(width: 55, height: 55)
    }
}