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
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var hintButton: UIButton!
    @IBOutlet weak var hand: UIImageView!
    
    lazy var scene1: UIView = {
        let view = UIView(frame: CGRect(x: 55, y: 700, width: 300, height: 200))
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Mandi2")!)
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 8
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    lazy var scene2: UIView = {
        let view = UIView(frame: CGRect(x: 375, y: 700, width: 300, height: 200))
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Mandi4")!)
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 8
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    lazy var scene3: UIView = {
        let view = UIView(frame: CGRect(x: 695, y: 700, width: 300, height: 200))
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Mandi1")!)
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 8
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    lazy var scene4: UIView = {
        let view = UIView(frame: CGRect(x: 1015, y: 700, width: 300, height: 200))
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Mandi3")!)
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 8
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    lazy var sceneZone1: UIView = {
        let view = UIView(frame: CGRect(x: 55, y: 200, width: 300, height: 200))
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 8
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    lazy var sceneZone2: UIView = {
        let view = UIView(frame: CGRect(x: 375, y: 200, width: 300, height: 200))
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 8
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    lazy var sceneZone3: UIView = {
        let view = UIView(frame: CGRect(x: 695, y: 200, width: 300, height: 200))
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 8
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    lazy var sceneZone4: UIView = {
        let view = UIView(frame: CGRect(x: 1015, y: 200, width: 300, height: 200))
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 8
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    lazy var correctZone1: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 50)))
        
        return view
    }()
    
    lazy var correctZone2: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 50)))
        
        return view
    }()
    
    lazy var correctZone3: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 50)))
        
        return view
    }()
    
    lazy var correctZone4: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 50)))
        
        return view
    }()
    
    lazy var draggedZone1: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 50)))
        
        return view
    }()
    
    lazy var draggedZone2: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 50)))
        
        return view
    }()
    
    lazy var draggedZone3: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 50)))
        
        return view
    }()
    
    lazy var draggedZone4: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 50)))
        
        return view
    }()
    
    private var pos1: CGPoint?
    private var pos2: CGPoint?
    private var pos3: CGPoint?
    private var pos4: CGPoint?
    
    private var posZone1: CGPoint?
    private var posZone2: CGPoint?
    private var posZone3: CGPoint?
    private var posZone4: CGPoint?
    
    var initialHand: CGPoint = .zero
    var animationCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        
        scene1.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragScene1(_:))))
        scene2.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragScene2(_:))))
        scene3.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragScene3(_:))))
        scene4.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragScene4(_:))))
        
        Setting.addButtonToView(destination: self)
        view.bringSubviewToFront(backButton)
        view.bringSubviewToFront(hintButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Instruction.showInstructionPage(self, gameId: GAME_ID)
    }
    
    @IBAction func playHint(_ sender: Any) {
        hand.isHidden = false
        view.bringSubviewToFront(hand)
        animationCount = 0
        animateHand()
    }
    
    func animateHand(){
        if self.animationCount < 3 {
            self.animationCount += 1
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1,delay: 0.5) {
                    self.hand.center = self.sceneZone2.center
                } completion: { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.hand.center = self.initialHand
                        self.animateHand()
                    }
                }
            }
        } else {
            hand.isHidden = true
        }
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
                        DispatchQueue.main.async {
                            sender.view!.layer.shadowRadius = 15

                            if (zone == self.correctZone2.frame) {
                                sender.view!.layer.shadowColor = UIColor.green.cgColor
                            } else {
                                sender.view!.layer.shadowColor = UIColor.red.cgColor
                            }
                            sender.view!.layer.shadowOpacity = 1
                        }
                        break
                    } else {
                        DispatchQueue.main.async {
                            sender.view!.layer.shadowOpacity = 0
                        }
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

extension MandiViewController {
    
    func initialSetup() {
        setBackgroundImage()
        setUpPosition()
        setUpView()
        appendToZones()
    }
    
    func setBackgroundImage() {
        let backgroundPlaceHolder = UIImageView(image: UIImage(named: "BackgroundMandi"))
        backgroundPlaceHolder.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        view.addSubview(backgroundPlaceHolder)
    }
    
    func setUpPosition() {
        initialHand = scene1.center
        
        pos1 = scene1.center
        pos2 = scene2.center
        pos3 = scene3.center
        pos4 = scene4.center
        
        posZone1 = sceneZone1.center
        posZone2 = sceneZone2.center
        posZone3 = sceneZone3.center
        posZone4 = sceneZone4.center
    }
    
    func setUpView() {
        ZoneRepository.matchCenter(of: draggedZone1, draggedZone2, draggedZone3, draggedZone4, with: scene1, scene2, scene3, scene4)
        ZoneRepository.add(subViewName: draggedZone1, draggedZone2, draggedZone3, draggedZone4, scene1, scene2, scene3, scene4, sceneZone1, sceneZone2, sceneZone3, sceneZone4, to: view)
        ZoneRepository.matchCenter(of: correctZone2, correctZone4, correctZone1, correctZone3, with: sceneZone2, sceneZone4, sceneZone1, sceneZone3)
        ZoneRepository.add(subViewName: correctZone1, correctZone2, correctZone3, correctZone4, to: view)
    }
    
    func appendToZones() {
        zones.append(correctZone1.frame)
        zones.append(correctZone2.frame)
        zones.append(correctZone3.frame)
        zones.append(correctZone4.frame)
    }
    
}

extension MandiViewController {
    
    func isCheckingTrue() -> Bool {
        if (self.scene1.center == self.sceneZone2.center) && (self.scene2.center == self.sceneZone4.center) && (self.scene3.center == self.sceneZone1.center) && (self.scene4.center == self.sceneZone3.center) {
            return true
        } else {
            return false
        }
    }
    
    func check() {
        if (isCheckingTrue()) {
            Progress.setValue(value: "p3", toKey: "progress3")
            
            UIView.animate(withDuration: 5, animations: {
                ZoneRepository.moveScene(scene: self.scene1, sceneZone: self.sceneZone1, correctZone: self.correctZone1, draggedZone: self.draggedZone1, x: 375, x2: 55)
                ZoneRepository.moveScene(scene: self.scene2, sceneZone: self.sceneZone2, correctZone: self.correctZone2, draggedZone: self.draggedZone2, x: 1015, x2: 375)
                ZoneRepository.moveScene(scene: self.scene3, sceneZone: self.sceneZone3, correctZone: self.correctZone3, draggedZone: self.draggedZone3, x: 55, x2: 695)
                ZoneRepository.moveScene(scene: self.scene4, sceneZone: self.sceneZone4, correctZone: self.correctZone4, draggedZone: self.draggedZone4, x: 695, x2: 1015)
            }, completion: {_ in
                let congratsPage = CongratsPage()
                congratsPage.modalPresentationStyle = .custom
                congratsPage.congratsDelegate = self
                self.present(congratsPage, animated: true, completion: nil)
            })
            
        }
    }
    
}
