//
//  GameUnitClasses.swift
//  WarGameTest3
//
//  Created by Michael O'Connell on 5/6/20.
//  Copyright © 2020 Michael O'Connell. All rights reserved.
//

import Foundation

enum GameUnitType {
    case Player1
    case Player2
    case Player3
    case Player4
}


class GameUnit {
    var Player : Int
    
    init(player: Int) {
        Player = player
    }
}
