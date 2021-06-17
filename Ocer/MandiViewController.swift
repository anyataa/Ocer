//
//  MandiViewController.swift
//  Ocer
//
//  Created by Stefan Adisurya on 11/06/21.
//

import UIKit

class MandiViewController: UIViewController, CongratsDelegate {
    
    var center: CGPoint = CGPoint.zero
    var zones: [CGRect] = []
    
    let scene1: UIView = {
        let view = UIView(frame: CGRect(x: 55, y: 700, width: 300, height: 200))
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Mandi2")!)
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 8
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    let scene2: UIView = {
        let view = UIView(frame: CGRect(x: 375, y: 700, width: 300, height: 200))
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Mandi4")!)
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 8
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    let scene3: UIView = {
        let view = UIView(frame: CGRect(x: 695, y: 700, width: 300, height: 200))
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Mandi1")!)
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 8
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    let scene4: UIView = {
        let view = UIView(frame: CGRect(x: 1015, y: 700, width: 300, height: 200))
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Mandi3")!)
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 8
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    let sceneZone1: UIView = {
        let view = UIView(frame: CGRect(x: 55, y: 200, width: 300, height: 200))
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 8
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    let sceneZone2: UIView = {
        let view = UIView(frame: CGRect(x: 375, y: 200, width: 300, height: 200))
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 8
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    let sceneZone3: UIView = {
        let view = UIView(frame: CGRect(x: 695, y: 200, width: 300, height: 200))
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 8
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    let sceneZone4: UIView = {
        let view = UIView(frame: CGRect(x: 1015, y: 200, width: 300, height: 200))
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 8
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    var pos1: CGPoint?
    var pos2: CGPoint?
    var pos3: CGPoint?
    var pos4: CGPoint?
    
    var posZone1: CGPoint?
    var posZone2: CGPoint?
    var posZone3: CGPoint?
    var posZone4: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pos1 = scene1.center
        pos2 = scene2.center
        pos3 = scene3.center
        pos4 = scene4.center
        
        posZone1 = sceneZone1.center
        posZone2 = sceneZone2.center
        posZone3 = sceneZone4.center
        posZone4 = sceneZone4.center
        
        view.addSubview(scene1)
        view.addSubview(scene2)
        view.addSubview(scene3)
        view.addSubview(scene4)
        
        view.addSubview(sceneZone1)
        view.addSubview(sceneZone2)
        view.addSubview(sceneZone3)
        view.addSubview(sceneZone4)
        
        zones.append(sceneZone1.frame)
        zones.append(sceneZone2.frame)
        zones.append(sceneZone3.frame)
        zones.append(sceneZone4.frame)
        
        scene1.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragScene1(_:))))
        scene2.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragScene2(_:))))
        scene3.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragScene3(_:))))
        scene4.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragScene4(_:))))
        
        Setting.addButtonToView(destination: self)
    }
    
    @objc func dragScene1(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            center = scene1.center

        case .changed:
            view.bringSubviewToFront(sender.view!)

            let translation = sender.translation(in: view)
            scene1.center = CGPoint(x: center.x + translation.x, y: center.y + translation.y)

            for zone in zones {
                if (sender.view?.frame != nil) {
                    if (sender.view!.frame.intersects(zone)) {
                        sender.view!.layer.shadowRadius = 15

                        if (zone == sceneZone2.frame) {
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
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseIn]) {
                if (sender.view?.frame != nil) {
                    self.dragEnded(draggableObject: sender, draggableZone: self.sceneZone2)
                }
            }

        default:
            break
        }
    }

    @objc func dragScene2(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            center = scene2.center

        case .changed:
            view.bringSubviewToFront(sender.view!)

            let translation = sender.translation(in: view)
            scene2.center = CGPoint(x: center.x + translation.x, y: center.y + translation.y)

            for zone in zones {
                if (sender.view?.frame != nil) {
                    if (sender.view!.frame.intersects(zone)) {
                        sender.view!.layer.shadowRadius = 15

                        if (zone == sceneZone4.frame) {
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
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseIn]) {
                if (sender.view?.frame != nil) {
                    self.dragEnded(draggableObject: sender, draggableZone: self.sceneZone4)
                }
            }

        default:
            break
        }
    }

    @objc func dragScene3(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            center = scene3.center

        case .changed:
            view.bringSubviewToFront(sender.view!)

            let translation = sender.translation(in: view)
            scene3.center = CGPoint(x: center.x + translation.x, y: center.y + translation.y)

            for zone in zones {
                if (sender.view?.frame != nil) {
                    if (sender.view!.frame.intersects(zone)) {
                        sender.view!.layer.shadowRadius = 15

                        if (zone == sceneZone1.frame) {
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
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseIn]) {
                if (sender.view?.frame != nil) {
                    self.dragEnded(draggableObject: sender, draggableZone: self.sceneZone1)
                }
            }

        default:
            break
        }
    }

    @objc func dragScene4(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            center = scene4.center

        case .changed:
            view.bringSubviewToFront(sender.view!)

            let translation = sender.translation(in: view)
            scene4.center = CGPoint(x: center.x + translation.x, y: center.y + translation.y)

            for zone in zones {
                if (sender.view?.frame != nil) {
                    if (sender.view!.frame.intersects(zone)) {
                        sender.view!.layer.shadowRadius = 15

                        if (zone == sceneZone3.frame) {
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
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseIn]) {
                if (sender.view?.frame != nil) {
                    self.dragEnded(draggableObject: sender, draggableZone: self.sceneZone3)
                }
            }

        default:
            break
        }
    }
    
    func resetGame() {
        Progress.setValue(value: "p2", toKey: "progress2")
        scene1.center = pos1 ?? CGPoint(x: 205, y: 800)
        scene2.center = pos2 ?? CGPoint(x: 525, y: 800)
        scene3.center = pos3 ?? CGPoint(x: 845, y: 800)
        scene4.center = pos4 ?? CGPoint(x: 1165, y: 800)
        sceneZone1.center = posZone1!
        sceneZone2.center = posZone2!
        sceneZone3.center = posZone3!
        sceneZone4.center = posZone4!
    }
    
    func ulangButtonTapped() {
        resetGame()
        self.dismiss(animated: true, completion: nil)
    }
    
    func keluarButtonTapped() {
        self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "toSubMenu", sender: nil)
    }
    
    func lanjutButtonTapped() {
        self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "toSarapan", sender: nil)
    }
    
    func check() {
        if (self.scene1.center == self.sceneZone2.center) && (self.scene2.center == self.sceneZone4.center) && (self.scene3.center == self.sceneZone1.center) && (self.scene4.center == self.sceneZone3.center) {
            Progress.setValue(value: "p3", toKey: "progress3")
            
            UIView.animate(withDuration: 5, animations: {
                self.scene1.frame = CGRect(x: 55, y: 500, width: 300, height: 200)
                self.sceneZone1.frame = CGRect(x: 55, y: 500, width: 300, height: 200)
                
                self.scene2.frame = CGRect(x: 375, y: 500, width: 300, height: 200)
                self.sceneZone2.frame = CGRect(x: 375, y: 500, width: 300, height: 200)
                
                self.scene3.frame = CGRect(x: 695, y: 500, width: 300, height: 200)
                self.sceneZone3.frame = CGRect(x: 695, y: 500, width: 300, height: 200)
                
                self.scene4.frame = CGRect(x: 1015, y: 500, width: 300, height: 200)
                self.sceneZone4.frame = CGRect(x: 1015, y: 500, width: 300, height: 200)
            }, completion: {_ in
                let congratsPage = CongratsPage()
                congratsPage.modalPresentationStyle = .custom
                congratsPage.congratsDelegate = self
                self.present(congratsPage, animated: true, completion: nil)
            })
            
            
        }
    }
    
    func dragEnded(draggableObject: UIPanGestureRecognizer, draggableZone: UIView) {
        if (draggableObject.view!.frame.intersects(draggableZone.frame)) {
            Setting.playSoundEffect(fileName: "ok")
            draggableObject.view!.center = draggableZone.center
        } else {
            Setting.playSoundEffect(fileName: "no")
            if draggableObject.view == scene1 {
                draggableObject.view!.center = CGPoint(x: 205, y: 800)
            } else if draggableObject.view == scene2 {
                draggableObject.view!.center = CGPoint(x: 525, y: 800)
            } else if draggableObject.view == scene3 {
                draggableObject.view!.center = CGPoint(x: 845, y: 800)
            } else {
                draggableObject.view!.center = CGPoint(x: 1165, y: 800)
            }
        }
        
        check()
        
        draggableObject.view!.layer.shadowOpacity = 0
    }
    
}
