//
//  NotificationManager.swift
//  HabitPing
//
//  Created by Ahmet CILINGIR on 23.09.26.
//

import UserNotifications

final class NotificationManager {

    private let notificationCenter = UNUserNotificationCenter.current()

    static let shared = NotificationManager()

    private init() {}

    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        notificationCenter.requestAuthorization(options: [
            .alert,
            .sound,
            .badge,
        ]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error)")
                completion(false)
                return
            }

            completion(granted)
        }
    }

    func scheduleNotification(for habit: Habit) {
        let content = UNMutableNotificationContent()
        content.title = "Habit Ping"
        content.body = "Time for \(habit.name) \(habit.emoji)"
        content.sound = .default

        let dateComponents = Calendar.current.dateComponents(
            [.hour, .minute],
            from: habit.reminderTime
        )

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: habit.id.uuidString,
            content: content,
            trigger: trigger
        )

        notificationCenter.add(request) { error in
            if let error {
                print("Failed to add notification: \(error)")
            } else {
                print("Notification added successfully. \(habit.name)")
            }
        }
    }
}
