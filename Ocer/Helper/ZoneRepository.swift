//
//  ZoneRepository.swift
//  Ocer
//
//  Created by Stefan Adisurya on 26/06/21.
//

import UIKit

class ZoneRepository {
    
    static func add(subViewName: UIView..., to: UIView) {
        for name in subViewName {
            to.addSubview(name)
        }
    }
    
    static func matchCenter(of: UIView..., with: UIView...) {
        for i in 0..<of.count {
            of[i].center = with[i].center
        }
    }
    
    static func moveScene(scene: UIView, sceneZone: UIView, correctZone: UIView, draggedZone: UIView, x: CGFloat, x2: CGFloat) {
        scene.frame = CGRect(x: x, y: 500, width: 300, height: 200)
        sceneZone.frame = CGRect(x: x2, y: 500, width: 300, height: 200)
        correctZone.frame = sceneZone.frame
        draggedZone.frame = scene.frame
    }
    
}
