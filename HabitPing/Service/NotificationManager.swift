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
}
