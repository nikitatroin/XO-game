//
//  StartViewController.swift
//  XO-game
//
//  Created by Никита Троян on 27.01.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//



import UIKit

final class StartViewController: UIViewController {
    
    @IBOutlet var segmentController: UISegmentedControl!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segmentController.selectedSegmentIndex == 0 {
            Session.shared.mode = .againstComputer
        }
        
        if segmentController.selectedSegmentIndex == 1 {
            Session.shared.mode = .againstHuman
        }
        
        if segmentController.selectedSegmentIndex == 2 {
            Session.shared.mode = .fiveByFive
        }
        
    }
    
}
