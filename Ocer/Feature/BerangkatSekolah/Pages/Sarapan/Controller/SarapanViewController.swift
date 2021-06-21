//
//  SarapanViewController.swift
//  Ocer
//
//  Created by Anya Akbar on 12/06/21.
//

import UIKit

class SarapanViewController: UIViewController, CongratsDelegate {
    
    let GAME_ID: String = "eat"
    var score : Int = 0
    
//     Peotocol XIB Congratulation
    func ulangButtonTapped() {
        self.dismiss(animated: true, completion: nil)
        resetGame()

    }
    
    func keluarButtonTapped() {
        self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "SubMenu", sender: nil)
    }
    
    func lanjutButtonTapped() {
        self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "toSekolah", sender: nil)
    }
    
//    Protocol Finish
    
    var center: CGPoint = CGPoint.zero
    var dropZone : CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    func setBackground() {
        let background = UIImageView(image: UIImage(named: "Background Makanan"))
        
        background.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        self.view.addSubview(background)
    }
    let hand : UIView = {
        let handView = UIView(frame: CGRect(x: 327, y: 179, width: 90, height: 98))
        handView.backgroundColor = UIColor(patternImage: UIImage(named: "HandSmall")!)
        handView.alpha = 0
        return handView
    }()
    var animationCount : Int = 0
    
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
                    self.hand.center = self.bowlZone.center
                } completion: { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.hand.center = self.sayurCenter
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
        backButton.frame=CGRect(x: 18, y: 58, width: 80, height: 60)
        backButton.setImage(UIImage(named: "BackButton"), for: .normal)
        backButton.addTarget(self, action: #selector(segueBack), for: .touchUpInside)
 
        view.addSubview(backButton)
    }
    @objc func segueBack() {
        performSegue(withIdentifier: "SubMenu", sender: self)
    }
    
    let ayam: UIView  = {
        let ayam = UIView(frame: CGRect(x: 1000, y: 300, width: 200, height: 197))
//      NOTE:  Remove force Unwrap
          ayam.backgroundColor = UIColor(patternImage: UIImage(named: "Ayam")!)
            
            return ayam
    }()
    
    let sayur: UIView  = {
        let brokoli = UIView(frame: CGRect(x: 950, y: 750, width: 200, height: 212))
//      NOTE:  Remove force Unwrap
          brokoli.backgroundColor = UIColor(patternImage: UIImage(named: "Sayur")!)
            return brokoli
    }()
    
    let telur: UIView  = {
        let egg = UIView(frame: CGRect(x: 200, y: 800, width: 200, height: 165))
//      NOTE:  Remove force Unwrap
          egg.backgroundColor = UIColor(patternImage: UIImage(named: "Telur")!)
            return egg
    }()
    
    let bowlZone: UIView = {
        let bowl = UIView(frame: CGRect(x: 580, y: 780, width: 200, height: 280))
//        bowl.backgroundColor = .green
        
        return bowl
        
    }()
    
    let ball : UIView = {
    let basket = UIView(frame: CGRect(x: 100, y: 300, width: 200, height: 200))

        basket.backgroundColor = UIColor(patternImage: UIImage(named: "Basket")!)

        return basket
    }()
    
    let rug : UIView  = {
            let view = UIView(frame: CGRect(x: 540, y: 50, width: 338, height: 192))
            view.backgroundColor =  UIColor(patternImage: UIImage(named: "keset")!)
            return view
    }()
    
    var rugCenter : CGPoint = CGPoint(x: 0, y: 0)
    var ballCenter : CGPoint = CGPoint(x: 0, y: 0)
    var ayamCenter : CGPoint = CGPoint(x: 0, y: 0)
    var  sayurCenter : CGPoint = CGPoint(x: 0, y: 0)
    var telurCenter : CGPoint = CGPoint(x: 0, y: 0)
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        setBackButton()
        let centerX = view.frame.width/2
        let centerY = view.frame.height/2
            
//       set object based on center
        rug.frame = CGRect(x: centerX, y: centerY*0.1, width: 338, height: 192)
        ball.frame = CGRect(x: centerX/4, y: centerY*1.4, width: 200, height: 200)
        telur.frame = CGRect(x: centerX*1.6, y: centerY*1.1, width: 200, height: 164)
        ayam.frame = CGRect(x: centerX*0.1, y: centerY*0.8, width: 200, height: 197)
        sayur.frame = CGRect(x: centerX/3, y: centerY/7, width: 200, height: 212)
        bowlZone.frame = CGRect(x: centerX-100, y: centerY+120, width: 200, height: 180)
//     Save position
        rugCenter = rug.center
        ballCenter = ball.center
        ayamCenter = ayam.center
        sayurCenter = sayur.center
        telurCenter = telur.center
        setHintButton()
        
        
//         Do any additional setup after loading the view.
//        Sound Settings
        Setting.addButtonToView(destination: self)
//        view
        view.addSubview(ball)
        view.addSubview(rug)
        view.addSubview(ayam)
        view.addSubview(telur)
        view.addSubview(sayur)
        view.addSubview(bowlZone)
        view.addSubview(hand)
              
//        set Zone for drop
        dropZone = bowlZone.frame
        
        
        
//        Gesture
        ball.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragNotFood(_:))))
        rug.addGestureRecognizer((UIPanGestureRecognizer(target: self, action: #selector(dragNotFood(_:)))))
        telur.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragFood(_:))))
        ayam.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragFood(_:))))
        sayur.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragFood(_:))))
        
