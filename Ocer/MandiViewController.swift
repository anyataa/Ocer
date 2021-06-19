//
//  MandiViewController.swift
//  Ocer
//
//  Created by Stefan Adisurya on 11/06/21.
//

import UIKit

class MandiViewController: UIViewController, CongratsDelegate {
    
    let GAME_ID: String = "toilet"
    
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
    
    let correctZone1: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 50)))
        
        return view
    }()
    
    let correctZone2: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 50)))
        
        return view
    }()
    
    let correctZone3: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 50)))
        
        return view
    }()
    
    let correctZone4: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 50)))
        
        return view
    }()
    
    let draggedZone1: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 50)))
        
        return view
    }()
    
    let draggedZone2: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 50)))
        
        return view
    }()
    
    let draggedZone3: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 50)))
        
        return view
    }()
    
    let draggedZone4: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 50)))
        
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
        posZone3 = sceneZone3.center
        posZone4 = sceneZone4.center
        
        draggedZone1.center = scene1.center
        draggedZone2.center = scene2.center
        draggedZone3.center = scene3.center
        draggedZone4.center = scene4.center
        
        view.addSubview(draggedZone1)
        view.addSubview(draggedZone2)
        view.addSubview(draggedZone3)
        view.addSubview(draggedZone4)
        
        view.addSubview(scene1)
        view.addSubview(scene2)
        view.addSubview(scene3)
        view.addSubview(scene4)
        
        view.addSubview(sceneZone1)
        view.addSubview(sceneZone2)
        view.addSubview(sceneZone3)
        view.addSubview(sceneZone4)
        
        correctZone2.center = sceneZone2.center
        correctZone4.center = sceneZone4.center
        correctZone1.center = sceneZone1.center
        correctZone3.center = sceneZone3.center
        
        view.addSubview(correctZone1)
        view.addSubview(correctZone2)
        view.addSubview(correctZone3)
        view.addSubview(correctZone4)
        
        zones.append(correctZone1.frame)
        zones.append(correctZone2.frame)
        zones.append(correctZone3.frame)
        zones.append(correctZone4.frame)
        
        scene1.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragScene1(_:))))
        scene2.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragScene2(_:))))
        scene3.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragScene3(_:))))
        scene4.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragScene4(_:))))
        
        Setting.addButtonToView(destination: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Instruction.showInstructionPage(self, gameId: GAME_ID)
    }
    
    @objc func dragScene1(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            center = draggedZone1.center

        case .changed:
            view.bringSubviewToFront(sender.view!)

            let translation = sender.translation(in: view)
            scene1.center = CGPoint(x: center.x + translation.x, y: center.y + translation.y)
            draggedZone1.center = scene1.center

            for zone in zones {
                if (sender.view?.frame != nil) {
                    if (draggedZone1.frame.intersects(zone)) {
                        sender.view!.layer.shadowRadius = 15

                        if (zone == correctZone2.frame) {
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
                    self.dragEnded(draggableObject: self.draggedZone1, draggableZone: self.correctZone2)
                }
            }

        default:
            break
        }
    }

    @objc func dragScene2(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            center = draggedZone2.center

        case .changed:
            view.bringSubviewToFront(sender.view!)

            let translation = sender.translation(in: view)
            scene2.center = CGPoint(x: center.x + translation.x, y: center.y + translation.y)
            draggedZone2.center = scene2.center

            for zone in zones {
                if (sender.view?.frame != nil) {
                    if (draggedZone2.frame.intersects(zone)) {
                        sender.view!.layer.shadowRadius = 15

                        if (zone == correctZone4.frame) {
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
                    self.dragEnded(draggableObject: self.draggedZone2, draggableZone: self.correctZone4)
                }
            }

        default:
            break
        }
    }

    @objc func dragScene3(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            center = draggedZone3.center

        case .changed:
            view.bringSubviewToFront(sender.view!)

            let translation = sender.translation(in: view)
            scene3.center = CGPoint(x: center.x + translation.x, y: center.y + translation.y)
            draggedZone3.center = scene3.center

            for zone in zones {
                if (sender.view?.frame != nil) {
                    if (draggedZone3.frame.intersects(zone)) {
                        sender.view!.layer.shadowRadius = 15

                        if (zone == correctZone1.frame) {
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
                    self.dragEnded(draggableObject: self.draggedZone3, draggableZone: self.correctZone1)
                }
            }

        default:
            break
        }
    }

    @objc func dragScene4(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            center = draggedZone4.center

        case .changed:
            view.bringSubviewToFront(sender.view!)

            let translation = sender.translation(in: view)
            scene4.center = CGPoint(x: center.x + translation.x, y: center.y + translation.y)
            draggedZone4.center = scene4.center

            for zone in zones {
                if (sender.view?.frame != nil) {
                    if (draggedZone4.frame.intersects(zone)) {
                        sender.view!.layer.shadowRadius = 15

                        if (zone == correctZone3.frame) {
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
                    self.dragEnded(draggableObject: self.draggedZone4, draggableZone: self.correctZone3)
                }
            }

        default:
            break
        }
    }
    
    func ulangButtonTapped() {
        self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "toMandi", sender: nil)
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
                self.scene1.frame = CGRect(x: 375, y: 500, width: 300, height: 200)
                self.sceneZone1.frame = CGRect(x: 55, y: 500, width: 300, height: 200)
                self.correctZone1.frame = self.sceneZone1.frame
                self.draggedZone1.frame = self.scene1.frame

                self.scene2.frame = CGRect(x: 1015, y: 500, width: 300, height: 200)
                self.sceneZone2.frame = CGRect(x: 375, y: 500, width: 300, height: 200)
                self.correctZone2.frame = self.sceneZone2.frame
                self.draggedZone2.frame = self.scene2.frame

                self.scene3.frame = CGRect(x: 55, y: 500, width: 300, height: 200)
                self.sceneZone3.frame = CGRect(x: 695, y: 500, width: 300, height: 200)
                self.correctZone3.frame = self.sceneZone3.frame
                self.draggedZone3.frame = self.scene3.frame

                self.scene4.frame = CGRect(x: 695, y: 500, width: 300, height: 200)
                self.sceneZone4.frame = CGRect(x: 1015, y: 500, width: 300, height: 200)
                self.correctZone4.frame = self.sceneZone4.frame
                self.draggedZone4.frame = self.scene4.frame
            }, completion: {_ in
                let congratsPage = CongratsPage()
                congratsPage.modalPresentationStyle = .custom
                congratsPage.congratsDelegate = self
                self.present(congratsPage, animated: true, completion: nil)
            })
            
        }
    }
    
    func dragEnded(draggableObject: UIView, draggableZone: UIView) {
        if (draggableObject.frame.intersects(draggableZone.frame)) {
            Setting.playSoundEffect(fileName: "ok")
            
            if draggableObject == draggedZone1 {
                draggableObject.center = draggableZone.center
                scene1.center = draggableObject.center
            } else if draggableObject == draggedZone2 {
                draggableObject.center = draggableZone.center
                scene2.center = draggableObject.center
            } else if draggableObject == draggedZone3 {
                draggableObject.center = draggableZone.center
                scene3.center = draggableObject.center
            } else {
                draggableObject.center = draggableZone.center
                scene4.center = draggableObject.center
            }
            
        } else {
            Setting.playSoundEffect(fileName: "no")
            
            if draggableObject == draggedZone1 {
                draggableObject.center = CGPoint(x: 205, y: 800)
                draggedZone1.center = draggableObject.center
                scene1.center = draggableObject.center
            } else if draggableObject == draggedZone2 {
                draggableObject.center = CGPoint(x: 525, y: 800)
                draggedZone2.center = draggableObject.center
                scene2.center = draggableObject.center
            } else if draggableObject == draggedZone3 {
                draggableObject.center = CGPoint(x: 845, y: 800)
                draggedZone3.center = draggableObject.center
                scene3.center = draggableObject.center
            } else {
                draggableObject.center = CGPoint(x: 1165, y: 800)
                draggedZone4.center = draggableObject.center
                scene4.center = draggableObject.center
            }
        }
        
        check()
        
        scene1.layer.shadowOpacity = 0
        scene2.layer.shadowOpacity = 0
        scene3.layer.shadowOpacity = 0
        scene4.layer.shadowOpacity = 0
        draggableObject.layer.shadowOpacity = 0
    }
    
}
