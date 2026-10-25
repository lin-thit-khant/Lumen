//
//  ContentView.swift
//  Lumen
//
//  Created by Lin Thit Khant on 22/10/2569 BE.
//

import SwiftUI

struct ContentView: View {
    
    @State private var model = SessionModel.shared
    
    var body: some View {
        switch model.session {
        case .idle:
            Button("Start") {
                Task { await model.start() }
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
    
}

#Preview {
    ContentView()
}
