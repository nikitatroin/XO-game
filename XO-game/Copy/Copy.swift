//
//  Copy.swift
//  XO-game
//
//  Created by Никита Троян on 26.01.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

protocol Copying {
    init (_ protype: Self)
}

extension Copying {
    func copy() -> Self {
        return type(of: self).init(self)
    }
}
