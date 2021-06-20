//
//  MenuSeederStaticDataStore.swift
//  Ocer
//
//  Created by Stefan Adisurya on 20/06/21.
//

import Foundation

class SeederStaticDataStore {
    
    static func generateStories() -> [Story] {
        let story1 = Story(storyName: "Berangkat Sekolah", storyImage: "Story1")
        let story2 = Story(storyName: "Membantu Ibu", storyImage: "Story2")
        let story3 = Story(storyName: "Berternak", storyImage: "Story3")
        
        return [story1, story2, story3]
    }
    
}
