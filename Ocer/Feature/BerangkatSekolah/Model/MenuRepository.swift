//
//  MenuRepository.swift
//  Ocer
//
//  Created by Stefan Adisurya on 20/06/21.
//

import Foundation

class MenuRepository {
    
    var staticDataStore: SeederStaticDataStore
    
    static let shared = MenuRepository(staticDataStore: SeederStaticDataStore())
    
    private init(staticDataStore: SeederStaticDataStore) {
        self.staticDataStore = staticDataStore
    }
    
}
