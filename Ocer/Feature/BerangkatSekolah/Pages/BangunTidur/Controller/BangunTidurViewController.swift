//
//  BangunTidurViewController.swift
//  Ocer
//
//  Created by Anya Akbar on 09/06/21.
//

import UIKit

class BangunTidurViewController: UIViewController, CongratsDelegate {
    
    let GAME_ID: String = "bedroom"
    
//    Protocol Congrats
    func ulangButtonTapped() {
        self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "toBangun", sender: self)
           
//        Error said: Has no identifier called subMenu
 
        
    }
    
    func keluarButtonTapped() {
        self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "toSubMenu", sender: self)
    }
    
    func lanjutButtonTapped() {
        self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "toMandi", sender: self)
    }
    //    Finish

    let backgroundImage =  UIImage(named: "kamarPolos")
    let pillowImage = UIImage(named: "bantal")
    var center: CGPoint = CGPoint.zero
    var zones: [CGRect] = []
    var score : Int = 0
    var animationCount : Int = 0
    let hand : UIView = {
        let handView = UIView(frame: CGRect(x: 300, y: 780, width: 90, height: 98))
        handView.backgroundColor = UIColor(patternImage: UIImage(named: "HandSmall")!)
        handView.alpha = 0
        return handView
    }()
    
    func setBackgroundImage() {
        let backgroundPlaceHolder = UIImageView(image: backgroundImage)
        backgroundPlaceHolder.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        view.addSubview(backgroundPlaceHolder)
    }
    
    func setHintButton() {
        
        let hintButton = UIButton(type: .custom)
        hintButton.frame=CGRect(x: 140, y: 58, width: 36, height: 52)
        hintButton.setImage(UIImage(named: "Instruction"), for: .normal)
        hintButton.addTarget(self, action: #selector(animateHandHint), for: .touchUpInside)
        
        view.addSubview(hintButton)
    }
    
    @objc func animateHandHint() {
        hand.isHidden = false
        view.bringSubviewToFront(hand)
        animationCount = 0
        animateHand()
    }
    
    func animateHand(){
        hand.alpha = 1
        if self.animationCount < 3{
            self.animationCount += 1
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1,delay: 0.5) {
                    self.hand.center = self.rugZone.center
                } completion: { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.hand.center = self.rugCenter
                        self.animateHand()
                    }
                }
            }
        } else {
            hand.isHidden = true
        }
    }
    
    func setBackButton() {
        let backButton  = UIButton(type: .custom)
        backButton.frame=CGRect(x: 18, y: 58, width: 75, height: 45)
        backButton.setImage(UIImage(named: "BackButton"), for: .normal)
        backButton.addTarget(self, action: #selector(segueBack), for: .touchUpInside)
        
        view.addSubview(backButton)
    }
    @objc func segueBack() {
        performSegue(withIdentifier: "toSubMenu", sender: self)
    }
//    func setPillow() {
//        let pillowImagePlace = UIImageView(image: UIImage(named: "bantal"))
//        pillowImagePlace.frame = CGRect(x: 100, y: 500, width: 200, height: 200)
//        pillowImagePlace.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragPillow(_ :))))
//        view.addSubview(pillowImagePlace)
//    }
    

    
   var a = false
    var b = false
    var c = false
    var d = false
    

    let pillow: UIView = {
//        let view = UIImageView(image: UIImage(named: "bantal"))
//        view.frame = CGRect(x: 100, y: 500, width: 188, height: 110)
        
        let view = UIView(frame: CGRect(x: 500, y: 500, width: 195, height: 110))
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bantal")!)
//        view.layer.borderColor = UIColor.black.cgColor
//        view.layer.borderWidth = 10
//        view.layer.cornerRadius = 20
        return view
    }()
    
    let pillow2: UIView = {
        
        let view = UIView(frame: CGRect(x: 300, y: 20, width: 200, height: 200))
//        view.backgroundColor = UIColor(patternImage: UIImage(named: "bantal")!)
//        let view = UIView(frame: CGRect(x: 200, y: 800, width: 188, height: 110))
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Oval")!)
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 10
        view.layer.cornerRadius = 100
        return view
    }()
    
    let pillow3: UIView = {
        let view = UIView(frame: CGRect(x: 800, y: 200, width: 112, height: 254))
        view.backgroundColor = UIColor(patternImage: UIImage(named: "guling")!)
    
//        let view = UIView(frame: CGRect(x: 730, y: 380, width: 130, height: 250))
//        view.layer.cornerRadius = 50
//        view.backgroundColor = .yellow
//        view.layer.borderColor = UIColor.black.cgColor
//        view.layer.borderWidth = 10
        return view
    }()
    
    let rug: UIView = {
        let view = UIView(frame: CGRect(x: 140, y: 700, width: 338, height: 192))
        view.backgroundColor =  UIColor(patternImage: UIImage(named: "keset")!)
//        view.layer.cornerRadius = 94
//        view.layer.borderWidth = 10
//        view.layer.borderColor = UIColor.black.cgColor
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
        let view = UIView(frame: CGRect(x: 570, y: 260, width: 200, height: 200))
        view.backgroundColor = .white
        view.layer.cornerRadius = 100
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
        let view = UIView(frame: CGRect(x: 840, y: 700, width: 338, height: 192))
        view.backgroundColor = UIColor(patternImage: UIImage(named: "rugZone")!)
        view.layer.cornerRadius = 94
//        view.layer.borderWidth = 10
//        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    var pillowCenter : CGPoint = CGPoint(x: 0, y: 0)
    var pillow2Center : CGPoint = CGPoint(x: 0, y: 0)
    var pillow3Center : CGPoint = CGPoint(x: 0, y: 0)
    var rugCenter: CGPoint = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //set background image
        setBackgroundImage()
        setBackButton()
//set sound settings after loading background
        Setting.addButtonToView(destination: self)

        //setup view
        view.addSubview(pillow)
        view.addSubview(pillow2)
        view.addSubview(pillow3)
        view.addSubview(rug)
        view.addSubview(pillowZone)
        view.addSubview(pillowZone2)
        view.addSubview(pillowZone3)
        view.addSubview(rugZone)
        view.addSubview(hand)
        setHintButton()
//Get center
        pillowCenter = pillow.center
        pillow2Center = pillow2.center
        pillow3Center = pillow3.center
        rugCenter = rug.center
        
        //add to zones to check intersection
        zones.append(pillowZone.frame)
        zones.append(pillowZone2.frame)
        zones.append(rugZone.frame)
        zones.append(pillowZone3.frame)
        
        //add pan gesture
        
//        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(drag(_:)))
        pillow.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragPillow(_ :))))
        pillow2.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragPillow2(_:))))
        pillow3.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragPillow3(_:))))
        rug.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragRug(_:))))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Instruction.showInstructionPage(self, gameId: GAME_ID)
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
                      
                        sender.view!.layer.shadowRadius = 15
                        if(zone == pillowZone.frame) {
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
                    self.dragEnded(draggableObject: sender, draggableZone: self.pillowZone)
                   
                 
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
            
            for zone in zones {
                if (sender.view?.frame != nil) {
                    if (sender.view!.frame.intersects(zone))  {
                      
                        sender.view!.layer.shadowRadius = 15
                        if(zone == pillowZone2.frame) {
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
                    self.dragEnded(draggableObject: sender, draggableZone: self.pillowZone2)
                   
                 
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
                    self.dragEnded(draggableObject: sender, draggableZone: self.pillowZone3)
                   
                 
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
            rug.center = CGPoint(x: center.x + translation.x, y: center.y + translation.y)
            
          
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
                    self.dragEnded(draggableObject: sender, draggableZone: self.rugZone)
                   
                 
                }
            }
        default:
            break
        }
    }
    
  
    
    func dragEnded(draggableObject: UIPanGestureRecognizer, draggableZone: UIView) {
        
        if (draggableObject.view!.frame.intersects(draggableZone.frame)){
            draggableObject.view!.center = draggableZone.center
         
            Setting.playSoundEffect(fileName: "ok")
            
       
         
         

        }
      
            else {
                
                if draggableObject.view!.frame.width == 195 {
                    draggableObject.view!.center = pillowCenter
                } else if draggableObject.view!.frame.width == 196 {
                    draggableObject.view!.center = pillow2Center
                } else if draggableObject.view!.frame.width == 338 {
                    draggableObject.view!.center = rugCenter
                } else if draggableObject.view!.frame.width == 112 {
                    draggableObject.view!.center = pillow3Center
                }
                Setting.playSoundEffect(fileName: "no")
        }
        //turn off shadow
        draggableObject.view!.layer.shadowOpacity = 0
//        Implement Congratulation here
       
        checkWin()
    }
    
    
    func checkWin() {
       
//        else {a = false; b = false ; c = false; d = false}
  
        if rug.center == rugZone.center  && pillow3.center == pillowZone3.center  && pillow2.center == pillowZone2.center && pillow.center == pillowZone.center {
            print("yes you did it")
            
            Progress.setValue(value: "p2", toKey: "progress2")
            let congratsPage = CongratsPage()
        
            congratsPage.modalPresentationStyle = .custom
            congratsPage.congratsDelegate = self
        
            present(congratsPage, animated: true, completion: nil)
            print(a,b,c,d)
        
            
        }
        print(a,b,c,d)
    }
    
}



// Why Extension only need to be called Once, Segue still not performing yet

