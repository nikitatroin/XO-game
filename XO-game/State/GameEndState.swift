//
//  GameEndState.swift
//  XO-game
//
//  Created by Никита Троян on 25.01.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import UIKit

public class GameEndedState: GameState {
    
    public let isCompleted = false
    
    public let winner: Players?
    private(set) weak var gameViewController: GameViewController?
    
    init(winner: Players?, gameViewController: GameViewController) {
        self.winner = winner
        self.gameViewController = gameViewController
    }
    
    public func begin() {
        self.gameViewController?.winnerLabel.isHidden = false
        if let winner = winner {
            self.gameViewController?.winnerLabel.text = self.winnerName(from: winner) + " win"
        } else {
            self.gameViewController?.winnerLabel.text = "No winner"
        }
        self.gameViewController?.firstPlayerTurnLabel.isHidden = true
        self.gameViewController?.secondPlayerTurnLabel.isHidden = true
        Log(.gameFinished(winner: self.winner))
    }
    
    public func addMark(at position: GameboardPosition) { }
    
    private func winnerName(from winner: Players) -> String {
        switch winner {
        case .first:
            return Session.shared.mode == .againstComputer ? "Human" : "1st player"
        case .second:
            return "2nd player"
        case .computer:
            return "Computer"
        }
    }
}
