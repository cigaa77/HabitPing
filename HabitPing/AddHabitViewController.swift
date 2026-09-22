//
//  AddHabitViewController.swift
//  HabitPing
//
//  Created by Ahmet CILINGIR on 22.09.26.
//

import UIKit

final class AddHabitViewController: UIViewController {
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emojiTextField: UITextField!
    @IBOutlet private weak var reminderDatePicker: UIDatePicker!
    @IBOutlet private weak var notificationsSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Add Habit"

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.cancel,
            target: self,
            action: #selector(cancelButtonTapped)
        )

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.save,
            target: self,
            action: #selector(saveButtonTapped)
        )
    }

    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }

    @objc func saveButtonTapped() {
        print("Saved")
    }
}
