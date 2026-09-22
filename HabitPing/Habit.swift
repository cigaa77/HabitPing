//
//  Habit.swift
//  HabitPing
//
//  Created by Ahmet CILINGIR on 22.09.26.
//

import Foundation

struct Habit {
    let id: UUID
    var name: String
    var emoji: String
    var reminderTime: Date
    var notificationsEnabled: Bool

    init(
        id: UUID = UUID(),
        name: String,
        emoji: String,
        reminderTime: Date,
        notificationsEnabled: Bool
    ) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.reminderTime = reminderTime
        self.notificationsEnabled = notificationsEnabled
    }
}
