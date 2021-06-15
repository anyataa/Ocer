//
//  KeSekolahViewController.swift
//  Ocer
//
//  Created by Antony Susanto on 11/06/21.
//

import UIKit
import AVFoundation

enum Direction {
	case up, left, down, right
	
	//Degrees    Radians (exact)    Radians (approx)    Direction(initial: right = 0°)
	//90°             π/2                 1.571             Down
	//180°            π                   3.142             Left
	//270°            3π/2                4.712             Up
	//360°            2π                  6.283             Right
	func getAngle() -> CGFloat {
		switch self {
			case .up:
				return 4.712
			case .left:
				return 3.142
			case .down:
				return 1.571
			case .right:
				return 0
		}
	}
}

class MyGesture: UIPanGestureRecognizer {
	var direction: Direction?
	var center:CGPoint?
}

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
    @IBOutlet weak var finishZone: UIImageView!
    
    @IBOutlet weak var car: UIImageView!
	@IBOutlet weak var playButton: UIButton!
	
	@IBOutlet weak var musicSetting: UIButton!
	@IBOutlet weak var soundSetting: UIButton!
	
	var soundPlayer: AVAudioPlayer?
	var soundVolume: Float = 0.2
	var musicPlayer: AVAudioPlayer?
    
    var zones: [Dictionary<String,Any>] = []
    var totalDistance:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupArrow()
        setupZones(zone1, zone2, zone3, zone4, zone5, zone6, finishZone)
		
		playMusic()
    }
    
    func setupArrow() {
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
    }
    
    func setupZones(_ zones:UIImageView...){
        for (index, zone) in zones.enumerated() {
            var distance:CGFloat = 0
			
            if (index != zones.count-1){
                if (index == 0) {
                    distance = getDistance(car.center, zone.center)
                } else {
                    distance = getDistance(zones[index-1].center, zone.center)
                }

				var direction:Direction {
					if (zone.center.x < zones[index+1].center.x){
						//destination = right
						return .right
					} else if (zone.center.x > zones[index+1].center.x){
						//destination = left
						return .left
					}  else if (zone.center.y < zones[index+1].center.y){
						//destination = down
						return .down
					} else {
						//destination = up
						return .up
					}
				}

				self.zones.append(["zone": zone, "destinationDirection": direction, "correct": false, "distanceFromPreviousZone": distance])
            } else {
                //finish zone
                distance = getDistance(zones[index-1].center, finishZone.center)
                self.zones.append(["zone": zone, "correct": true, "distanceFromPreviousZone": distance])
            }
            totalDistance += distance
        }
    }
    
    func getDistance(_ lhs: CGPoint, _ rhs: CGPoint) -> CGFloat {
        //get distance between two centers
        //function to calculate the hypotenuse
        return hypot(lhs.x - rhs.x, lhs.y - rhs.y)
    }
    
    func verifyAnswers() -> Bool{
        //verify if each zone is correct
        for zone in zones {
            if !(zone["correct"] as! Bool) {
				playSound("no")
                return false
            }
        }
		playSound("ok")
        return true
    }
	
	func muteMusic(){
		//TODO mute is global
		if (musicPlayer!.isPlaying){
			musicSetting.setImage(UIImage(systemName: "speaker.slash.fill"), for: .normal)
			musicPlayer?.stop()
		} else {
			musicSetting.setImage(UIImage(systemName: "speaker.wave.2.fill"), for: .normal)
			musicPlayer?.play()
		}
	}
	
	func muteSound(){
		//TODO mute is global
		if (soundVolume == 0.2) {
			soundSetting.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
			soundVolume = 0
		} else {
			soundSetting.setImage(UIImage(systemName: "speaker.wave.2"), for: .normal)
			soundVolume = 0.2
		}
	}
	
	func playMusic(){
		let path = Bundle.main.path(forResource: "bg", ofType: "mp3")!
		let url = URL(fileURLWithPath: path)

		do {
			//TODO volume = 0 or 100 based on setting ??
			//TODO play or pause based on setting
			musicPlayer = try AVAudioPlayer(contentsOf: url)
			musicPlayer?.volume = 0.2
			musicPlayer?.numberOfLoops = -1
			musicPlayer?.play()
		} catch {
			print("couldn't load the file")
		}
	}
	
	func playSound(_ soundName:String){
		let path = Bundle.main.path(forResource: soundName, ofType: "mp3")!
		let url = URL(fileURLWithPath: path)

		do {
			//TODO volume = 0 or 100 based on setting ??
			//TODO play or pause based on setting
			soundPlayer = try AVAudioPlayer(contentsOf: url)
			soundPlayer?.volume = soundVolume
			soundPlayer?.play()
		} catch {
			print("couldn't load the file")
		}
	}
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
	@IBAction func muteMusic(_ sender: Any) {
		muteMusic()
	}
	@IBAction func muteSound(_ sender: Any) {
		muteSound()
	}
	
    @IBAction func playButton(_ sender: Any) {
        if !(verifyAnswers()){
            print("incorrect")
            //TODO: handle incorrect answers if play button is pressed
            return
        }
		DispatchQueue.main.async {
			self.playButton.isUserInteractionEnabled = false
			let initialCarPosition = self.car.center
			
			//animation with keyframes
			UIView.animateKeyframes(withDuration: 5.0, delay: 0, options: [.calculationModeLinear], animations: {
				for (index, zone) in self.zones.enumerated() {
					//move car
					UIView.addKeyframe(withRelativeStartTime: Double(index)/Double(self.zones.count), relativeDuration: Double(zone["distanceFromPreviousZone"] as! CGFloat)/Double(self.totalDistance), animations: {
							self.car.center = (zone["zone"] as! UIImageView).center
						})
					
					//rotate car
					if (index != self.zones.count-1){
						UIView.addKeyframe(withRelativeStartTime: Double(index+1)/Double(self.zones.count), relativeDuration: 0.03, animations: {
							self.car.transform = CGAffineTransform(rotationAngle: (zone["destinationDirection"] as! Direction).getAngle())
						})
					}
				}
			}, completion:{_ in
				//TODO end the game, show congratulation pop up
				print("congratulation")
				let alert = UIAlertController(title: "Congratulation", message: "Kamu hebat!", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: {
					(action) in
					alert.dismiss(animated: true, completion: nil)
					self.car.center = initialCarPosition
					self.playButton.isUserInteractionEnabled = true
				}))
				self.present(alert, animated: true, completion: nil)
			})
		}
        
    }
    
    @objc private func drag(_ sender: MyGesture) {
        if let sview = sender.view as? UIImageView, let scenter = sender.center, let sdirection = sender.direction {
            switch sender.state {
                case .began:
                    //bring dragged object to the front (topmost z index)
                    view.bringSubviewToFront(sview)
                    
                case .changed:
                    //update object position while being dragged
                    let translation = sender.translation(in: view)
                    sview.center = CGPoint(x: scenter.x + translation.x, y: scenter.y + translation.y)
                    
                    //check if object intersects with drop zones
                    for (index, zone) in self.zones.enumerated() {
                        if (index == self.zones.count-1) {
                            //ignore finish zone
                            break
                        }
                        
                        if (sview.frame.intersects((zone["zone"] as! UIImageView).frame))  {
                            //turn on green shadow if dragged object is on top of correct drop zone, red if incorrect
                            sview.layer.shadowRadius = 15
                            sview.layer.shadowOpacity = 1
                            if (sdirection == zone["destinationDirection"] as! Direction){
                                sview.layer.shadowColor = UIColor.green.cgColor
                            } else {
                                sview.layer.shadowColor = UIColor.red.cgColor
                            }
                        break
                        } else {
                            sview.layer.shadowOpacity = 0
                        }
                        
                    }
                    
                case .ended:
                    //add arrow image to zone if it is correct
                    for (index, zone) in self.zones.enumerated() {
                        if (index == self.zones.count-1) {
                            //ignore finish zone
                            break
                        }
                        if (sview.frame.intersects((zone["zone"] as! UIImageView).frame)){
                            if (sdirection == zone["destinationDirection"] as! Direction){
                                (zone["zone"] as! UIImageView).image = sview.image
                                self.zones[index]["correct"] = true
                                
								playSound("ok")
                                break
                            } else {
                                //TODO handle incorrect try
                                //haptic feedback? shaky animation? sound?
                                print("incorrect")
								playSound("no")
                            }
                        }
                    }
                    
                    //reset dragged object state
                    sview.center = scenter
                    sview.layer.shadowOpacity = 0
                    
                default:
                    break
            }
        }
    }
}
