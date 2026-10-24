//
//  ContentView.swift
//  Lumen
//
//  Created by Lin Thit Khant on 22/10/2569 BE.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    @State private var session = Session.idle
    
    var body: some View {
        switch session {
        case .idle:
            Button("Start") {
                Task {
                    let end = Date.now.addingTimeInterval(25 * 60)
                    do {
                        let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound])
                        if granted {
                            try await scheduleNotification(at: end)
                        }
                    } catch { }
                    session = .running(end: end)
                }
            }
        case .running(let end):
            TimelineView(.periodic(from: .now, by: 1)) { context in
                let remaining = max(end.timeIntervalSince(context.date), 0)
                let minutes = Int(remaining) / 60
                let seconds = Int(remaining) % 60
                Text(String(format: "%02d:%02d", minutes, seconds))
                    .monospacedDigit()
            }
        }
    }
    
    private func scheduleNotification(at end: Date) async throws {
        let content = UNMutableNotificationContent()
        content.title = "Session ended"
        content.body = "The focus session is over."
        content.sound = .default
        
        let components = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: end
        )
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: "session", content: content, trigger: trigger)
        try await UNUserNotificationCenter.current().add(request)
    }
}

#Preview {
    ContentView()
}