//      Saying Congratulation
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Instruction.showInstructionPage(self, gameId: GAME_ID)
    }
    
   
//    Tanya Kak Zein Masukin Param di sini GIMANA? Tanya temen temen juga pas async !!!
    @objc private func dragNotFood(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            //get object position on drag start
            center = sender.view!.center
//            print("began")
        
        case .changed:
            //bring dragged object to front (topmost z index within the same view hierarchy)
            view.bringSubviewToFront(sender.view!)
//            print("change")
            
            //update object position while dragging
            let translation = sender.translation(in: view)
//            print("translate")
            sender.view!.center = CGPoint(x: center.x + translation.x,
                                          y: center.y + translation.y)

        case .ended:
          
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseIn]) {
                if (sender.view?.frame != nil) {
                    //            EXECUTE SOUND EFFECT BOING! Wrong
                    Setting.playSoundEffect(fileName: "no")
                    if sender.view!.frame.width == 338 {
                        sender.view!.center = self.rugCenter
                    } else if sender.view!.frame.width == 200 {
                        sender.view!.center = self.ballCenter
                    }
                }
            }
          
        default:
            break
        }
    }
    
  
    
    @objc private func dragFood(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            center = sender.view!.center
           
        case .changed:
//            NOTE : Remove Force unwrap
            view.bringSubviewToFront(sender.view!)
            let translation = sender.translation(in: view)
            sender.view!.center = CGPoint(x: center.x + translation.x, y: center.y + translation.y)
            if sender.view?.frame != nil {
                
                if sender.view!.frame.intersects(dropZone) {
                    sender.view!.layer.shadowRadius = 15
                    sender.view!.layer.shadowColor = UIColor.systemGreen.cgColor
                } else {
                  
                    
                }
                sender.view!.layer.shadowOpacity = 1
                break
            }
            
        case .ended:
            UIView.animate(withDuration: 0.5, delay: 0.0,usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseIn]){
                self.dragEnded(draggableObject: sender, draggableZone: self.bowlZone)
//                print(self.score)
                self.sayCongratulationWhenFinish()
            }
            
        default:
            break
        }
    }
    
   
    
    func dragEnded(draggableObject: UIPanGestureRecognizer, draggableZone: UIView ) {
        
        if (draggableObject.view!.frame.intersects(draggableZone.frame)){
            self.score += 1
            draggableObject.view!.center = draggableZone.center
            draggableObject.view!.alpha = 0
            
//NOTE:            Play sounds
            Setting.playSoundEffect(fileName: "ok")
            
            
        }
    
            else {
                if draggableObject.view!.frame.height == 212 {
                    draggableObject.view!.center = self.sayurCenter
                 } else if draggableObject.view!.frame.height == 164 {
                    draggableObject.view!.center = self.telurCenter
                 }else if draggableObject.view!.frame.height == 197 {
                    draggableObject.view!.center = self.ayamCenter
                 }
        }
        //turn off shadow
        draggableObject.view!.layer.shadowOpacity = 0
    }
    
    func sayCongratulationWhenFinish(){
        if self.score == 3 {
//            print("Yes You Did It")
//            print(sayurCenter)
            Progress.setValue(value: "p4", toKey: "progress4")
//            implement congratulation XIB
            let congratsPage = CongratsPage()
        
            congratsPage.modalPresentationStyle = .custom
            congratsPage.congratsDelegate = self
        
            present(congratsPage, animated: true, completion: nil)
        }
    }
    
    func resetGame() {
//        rug.center = rugCenter
//        rug.alpha = 1
//        ball.center = ballCenter
//        ball.alpha = 1
        sayur.center = sayurCenter
        sayur.alpha = 1
        telur.center = telurCenter
        telur.alpha = 1
        ayam.center = ayamCenter
        ayam.alpha = 1
        score = 0
        Instruction.showInstructionPage(self, gameId: GAME_ID)
    }

}


// MARK: What my code lacks of?
// 1. Force unwrap (!)
// 2. Inconsistency for Variable name (English or Indonesia, Choose one not both)
// 3. Repeatable func to create View, i can make it as func with param to make it reusable

