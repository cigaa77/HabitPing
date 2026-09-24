//
//  HabitDetailViewController.swift
//  HabitPing
//
//  Created by Ahmet CILINGIR on 24.09.26.
//

import UIKit

final class HabitDetailViewController: UIViewController {
    
    var habit: Habit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = habit?.name
    }
}
