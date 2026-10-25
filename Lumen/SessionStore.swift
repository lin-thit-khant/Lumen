//
//  SessionStore.swift
//  Lumen
//
//  Created by Lin Thit Khant on 25/10/2569 BE.
//

import Foundation

struct SessionStore {
    static let suiteName = "group.me.khant.linthit.Lumen"
    static let endKey = "sessionEnd"
    
    static func save(end: Date) {
        UserDefaults(suiteName: suiteName)?.set(end, forKey: endKey)
    }
    
    static func end() -> Date? {
        UserDefaults(suiteName: suiteName)?.object(forKey: endKey) as? Date
    }
}
