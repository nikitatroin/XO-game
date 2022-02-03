//
//  PlayerInputState.swift
//  XO-game
//
//  Created by Никита Троян on 25.01.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import UIKit

public class PlayerInputState: GameState {
    
    public let markViewPrototype: MarkView
    
    public private(set) var isCompleted = false
    
    public let player: Players
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?
    
    init(player: Players, gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView, markViewPrototype: MarkView) {
        self.player = player
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
        self.markViewPrototype = markViewPrototype
    }
    
    public func begin() {
        switch self.player {
        case .first:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = false
            self.gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second, .computer:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = true
            self.gameViewController?.secondPlayerTurnLabel.isHidden = false
        }
        self.gameViewController?.winnerLabel.isHidden = true
        
    }
    
    public func addMark(at position: GameboardPosition) {
        guard let gameboardView = self.gameboardView
            , gameboardView.canPlaceMarkView(at: position)
            else { return }
    
        
        self.gameboard?.setPlayer(self.player, at: position)
        self.gameboardView?.placeMarkView(self.markViewPrototype.copy(), at: position)
        self.isCompleted = true
        
        Log(.playerInput(player: self.player, position: position))
        
    }
}
