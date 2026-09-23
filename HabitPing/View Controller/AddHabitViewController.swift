//
//  AddHabitViewController.swift
//  HabitPing
//
//  Created by Ahmet CILINGIR on 22.09.26.
//

import UIKit

protocol AddHabitViewControllerDelegate: AnyObject {
    func addHabitViewController(
        _ controller: AddHabitViewController,
        didCreate habit: Habit
    )
}

final class AddHabitViewController: UIViewController {

    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emojiTextField: UITextField!
    @IBOutlet private weak var reminderDatePicker: UIDatePicker!
    @IBOutlet private weak var notificationsSwitch: UISwitch!

    weak var delegate: AddHabitViewControllerDelegate?

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
        guard let name = nameTextField.text,
            !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else {
            return
        }
        let emoji =
            emojiTextField.text?.isEmpty == false ? emojiTextField.text! : "✨"

        let habit = Habit(
            name: name,
            emoji: emoji,
            reminderTime: reminderDatePicker.date,
            notificationsEnabled: notificationsSwitch.isOn
        )

        delegate?.addHabitViewController(self, didCreate: habit)

        dismiss(animated: true)
    }
}
