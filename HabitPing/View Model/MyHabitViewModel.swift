//
//  HabitViewModel.swift
//  HabitPing
//
//  Created by Ahmet CILINGIR on 22.09.26.
//

import Foundation

final class MyHabitViewModel {
    private(set) var habits: [Habit] = []

    var numberOfHabits: Int {
        return habits.count
    }

    func habit(at index: Int) -> Habit {
        habits[index]
    }

    func habit(withID id: String) -> Habit? {
        habits.first {
            $0.id.uuidString == id
        }
    }

    init() {

        createSampleHabits()
    }

    func addHabit(habit: Habit) {
        habits.append(habit)

        if habit.notificationsEnabled {
            NotificationManager.shared.scheduleNotification(for: habit)
        }
    }

    func removeHabit(at index: Int) {
        let habit = habits[index]
        // let habit = habits.remove(at: index)

        NotificationManager.shared.cancelNotification(for: habit)
        habits.remove(at: index)
    }

    func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        NotificationManager.shared.requestAuthorization { granted in
            completion(granted)
        }
    }

    private func createSampleHabits() {
        let calendar = Calendar.current

        let morning = calendar.date(
            bySettingHour: 8,
            minute: 0,
            second: 0,
            of: Date()
        )!

        let evening = calendar.date(
            bySettingHour: 19,
            minute: 0,
            second: 0,
            of: Date()
        )!

        habits = [
            Habit(
                name: "Feed the dog",
                emoji: "🐶",
                reminderTime: morning,
                notificationsEnabled: true
            ),
            Habit(
                name: "Study German",
                emoji: "📚",
                reminderTime: evening,
                notificationsEnabled: true
            ),
            Habit(
                name: "Workout",
                emoji: "🏋️",
                reminderTime: evening,
                notificationsEnabled: false
            ),
        ]
    }
}
