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
    
    private static func generate() {
        shared.defaults.set(true, forKey: "progress1")
        shared.defaults.set(false, forKey: "progress2")
        shared.defaults.set(false, forKey: "progress3")
        shared.defaults.set(false, forKey: "progress4")
    }
    
    private static func changedValue(_ key: String) {
        shared.defaults.set(true, forKey: key)
    }
    
    public static func setValue(of value: String) {
        let dictionary = self.shared.defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            shared.defaults.removeObject(forKey: key)
        }
        generate()
        changedValue(value)
    }
    
    public static func reset() {
        let dictionary = self.shared.defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            shared.defaults.removeObject(forKey: key)
        }
    }
}
