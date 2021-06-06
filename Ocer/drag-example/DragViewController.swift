//
//  DragViewController.swift
//  Ocer
//
//  Created by Antony Susanto on 06/06/21.
//

import UIKit

class DragViewController: UIViewController {
    
    var center: CGPoint = CGPoint.zero
    var zones: [CGRect] = []
    
    let draggableObject: UIView = {
        let view = UIView(frame: CGRect(x: 500, y: 500, width: 100, height: 100))
        view.backgroundColor = .blue
        return view
    }()
    
    let dropZone: UIView = {
        let view = UIView(frame: CGRect(x: 300, y: 300, width: 110, height: 110))
        view.backgroundColor = .black
        return view
    }()
    
    let dropZone2: UIView = {
        let view = UIView(frame: CGRect(x: 800, y: 600, width: 110, height: 110))
        view.backgroundColor = .black
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        //setup view
        view.addSubview(draggableObject)
        view.addSubview(dropZone)
        view.addSubview(dropZone2)
        
        //add to zones to check intersection
        zones.append(dropZone.frame)
        zones.append(dropZone2.frame)
        
        //add pan gesture
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(drag(_:)))
        draggableObject.addGestureRecognizer(panGestureRecognizer)
    }

    @objc private func drag(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            //get object position on drag start
            center = draggableObject.center
        
        case .changed:
            //bring dragged object to front (topmost z index within the same view hierarchy)
            view.bringSubviewToFront(sender.view!)
            
            //update object position while dragging
            let translation = sender.translation(in: view)
            draggableObject.center = CGPoint(x: center.x + translation.x,
                                          y: center.y + translation.y)
            
            //check if object intersects with drop zones
            //TODO only 1 drop zone is correct
            //TODO is looping necessary?
            for zone in zones {
                if (sender.view?.frame != nil) {
                    if (sender.view!.frame.intersects(zone))  {
                        //turn on shadow if dragged object is on top of drop zone
                        //TODO green shadow for correct zone, red for incorrect zone
                        sender.view!.layer.shadowRadius = 15
                        if(zone == dropZone.frame) {
                            sender.view!.layer.shadowColor = UIColor.green.cgColor
                        } else {
                            sender.view!.layer.shadowColor = UIColor.red.cgColor
                        }
                        sender.view!.layer.shadowOpacity = 1
                    break
                } else {
                    sender.view!.layer.shadowOpacity = 0
                }
                }
            }
            
        case .ended:
            //snap animation
            //TODO check UISnapBehavior
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseIn]) {
                if (sender.view?.frame != nil) {
                    //TODO snap to correct zone, otherwise reset draggableObject position
                    if (sender.view!.frame.intersects(self.dropZone.frame)){
                        sender.view!.center = self.dropZone.center
                    } else {
                        sender.view!.center = self.view.center
                    }
                    //turn off shadow
                    sender.view!.layer.shadowOpacity = 0
                }
            }
        default:
            break
        }
    }
}
