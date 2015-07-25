//
//  TileView.swift
//  Game-2048
//
//  Created by Tomasz Szulc on 25/07/15.
//  Copyright (c) 2015 Tomasz Szulc. All rights reserved.
//

import UIKit

class TileView: UIView {
    @IBOutlet var valueLabel: UILabel!
    var position: Position = Position(x: 0, y: 0)
    
    class func createView() -> TileView {
        let nibContent = UINib(nibName: "TileView", bundle: nil).instantiateWithOwner(nil, options: nil)
        let view = nibContent.first as! TileView
       
        view.layer.cornerRadius = 6.0
        return view
    }
}
