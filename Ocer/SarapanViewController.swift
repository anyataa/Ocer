//
//  SarapanViewController.swift
//  Ocer
//
//  Created by Anya Akbar on 12/06/21.
//

import UIKit

class SarapanViewController: UIViewController, CongratsDelegate {
    var score : Int = 0
    
//     Peotocol XIB Congratulation
    func ulangButtonTapped() {
        self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "toSarapan", sender: self)

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
        let background = UIImageView(image: UIImage(named: "backgroundMakan"))
        
        background.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        self.view.addSubview(background)
    }
    
    func setBackButton() {
        let backButton  = UIButton(type: .custom)
        backButton.frame=CGRect(x: 20, y: 40, width: 80, height: 60)
        backButton.setImage(UIImage(named: "BackButton"), for: .normal)
        backButton.addTarget(self, action: #selector(segueBack), for: .touchUpInside)
 
        view.addSubview(backButton)
    }
    @objc func segueBack() {
        self.dismiss(animated: true, completion: nil)
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
        let bowl = UIView(frame: CGRect(x: 580, y: 680, width: 200, height: 130))
//        bowl.backgroundColor = .green
        
        return bowl
        
    }()
    
    let ball : UIView = {
    let basket = UIView(frame: CGRect(x: 100, y: 300, width: 200, height: 200))

        basket.backgroundColor = UIColor(patternImage: UIImage(named: "Basket")!)

        return basket
    }()
    
    let rug: UIView  = {
            let view = UIView(frame: CGRect(x: 540, y: 50, width: 338, height: 192))
            view.backgroundColor =  UIColor(patternImage: UIImage(named: "keset")!)
            return view
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        setBackButton()
        let centerX = view.frame.width/2
        let centerY = view.frame.height/2
       
        
            
//        centerized object
        rug.frame = CGRect(x: centerX, y: centerY*0.1, width: 338, height: 192)
        ball.frame = CGRect(x: centerX/4, y: centerY*1.4, width: 200, height: 200)
        telur.frame = CGRect(x: centerX*1.6, y: centerY*1.1, width: 200, height: 164)
        ayam.frame = CGRect(x: centerX*0.1, y: centerY*0.8, width: 200, height: 197)
        sayur.frame = CGRect(x: centerX/3, y: centerY/7, width: 200, height: 212)
        bowlZone.frame = CGRect(x: centerX-100, y: centerY+120, width: 200, height: 120)
        
        
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
        
//        Trial for function
        
       
        

        
        
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
    
//    Tanya Kak Zein Masukin Param di sini GIMANA? Tanya temen temen juga pas async !!!
    @objc private func dragNotFood(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            //get object position on drag start
            center = sender.view!.center
            print("began")
        
        case .changed:
            //bring dragged object to front (topmost z index within the same view hierarchy)
            view.bringSubviewToFront(sender.view!)
            print("change")
            
            //update object position while dragging
            let translation = sender.translation(in: view)
            print("translate")
            sender.view!.center = CGPoint(x: center.x + translation.x,
                                          y: center.y + translation.y)

        case .ended:
          
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseIn]) {
                if (sender.view?.frame != nil) {
                    sender.view!.center = CGPoint(x: Int.random(in: 30...900), y: Int.random(in: 50...600))
//            EXECUTE SOUND EFFECT BOING! Wrong
                    Setting.playSoundEffect(fileName: "no")
                
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
                self.score += 1
                print(self.score)
                self.sayCongratulationWhenFinish()
            }
            
        default:
            break
        }
    }
    
   
    
    func dragEnded(draggableObject: UIPanGestureRecognizer, draggableZone: UIView ) {
        
        if (draggableObject.view!.frame.intersects(draggableZone.frame)){
            draggableObject.view!.center = draggableZone.center
            draggableObject.view!.alpha = 0
            
//NOTE:            Play sounds
            Setting.playSoundEffect(fileName: "ok")
            
            
        }
    
            else {
                draggableObject.view!.center = draggableObject.view!.center
        }
        //turn off shadow
        draggableObject.view!.layer.shadowOpacity = 0
    }
    
    func sayCongratulationWhenFinish(){
        if self.score == 3 {
            print("Yes You Did It")
            
//            implement congratulation XIB
            let congratsPage = CongratsPage()
        
            congratsPage.modalPresentationStyle = .custom
            congratsPage.congratsDelegate = self
        
            present(congratsPage, animated: true, completion: nil)
        }
    }

}

//Extension
extension ViewController: CongratsDelegate{
func ulangButtonTapped() {
    self.dismiss(animated: true, completion: nil)
    performSegue(withIdentifier: "toPage1", sender: nil)
}

func keluarButtonTapped() {
    self.dismiss(animated: true, completion: nil)
    performSegue(withIdentifier: "subMenu", sender: nil)
}

func lanjutButtonTapped() {
    self.dismiss(animated: true, completion: nil)
    performSegue(withIdentifier: "toPage2", sender: nil)
    print("from main page")
    }
}


// MARK: What my code lacks of?
// 1. Force unwrap (!)
// 2. Inconsistency for Variable name (English or Indonesia, Choose one not both)
// 3. Repeatable func to create View, i can make it as func with param to make it reusable

