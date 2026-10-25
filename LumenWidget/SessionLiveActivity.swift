//
//  SessionLiveActivity.swift
//  Lumen
//
//  Created by Lin Thit Khant on 25/10/2569 BE.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct SessionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: SessionAttributes.self) { context in
            Text(timerInterval: .now...context.attributes.end, countsDown: true)
                .monospacedDigit()
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.center) {
                    Text(timerInterval: .now...context.attributes.end, countsDown: true)
                        .monospacedDigit()
                }
            } compactLeading: {
                Text("Lumen")
            } compactTrailing: {
                Text(timerInterval: .now...context.attributes.end, countsDown: true)
                    .monospacedDigit()
            } minimal: {
                Text(timerInterval: .now...context.attributes.end, countsDown: true)
                    .monospacedDigit()
            }
        }

    }
}
