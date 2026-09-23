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
}
