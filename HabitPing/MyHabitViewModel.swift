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
    
    init(){
        
            createSampleHabits()
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
                )
            ]
        }
}
