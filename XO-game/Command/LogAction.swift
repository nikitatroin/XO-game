//
//  LogAction.swift
//  XO-game
//
//  Created by Никита Троян on 26.01.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

enum LogAction {
    case gameFinished(winner: Players?)
    case playerInput(player: Players, position: GameboardPosition)
    case restartGame
    
}

func Log(_ action: LogAction) {
    let command = LogCommand(action: action)
    LoggerInvoker.shared.addLogCommand(command)
}
