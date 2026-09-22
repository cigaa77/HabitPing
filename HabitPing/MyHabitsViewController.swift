//
//  ViewController.swift
//  HabitPing
//
//  Created by Ahmet CILINGIR on 22.09.26.
//

import UIKit

class MyHabitsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        title = "My Habits"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
    }

    @objc func addButtonTapped() {
        print("Add habit tapped")
    }

}
