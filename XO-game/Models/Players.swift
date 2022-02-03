//
//  Player.swift
//  XO-game
//
//  Created by Evgeny Kireev on 26/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation


public enum Players: CaseIterable {
    case first
    case second
    case computer
    
    var next: Players {
        switch self {
        case .first: return Session.shared.mode == .againstComputer ? .computer : .second
        case .second: return .first
        case .computer: return .first
        }
    }
    
    var markViewPrototype: MarkView {
        switch self {
        case .first:
            return XView()
        case .second, .computer:
            return OView()
        }
    }
}
