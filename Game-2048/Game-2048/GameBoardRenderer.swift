//
//  GameBoardRenderer.swift
//  Game-2048
//
//  Created by Tomasz Szulc on 25/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit

class GameBoardRenderer {
    
    private weak var boardView: GameBoardView?
    private var tileViews = [TileView]()
    
    init(boardView: GameBoardView) {
        self.boardView = boardView
    }
    
    func reset() {
        for view in tileViews {
            view.removeFromSuperview()
        }
        
        tileViews.removeAll(keepCapacity: true)
    }
    
    func addTile(tile: Tile) {
        let tileView = TileView.createView()
        tileView.position = tile.position
        
        let viewModel = TileViewModel(value: tile.value!)
        tileView.valueLabel.text = viewModel.valueText
        tileView.backgroundColor = viewModel.backgroundColor
        tileView.valueLabel.alpha = 0
        
        tileView.frame = CGRectZero
        tileView.center = centerForTile(tile.position)
        
        boardView!.addSubview(tileView)
        
        UIView.animateWithDuration(0.25, animations: {
            var bounds = tileView.bounds
            bounds.size = self.tileSize
            tileView.bounds = bounds
        }) { (finished) -> Void in
            UIView.animateWithDuration(0.15) {
                tileView.valueLabel.alpha = 1
            }
        }
        
        tileViews.append(tileView)
    }
    
    func moveTile(sourceTile: Tile, onTile destinationTile: Tile) {
        let sourceTileView = tileViews.filter({$0.position == sourceTile.position}).first!
        let destinationTileView = tileViews.filter({$0.position == destinationTile.position}).first!
        boardView?.bringSubviewToFront(sourceTileView)
        
        UIView.animateWithDuration(0.25, animations: {
            sourceTileView.center = destinationTileView.center
            sourceTileView.position = destinationTile.position
            destinationTileView.alpha = 0
            
            let viewModel = TileViewModel(value: destinationTile.value!)
            sourceTileView.valueLabel.text = viewModel.valueText
            sourceTileView.backgroundColor = viewModel.backgroundColor

        }) { (finished) -> Void in
            destinationTileView.alpha = 0
            destinationTileView.removeFromSuperview()
            
            let index = find(self.tileViews, destinationTileView)
            self.tileViews.removeAtIndex(index!)
        }
    }
    
    func moveTile(tile: Tile, position: Position) {
        let tileView = tileViews.filter({$0.position == tile.position}).first!
        UIView.animateWithDuration(0.25, animations: {
            tileView.center = self.centerForTile(position)
            tileView.position = position
        })
    }
    
    private func centerForTile(position: Position) -> CGPoint {
        let x = (offset * CGFloat(position.x)) + (tileSize.width * CGFloat(position.x)) + (tileSize.width / 2.0)
        let y = (offset * CGFloat(position.y)) + (tileSize.height * CGFloat(position.y)) + (tileSize.height / 2.0)
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