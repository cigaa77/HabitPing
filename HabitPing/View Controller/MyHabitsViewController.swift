//
//  ViewController.swift
//  HabitPing
//
//  Created by Ahmet CILINGIR on 22.09.26.
//

import UIKit

class MyHabitsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var emptyStateView: UIView!

    private let viewModel = MyHabitViewModel()

    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()

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

        tableView.dataSource = self
        updateEmptyState()

        viewModel.requestNotificationPermission { granted in
            print("Notification permission granted: \(granted)")
        }

        NotificationManager.shared.delegate = self
    }

    @objc func addButtonTapped() {

        guard
            let navigationController = storyboard?.instantiateViewController(
                identifier: "AddHabitViewController"
            ) as? UINavigationController,

            let addHabitViewController = navigationController.topViewController
                as? AddHabitViewController
        else { return }

        addHabitViewController.delegate = self

        present(navigationController, animated: true)
    }

    private func updateEmptyState() {
        let isEmpty = viewModel.numberOfHabits == 0
        emptyStateView.isHidden = !isEmpty
        tableView.isHidden = isEmpty
    }

}

extension MyHabitsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return viewModel.numberOfHabits
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "HabitCell",
                for: indexPath
            ) as? HabitTableViewCell
        else { return UITableViewCell() }

        let habit = viewModel.habit(at: indexPath.row)
        cell.emojiLabel.text = habit.emoji
        cell.nameLabel.text = habit.name
        cell.detailLabel.text = "Every morning"
        cell.notificationImageView.image = UIImage(
            systemName: habit.notificationsEnabled ? "bell.fill" : "bell.slash"
        )
        cell.detailLabel.text =
            "Every day • \(timeFormatter.string(from: habit.reminderTime))"

        return cell

    }

}

extension MyHabitsViewController: AddHabitViewControllerDelegate {

    func addHabitViewController(
        _ controller: AddHabitViewController,
        didCreate habit: Habit
    ) {
        viewModel.addHabit(habit: habit)
        tableView.reloadData()
        updateEmptyState()
    }
}

extension MyHabitsViewController: NotificationManagerDelegate {

    func notificationManager(
        _ manager: NotificationManager,
        didReceivedWithID habitID: String
    ) {

        guard let habit = viewModel.habit(withID: habitID) else { return }
        print("\(habit.name) was triggered")

        guard
            let habitDetailViewController = storyboard?
                .instantiateViewController(
                    withIdentifier: "HabitDetailViewController"
                ) as? HabitDetailViewController
        else { return }

        habitDetailViewController.habit = habit

        navigationController?.pushViewController(
            habitDetailViewController,
            animated: true
        )
    }

}
