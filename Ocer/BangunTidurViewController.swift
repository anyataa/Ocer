//
//  BangunTidurViewController.swift
//  Ocer
//
//  Created by Anya Akbar on 09/06/21.
//

import UIKit

class BangunTidurViewController: UIViewController {

    let backgroundImage =  UIImage(named: "kamar")
    var center: CGPoint = CGPoint.zero
    var zones: [CGRect] = []
    
    func setBackgroundImage() {
        let backgroundPlaceHolder = UIImageView(image: backgroundImage)
        backgroundPlaceHolder.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        view.addSubview(backgroundPlaceHolder)
    }
    let pillow: UIView = {
        let view = UIView(frame: CGRect(x: 500, y: 500, width: 188, height: 110))
        view.backgroundColor = .yellow
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 10
        view.layer.cornerRadius = 20
        return view
    }()
    
    let pillow2: UIView = {
        let view = UIView(frame: CGRect(x: 200, y: 800, width: 188, height: 110))
        view.backgroundColor = .yellow
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 10
        view.layer.cornerRadius = 20
        return view
    }()
    
    let pillow3: UIView = {
        let view = UIView(frame: CGRect(x: 730, y: 380, width: 130, height: 250))
        view.layer.cornerRadius = 50
        view.backgroundColor = .yellow
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 10
        return view
    }()
    
    let rug: UIView = {
        let view = UIView(frame: CGRect(x: 140, y: 700, width: 338, height: 188))
        view.backgroundColor = .green
        view.layer.cornerRadius = 94
        view.layer.borderWidth = 10
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    let pillowZone: UIView = {
        let view = UIView(frame: CGRect(x: 305, y: 260, width: 188, height: 110))
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 10
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    let pillowZone2: UIView = {
        let view = UIView(frame: CGRect(x: 530, y: 260, width: 188, height: 110))
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 10
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    let pillowZone3: UIView = {
        let view = UIView(frame: CGRect(x: 430, y: 380, width: 130, height: 250))
        view.layer.cornerRadius = 50
        view.backgroundColor = .white
        view.layer.borderWidth = 10
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    
    let rugZone: UIView = {
        let view = UIView(frame: CGRect(x: 840, y: 700, width: 338, height: 188))
        view.backgroundColor = .white
        view.layer.cornerRadius = 94
        view.layer.borderWidth = 10
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        //set background image
        setBackgroundImage()

        //setup view
        view.addSubview(pillow)
        view.addSubview(pillow2)
        view.addSubview(pillow3)
        view.addSubview(rug)
        view.addSubview(pillowZone)
        view.addSubview(pillowZone2)
        view.addSubview(pillowZone3)
        view.addSubview(rugZone)
        
        
        //add to zones to check intersection
        zones.append(pillowZone.frame)
        zones.append(pillowZone2.frame)
        zones.append(rugZone.frame)
        
        //add pan gesture
//        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(drag(_:)))
        pillow.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragPillow(_ :))))
        pillow2.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragPillow2(_:))))
        pillow3.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragPillow3(_:))))
        rug.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragRug(_:))))
    }

    @objc private func dragPillow(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            //get object position on drag start
            center = pillow.center
        
        case .changed:
            //bring dragged object to front (topmost z index within the same view hierarchy)
            view.bringSubviewToFront(sender.view!)
            
            //update object position while dragging
            let translation = sender.translation(in: view)
            pillow.center = CGPoint(x: center.x + translation.x,
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
                        if(zone == pillowZone.frame || zone == pillowZone2.frame) {
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
                    self.dragEnded(draggableObject: sender, draggableZone: self.pillowZone, draggableZone2: self.pillowZone2)
                   
                 
                }
            }
        default:
            break
        }
    }
    
//    Pillow 2
    @objc private func dragPillow2(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            //get object position on drag start
            center = pillow2.center
        
        case .changed:
            //bring dragged object to front (topmost z index within the same view hierarchy)
            view.bringSubviewToFront(sender.view!)
            
            //update object position while dragging
            let translation = sender.translation(in: view)
            pillow2.center = CGPoint(x: center.x + translation.x,
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
                        if(zone == pillowZone.frame || zone == pillowZone2.frame) {
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
                    self.dragEnded(draggableObject: sender, draggableZone: self.pillowZone, draggableZone2: self.pillowZone2)
                   
                 
                }
            }
        default:
            break
        }
    }
    
//    pillow3
    @objc private func dragPillow3(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            //get object position on drag start
            center = pillow3.center
        
        case .changed:
            //bring dragged object to front (topmost z index within the same view hierarchy)
            view.bringSubviewToFront(sender.view!)
            
            //update object position while dragging
            let translation = sender.translation(in: view)
            pillow3.center = CGPoint(x: center.x + translation.x,
                                          y: center.y + translation.y)
            
            //check if object intersects with drop zones
            //TODO only 1 drop zone is correct
            //TODO is looping necessary?
            for zone in zones {
                if (sender.view?.frame != nil) {
                    if (sender.view!.frame.intersects(zone))  {
                        //turn on shadow if dragged object is on top of drop zone
                        //TODO green shadow for correct zone, red for incorrect zone
                        sender.view!.layer.shadowRadius = 20
                        if(zone == pillowZone3.frame) {
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
                    self.dragEnded(draggableObject: sender, draggableZone: self.pillowZone3, draggableZone2: self.pillowZone3)
                   
                 
                }
            }
        default:
            break
        }
    }
//    rug
    
    @objc private func dragRug(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            //get object position on drag start
            center = rug.center
        
        case .changed:
            //bring dragged object to front (topmost z index within the same view hierarchy)
            view.bringSubviewToFront(sender.view!)
            
            //update object position while dragging
            let translation = sender.translation(in: view)
            rug.center = CGPoint(x: center.x + translation.x,
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
                        if(zone == rugZone.frame) {
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
                    self.dragEnded(draggableObject: sender, draggableZone: self.rugZone, draggableZone2: self.rugZone)
                   
                 
                }
            }
        default:
            break
        }
    }
    
    
    
    func dragEnded(draggableObject: UIPanGestureRecognizer, draggableZone: UIView , draggableZone2: UIView) {
        
        if (draggableObject.view!.frame.intersects(draggableZone.frame)){
            draggableObject.view!.center = draggableZone.center
        }
        else if (draggableObject.view!.frame.intersects(draggableZone2.frame)) {
            draggableObject.view!.center = draggableZone2.center
        }
            else {
                draggableObject.view!.center = CGPoint(x: Int.random(in: 30...900), y: Int.random(in: 50...600))
        }
        //turn off shadow
        draggableObject.view!.layer.shadowOpacity = 0
    }

}
