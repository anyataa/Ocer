//
//  KeSekolahViewController.swift
//  Ocer
//
//  Created by Antony Susanto on 11/06/21.
//

import UIKit

class KeSekolahViewController: UIViewController {

    @IBOutlet weak var arrowLeft: UIImageView!
    @IBOutlet weak var arrowDown: UIImageView!
    @IBOutlet weak var arrowRight: UIImageView!
    @IBOutlet weak var arrowUp: UIImageView!
    
    @IBOutlet weak var zone1: UIImageView!
    @IBOutlet weak var zone2: UIImageView!
    @IBOutlet weak var zone3: UIImageView!
    @IBOutlet weak var zone4: UIImageView!
    @IBOutlet weak var zone5: UIImageView!
    @IBOutlet weak var zone6: UIImageView!
    @IBOutlet weak var zone7: UIImageView!
    
    @IBOutlet weak var car: UIImageView!
    
    var zones: [UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrowUp.isUserInteractionEnabled = true
        let up = MyGesture(target: self, action: #selector(drag(_:)))
        up.direction = .up
        up.center = arrowUp.center
        arrowUp.addGestureRecognizer(up)
        
        arrowRight.isUserInteractionEnabled = true
        let right = MyGesture(target: self, action: #selector(drag(_:)))
        right.direction = .right
        right.center = arrowRight.center
        arrowRight.addGestureRecognizer(right)
        
        arrowDown.isUserInteractionEnabled = true
        let down = MyGesture(target: self, action: #selector(drag(_:)))
        down.direction = .down
        down.center = arrowDown.center
        arrowDown.addGestureRecognizer(down)
        
        arrowLeft.isUserInteractionEnabled = true
        let left = MyGesture(target: self, action: #selector(drag(_:)))
        left.direction = .left
        left.center = arrowLeft.center
        arrowLeft.addGestureRecognizer(left)
        
        zones.append(zone1)
        zones.append(zone2)
        zones.append(zone3)
        zones.append(zone4)
        zones.append(zone5)
        zones.append(zone6)
        zones.append(zone7)
    }
    
    @IBAction func playButton(_ sender: Any) {
        self.view.bringSubviewToFront(self.car)
        
        //animation with keyframes
        UIView.animateKeyframes(withDuration: 5.0, delay: 0, options: [.calculationModeLinear], animations: {
            for (index,zone) in self.zones.enumerated() {
                //move car
                UIView.addKeyframe(withRelativeStartTime: Double(index)/Double(self.zones.count), relativeDuration: 0.1, animations: {
                        self.car.center = zone.center
                    })
                
                //rotate car
                //Degrees    Radians (exact)    Radians (approx)
                //90°             π/2                 1.571
                //180°            π                   3.142
                //270°            3π/2                4.712
                //360°            2π                  6.283
                //self.zones[index+1].center = destination
                if (index != self.zones.count-1){
                    if (self.zones[index+1].center.x > zone.center.x){
                        //turn right = 0 degree
                        UIView.addKeyframe(withRelativeStartTime: Double(index+1)/Double(self.zones.count), relativeDuration: 0.03, animations: {
                            self.car.transform = CGAffineTransform(rotationAngle: 0)
                            })
                        
                    } else if (self.zones[index+1].center.x < zone.center.x){
                        //turn left = 180 degree
                        UIView.addKeyframe(withRelativeStartTime: Double(index+1)/Double(self.zones.count), relativeDuration: 0.03, animations: {
                            self.car.transform = CGAffineTransform(rotationAngle: 3.142)
                            })
                    }  else if (self.zones[index+1].center.y > zone.center.y){
                        //turn down = 90 degree
                        UIView.addKeyframe(withRelativeStartTime: Double(index+1)/Double(self.zones.count), relativeDuration: 0.03, animations: {
                            self.car.transform = CGAffineTransform(rotationAngle: 1.571)
                            })
                    } else if (self.zones[index+1].center.y < zone.center.y){
                        //turn up = 270 degree
                        UIView.addKeyframe(withRelativeStartTime: Double(index+1)/Double(self.zones.count), relativeDuration: 0.03, animations: {
                            self.car.transform = CGAffineTransform(rotationAngle: 4.712)
                            })
                    }
                }
            }
        }, completion:{_ in
            //TODO end the game
            print("congratulation")
        })
    }
    
    @objc private func drag(_ sender: MyGesture) {
        
        if let sview = sender.view, let scenter = sender.center, let sdirection = sender.direction {
            switch sender.state {
                case .began:
                    print("direction: \(sdirection)")
                    
                    //bring dragged object to front (topmost z index within the same view hierarchy)
                    view.bringSubviewToFront(sview)
                    
                case .changed:
                    //update object position while being dragged
                    let translation = sender.translation(in: view)
                    sview.center = CGPoint(x: scenter.x + translation.x, y: scenter.y + translation.y)
                    
                    //check if object intersects with drop zones
                    //TODO only 1 arrow per drop zone is correct
                    for (index,zone) in self.zones.enumerated() {
                        if (index == self.zones.count-1) {
                            break
                        }
                        
                        if (sview.frame.intersects(zone.frame))  {
                            //turn on shadow if dragged object is on top of drop zone
                            //TODO green shadow for correct zone, red for incorrect zone
                            sview.layer.shadowRadius = 15
                            //if(zone == dropZone.frame) {
                                sview.layer.shadowColor = UIColor.green.cgColor
                            //} else {
                            //    sender.view!.layer.shadowColor = UIColor.red.cgColor
                            //}
                            sview.layer.shadowOpacity = 1
                        break
                        } else {
                            sview.layer.shadowOpacity = 0
                        }
                        
                    }
                    
                case .ended:
                    //animation
                    //UIView.animate(withDuration: 0, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseIn]) {
                    //TODO snap to correct zone, otherwise reset draggableObject position
                    //     get arrow direction and compare to what direction the zone would accept
                    //     let dir = sender.direction!.rawValue
                        
                    //add arrow image to zone
                    for (index,zone) in self.zones.enumerated() {
                        if (index == self.zones.count-1) {
                            break
                        }
                        if (sview.frame.intersects(zone.frame)){
                            if let i = sview as? UIImageView {
                                zone.image = i.image
                                break
                            }
                        }
                        }
                    //} completion: { _ in
                        //reset arrow position
                        sview.center = scenter
                        sview.layer.shadowOpacity = 0
                    //}
                default:
                    break
            }
        } else {
            print("something went wrong")
        }
    }
}

enum Direction:String {
    case up = "up", left = "left" , down = "down" , right = "right"
}

class MyGesture: UIPanGestureRecognizer {
    var direction: Direction?
    var center:CGPoint?
}
