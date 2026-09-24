//
//  NotificationManager.swift
//  HabitPing
//
//  Created by Ahmet CILINGIR on 23.09.26.
//

import UserNotifications

protocol NotificationManagerDelegate: AnyObject {
    func notificationManager(
        _ manager: NotificationManager,
        didReceivedWithID habitID: String
    )
}

final class NotificationManager: NSObject, UNUserNotificationCenterDelegate {

    private let notificationCenter = UNUserNotificationCenter.current()

    static let shared = NotificationManager()

    weak var delegate: NotificationManagerDelegate?

    private override init() {
        super.init()

        notificationCenter.delegate = self
    }

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
        content.userInfo = ["habitID": habit.id.uuidString]

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

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse
    ) async {
        let userInfo = response.notification.request.content.userInfo

        guard let habitID = userInfo["habitID"] as? String else { return }

        print("Received response for habit with ID: \(habitID)")

        delegate?.notificationManager(self, didReceivedWithID: habitID)
    }
}
