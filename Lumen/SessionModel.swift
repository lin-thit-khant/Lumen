//
//  SessionModel.swift
//  Lumen
//
//  Created by Lin Thit Khant on 25/10/2569 BE.
//

import ActivityKit
import WidgetKit
import Observation
import UserNotifications

@MainActor
@Observable
final class SessionModel {
    static let shared = SessionModel()
    var session = Session.idle
    
    func start() async {
        let end = Date.now.addingTimeInterval(25 * 60)
        do {
            let granted = try await UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .sound])
            if granted {
                try await scheduleNotification(at: end)
            }
        } catch { }
        session = .running(end: end)
        SessionStore.save(end: end)
        WidgetCenter.shared.reloadAllTimelines()
        await startLiveActivity(end: end)
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
    
    private func startLiveActivity(end: Date) async {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else { return }
        for activity in Activity<SessionAttributes>.activities {
            await activity.end(nil, dismissalPolicy: .immediate)
        }
        let attributes = SessionAttributes(end: end)
        let content = ActivityContent(state: SessionAttributes.ContentState(), staleDate: end)
        _ = try? Activity.request(attributes: attributes, content: content)
    }
}
