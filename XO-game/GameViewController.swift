//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    //MARK: - Outlets
    var computer: Bool!
    @IBOutlet weak var gameboardView: GameboardView!
    @IBOutlet weak var computerTurnLabel: UILabel!
    @IBOutlet weak var firstPlayerTurnLabel: UILabel!
    @IBOutlet weak var secondPlayerTurnLabel: UILabel!
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        Log(.restartGame)
        dismiss(animated: true)
    }
    
    
    //MARK: - Properties
    private let gameboard = Gameboard()
    private var counter = 0
    private lazy var referee = Referee(gameboard: self.gameboard)
    private let mode = Session.shared.mode
    private var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }
    
    //MARK: - Livecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.goToFirstState()
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.currentState.addMark(at: position)
            if self.currentState.isCompleted {
                self.goToNextState()
            }
        }
    }
    
    
    
    //MARK: - Private
    private func goToFirstState() {
        let player = Players.first
        if mode == .fiveByFive {
            currentState = PlayerInputState(player: player.next,
                                            gameViewController: self,
                                            gameboard: gameboard,
                                            gameboardView: gameboardView,
                                            markViewPrototype: player.markViewPrototype)
        } else {
            currentState = PlayerInputState(player: player.next,
                                            gameViewController: self,
                                            gameboard: gameboard,
                                            gameboardView: gameboardView,
                                            markViewPrototype: player.markViewPrototype)
        }
    }
    
    private func goToNextState() {
        let playerInputState = currentState as? PlayerInputState
        let player = playerInputState?.player.next
        
        
        if player == .computer {
            delay(0.5) { [self] in
                currentState = ComputerState(player: player!,
                                             gameViewController: self,
                                             gameboard: gameboard,
                                             gameboardView: gameboardView,
                                             markViewPrototype: player!.markViewPrototype)
                counter += 1
                goToFirstState()
                _ = checkForGameOver()
                return
            }
        } else if let playerInputState = currentState as? PlayerInputState {
            let player = playerInputState.player.next
            currentState = PlayerInputState(player: player,
                                            gameViewController: self,
                                            gameboard: gameboard,
                                            gameboardView: gameboardView,
                                            markViewPrototype: player.markViewPrototype)
            
        }
    }
    
    private func checkForGameOver() -> Bool {
        if let winner = referee.determineWinner() {
            Log(.gameFinished(winner: winner))
            currentState = GameEndedState(winner: winner, gameViewController: self)
            return true
        }
        
        if counter >= 9 {
            Log(.gameFinished(winner: nil))
            currentState = GameEndedState(winner: nil, gameViewController: self)
            return true
        }
        return false
    }
    
    
    private func delay(_ delay: Double, closure: @escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
}

