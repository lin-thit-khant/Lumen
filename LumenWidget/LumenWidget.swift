//
//  LumenWidget.swift
//  LumenWidget
//
//  Created by Lin Thit Khant on 24/10/2569 BE.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), end: .now)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), end: .now)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let end = SessionStore.end()
        let entry = SimpleEntry(date: .now, end: end)
        let refresh = end ?? Date.now.addingTimeInterval(60 * 60)
        completion(Timeline(entries: [entry], policy: .after(refresh)))
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let end: Date?
}



struct LumenWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        if let end = entry.end, end > .now {
            Text(timerInterval: .now...end, countsDown: true)
                .monospacedDigit()
        } else {
            Text("Idle")
        }
    }
}

struct LumenWidget: Widget {
    let kind: String = "LumenWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                LumenWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                LumenWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Lumen")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    LumenWidget()
} timeline: {
    SimpleEntry(date: .now, end: .now)
}
