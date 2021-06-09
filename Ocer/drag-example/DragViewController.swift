//
//  DragViewController.swift
//  Ocer
//
//  Created by Antony Susanto on 06/06/21.
//

import UIKit

class DragViewController: UIViewController {
    
    var center: CGPoint = CGPoint.zero
    var zones: [ArrowSquare] = []
    @IBOutlet weak var arrowUp: UIView!
    @IBOutlet weak var arrowDown: UIView!
    @IBOutlet weak var arrowLeft: UIView!
    @IBOutlet weak var arrowRight: UIView!
    
    let draggableObject: UIView = {
        let view = UIView(frame: CGRect(x: 200, y: 500, width: 100, height: 100))
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
    
    let playButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 450, y: 800, width: 110, height: 30))
        button.backgroundColor = .red
        button.setTitle("Play", for: .normal)
        button.addTarget(self, action: #selector(play), for: .touchUpInside)
        return button
    }()
    
    let playButton2: UIButton = {
        let button = UIButton(frame: CGRect(x: 580, y: 800, width: 110, height: 30))
        button.backgroundColor = .blue
        button.setTitle("Play2", for: .normal)
        button.addTarget(self, action: #selector(play2), for: .touchUpInside)
        return button
    }()
    
    func addZone(x:Int, y:Int, width:Int = 110, height:Int = 110) -> ArrowSquare {
        let view = ArrowSquare(frame: CGRect(x: x, y: y, width: width, height: height))
//        view.backgroundColor = .red
        view.img.image = nil
        zones.append(view)
        return view
    }
    
    enum direction {
        case top, down, left, right
        
        func getImage() -> UIImage {
            switch self {
            case .top:
                return UIImage(systemName: "arrow.up")!
            case .down:
                return UIImage(systemName: "arrow.down")!
            case .left:
                return UIImage(systemName: "arrow.left")!
            case .right:
                return UIImage(systemName: "arrow.right")!
            }
        }
    }
    
    func arrows(direction:direction, x:Int, y:Int, width:Int = 100, height:Int = 100) -> UIView {
        let view = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        view.backgroundColor = .red
        
        
        let img = UIImageView(frame: CGRect(x: 10, y: 10, width: 80, height: 80))
        img.image = direction.getImage()
        view.addSubview(img)
//        img.center = view.center
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(drag(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
//        zones.append(view)
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //setup view
        view.addSubview(draggableObject)
//        view.addSubview(dropZone)
//        view.addSubview(dropZone2)
//        view.addSubview(addZone(x: 300, y: 500))
        view.addSubview(addZone(x: 400, y: 500))
        view.addSubview(addZone(x: 400, y: 300))
        view.addSubview(addZone(x: 200, y: 300))
        view.addSubview(addZone(x: 200, y: 100))
        view.addSubview(addZone(x: 700, y: 100))
        view.addSubview(addZone(x: 700, y: 300))
        view.addSubview(addZone(x: 900, y: 300))
        
//        view.addSubview(arrows(direction: .top, x: 50, y: 100))
//        view.addSubview(arrows(direction: .down, x: 50, y: 300))
//        view.addSubview(arrows(direction: .left, x: 50, y: 500))
//        view.addSubview(arrows(direction: .right, x: 50, y: 700))
        
        
        view.addSubview(playButton)
        view.addSubview(playButton2)
        
//        draggableObject.center = view.center
        
        //add to zones to check intersection
//        zones.append(dropZone.frame)
//        zones.append(dropZone2.frame)
        
        //add pan gesture
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(drag(_:)))
        arrowUp.addGestureRecognizer(panGestureRecognizer)
        let panGestureRecognizer2 = UIPanGestureRecognizer(target: self, action: #selector(drag(_:)))
        arrowDown.addGestureRecognizer(panGestureRecognizer2)
        let panGestureRecognizer3 = UIPanGestureRecognizer(target: self, action: #selector(drag(_:)))
        arrowLeft.addGestureRecognizer(panGestureRecognizer3)
        let panGestureRecognizer4 = UIPanGestureRecognizer(target: self, action: #selector(drag(_:)))
        arrowRight.addGestureRecognizer(panGestureRecognizer4)
//        draggableObject.addGestureRecognizer(panGestureRecognizer)
        
        
        
    }

    @objc private func drag(_ sender: UIPanGestureRecognizer) {
        if (sender.view == nil) {
            return
        }
        switch sender.state {
        case .began:
            //get object position on drag start
            center = sender.view!.center
            
            //bring dragged object to front (topmost z index within the same view hierarchy)
            view.bringSubviewToFront(sender.view!)
            print("began")
            
        case .changed:
            //update object position while dragging
            let translation = sender.translation(in: view)
            sender.view!.center = CGPoint(x: center.x + translation.x,
                                          y: center.y + translation.y)
            
            //check if object intersects with drop zones
            //TODO only 1 drop zone is correct
            //TODO is looping necessary?
            for zone in zones {
                if (sender.view?.frame != nil) {
                    if (sender.view!.frame.intersects(zone.frame))  {
                        //turn on shadow if dragged object is on top of drop zone
                        //TODO green shadow for correct zone, red for incorrect zone
                        sender.view!.layer.shadowRadius = 15
//                        if(zone == dropZone.frame) {
                            sender.view!.layer.shadowColor = UIColor.green.cgColor
//                        } else {
//                            sender.view!.layer.shadowColor = UIColor.red.cgColor
//                        }
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
            UIView.animate(withDuration: 0, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseIn]) {
//                if (sender.view?.frame != nil) {
//                    //TODO snap to correct zone, otherwise reset draggableObject position
//                    if (sender.view!.frame.intersects(self.dropZone.frame)){
//                        sender.view!.center = self.dropZone.center
//                    } else {
//                        sender.view!.center = self.view.center
//                    }
//                    //turn off shadow
//                    sender.view!.layer.shadowOpacity = 0
//                }
                for zone in self.zones {
                    if (sender.view!.frame.intersects(zone.frame)){
//                        sender.view!.center = zone.center
                        sender.view!.center = self.center
                        sender.view!.layer.shadowOpacity = 0
                        let i = sender.view!.subviews[0] as! UIImageView
                        zone.img.image = i.image
                        
//                        print(zone.img)
//                        print(sender.view!.subviews[0])
                        
                        break
                    }
                }
            }
        default:
            break
        }
    }
    
    @objc func play(sender: UIButton!) {
        self.view.bringSubviewToFront(self.draggableObject)
        
        //nested animation
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseIn]) {
            self.draggableObject.center = self.dropZone.center
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseIn]) {
                self.draggableObject.center = self.dropZone2.center
            } completion: { _ in
                UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseIn]) {
                    self.draggableObject.center = self.view.center
                } completion: { _ in
                    print("done1")
                }
            }
        }
    }
    
    @objc func play2(sender: UIButton!) {
        self.view.bringSubviewToFront(self.draggableObject)
        
        //animation with keyframes
        UIView.animateKeyframes(withDuration: 3.0, delay: 0, options: [.calculationModeLinear], animations: {
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1, animations: {
//                    self.draggableObject.center = self.dropZone.center
//                })
//            UIView.addKeyframe(withRelativeStartTime: 0.12, relativeDuration: 0.25, animations: {
//                    self.draggableObject.center = self.dropZone2.center
//                })
//            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.1, animations: {
//                    self.draggableObject.center = self.view.center
//                })
//            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.1, animations: {
//                    self.draggableObject.center = self.dropZone2.center
//                })
//            UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 0.1, animations: {
//                    self.draggableObject.center = self.dropZone.center
//                })
//            UIView.addKeyframe(withRelativeStartTime: 0.95, relativeDuration: 0.1, animations: {
//                    self.draggableObject.center = self.view.center
//                })
            
            for (index,zone) in self.zones.enumerated() {
                UIView.addKeyframe(withRelativeStartTime: Double(index)/Double(self.zones.count), relativeDuration: 0.1, animations: {
                        self.draggableObject.center = zone.center
                    })
            }
            
            }, completion:{_ in
                print("done2")
            })
    }
    
}
