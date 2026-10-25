//
//  StartSessionIntent.swift
//  Lumen
//
//  Created by Lin Thit Khant on 25/10/2569 BE.
//

import AppIntents

struct StartSessionIntent: AppIntent {
    static let title: LocalizedStringResource = "Start Session"
    static let openAppWhenRun = true
    
    func perform() async throws -> some IntentResult {
        await SessionModel.shared.start()
        return .result()
    }
}

struct LumenShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: StartSessionIntent(),
            phrases: ["Start \(.applicationName)"],
            shortTitle: "Start Session",
            systemImageName: "timer"
        )
    }
}
