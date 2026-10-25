//
//  SessionAttributes.swift
//  Lumen
//
//  Created by Lin Thit Khant on 25/10/2569 BE.
//

import ActivityKit
import Foundation

nonisolated struct SessionAttributes: ActivityAttributes {
    struct ContentState: Codable, Hashable {}
    var end: Date
}
