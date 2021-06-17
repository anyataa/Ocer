//
//  UserDefaultsRepository.swift
//  Ocer
//
//  Created by Stefan Adisurya on 16/06/21.
//

import Foundation

class Progress {
    static let shared = Progress()
    let defaults = UserDefaults.standard
    
    static var progresses = [
        "p1": true,
        "p2": false,
        "p3": false,
        "p4": false
    ]
    
    private static func generate() {
        shared.defaults.set(progresses["p1"], forKey: "progress1")
        shared.defaults.set(progresses["p2"], forKey: "progress2")
        shared.defaults.set(progresses["p3"], forKey: "progress3")
        shared.defaults.set(progresses["p4"], forKey: "progress4")
    }
    
    private static func changedValue(value: String, key: String) {
        progresses[value] = true
        shared.defaults.set(progresses[value], forKey: key)
    }
    
    public static func setValue(value: String, toKey: String) {
//        let dictionary = self.shared.defaults.dictionaryRepresentation()
//        dictionary.keys.forEach { key in
//            shared.defaults.removeObject(forKey: key)
//        }
//        generate()
        changedValue(value: value, key: toKey)
    }
    
    public static func reset() {
        let dictionary = self.shared.defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            shared.defaults.removeObject(forKey: key)
        }
    }
}
