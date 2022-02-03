//
//  Session.swift
//  XO-game
//
//  Created by Никита Троян on 03.02.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

enum GameMode {
    case againstHuman
    case againstComputer
    case fiveByFive
}

final class Session {
    static var shared = Session()
    
    var mode: GameMode!
    
    private init () {}
    
    var playerFirstMoves: [PlayerMove] = []
    var playerSecondMoves: [PlayerMove] = []
}
