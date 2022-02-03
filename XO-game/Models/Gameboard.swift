//
//  Gameboard.swift
//  XO-game
//
//  Created by Evgeny Kireev on 27/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public final class Gameboard {
    
    // MARK: - Properties
    
    private lazy var positions: [[Players?]] = initialPositions()
    
    // MARK: - public
    
    public func setPlayer(_ player: Players, at position: GameboardPosition) {
        positions[position.column][position.row] = player
    }
    
    public func clear() {
        self.positions = initialPositions()
    }
    
    public func contains(player: Players, at positions: [GameboardPosition]) -> Bool {
        for position in positions {
            guard contains(player: player, at: position) else {
                return false
            }
        }
        return true
    }
    
    public func contains(player: Players, at position: GameboardPosition) -> Bool {
        let (column, row) = (position.column, position.row)
        return positions[column][row] == player
    }
    
    // MARK: - Private
    
    private func initialPositions() -> [[Players?]] {
        var positions: [[Players?]] = []
        for _ in 0 ..< GameboardSize.columns {
            let rows = Array<Players?>(repeating: nil, count: GameboardSize.rows)
            positions.append(rows)
        }
        return positions
    }
}
