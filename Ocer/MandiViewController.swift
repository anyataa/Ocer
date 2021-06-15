//
//  MandiViewController.swift
//  Ocer
//
//  Created by Stefan Adisurya on 11/06/21.
//

import UIKit
import AVKit
import AVFoundation

class MandiViewController: UIViewController {
    
    var center: CGPoint = CGPoint.zero
    var zones: [CGRect] = []
    
    var player: AVPlayer?
    
//    let screenSize = UIScreen.main.boundss
//    let screenWidth = screenSize.width
//    let screenHeight = screenSize.height
    
    let videoView1: UIView = {
        let view = UIView(frame: CGRect(x: (UIScreen.main.bounds.width - UIScreen.main.bounds.width + 130), y: (UIScreen.main.bounds.height - UIScreen.main.bounds.height + 736), width: 300, height: 150))
        view.backgroundColor = .green
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    let videoView2: UIView = {
        let view = UIView(frame: CGRect(x: (UIScreen.main.bounds.width - UIScreen.main.bounds.width + 524), y: 736, width: (UIScreen.main.bounds.width - UIScreen.main.bounds.width + 300), height: 150))
        view.backgroundColor = .orange
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    let videoView3: UIView = {
        let view = UIView(frame: CGRect(x: (UIScreen.main.bounds.width - UIScreen.main.bounds.width + 937), y: (UIScreen.main.bounds.width - UIScreen.main.bounds.width + 736), width: 300, height: 150))
        view.backgroundColor = .systemIndigo
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    let videoZone1: UIView = {
        let view = UIView(frame: CGRect(x: (UIScreen.main.bounds.width - UIScreen.main.bounds.width + 130), y: (UIScreen.main.bounds.width - UIScreen.main.bounds.width + 136), width: 300, height: 150))
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    let videoZone2: UIView = {
        let view = UIView(frame: CGRect(x: (UIScreen.main.bounds.width - UIScreen.main.bounds.width + 524), y: (UIScreen.main.bounds.width - UIScreen.main.bounds.width + 136), width: 300, height: 150))
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    let videoZone3: UIView = {
        let view = UIView(frame: CGRect(x: (UIScreen.main.bounds.width - UIScreen.main.bounds.width + 937), y: (UIScreen.main.bounds.width - UIScreen.main.bounds.width + 136), width: 300, height: 150))
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(videoView1)
        view.addSubview(videoView2)
        view.addSubview(videoView3)
        
        view.addSubview(videoZone1)
        view.addSubview(videoZone2)
        view.addSubview(videoZone3)
        
        zones.append(videoView1.frame)
        zones.append(videoView2.frame)
        zones.append(videoView3.frame)
        
        videoView1.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragVideo1(_:))))
        videoView2.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragVideo2(_:))))
        videoView3.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragVideo3(_:))))
        
//        playVideo()
    }
    
    @objc func dragVideo1(_ sender: UIPanGestureRecognizer) {
        player?.pause()
        switch sender.state {
        case .began:
            center = videoView1.center
            
        case .changed:
            view.bringSubviewToFront(sender.view!)
            
            let translation = sender.translation(in: view)
            videoView1.center = CGPoint(x: center.x + translation.x, y: center.y + translation.y)
            
            for zone in zones {
                if (sender.view?.frame != nil) {
                    if (sender.view!.frame.intersects(zone)) {
                        sender.view!.layer.shadowRadius = 15
                        
                        if (zone == videoZone3.frame) {
                            sender.view!.layer.shadowColor = UIColor.green.cgColor
                        } else {
                            sender.view!.layer.shadowColor = UIColor.red.cgColor
                        }
                        sender.view!.layer.shadowOpacity = 1
                        break
                    } else {
                        sender.view!.layer.shadowOpacity = 1
                    }
                }
            }
            
        case .ended:
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseIn]) {
                if (sender.view?.frame != nil) {
                    self.dragEnded(draggableObject: sender, draggableZone: self.videoZone3)
                }
            }
            
        default:
            break
        }
    }
    
    @objc func dragVideo2(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            center = videoView2.center
            
        case .changed:
            view.bringSubviewToFront(sender.view!)
            
            let translation = sender.translation(in: view)
            videoView2.center = CGPoint(x: center.x + translation.x, y: center.y + translation.y)
            
            for zone in zones {
                if (sender.view?.frame != nil) {
                    if (sender.view!.frame.intersects(zone)) {
                        sender.view!.layer.shadowRadius = 15
                        
                        if (zone == videoZone1.frame) {
                            sender.view!.layer.shadowColor = UIColor.green.cgColor
                        } else {
                            sender.view!.layer.shadowColor = UIColor.red.cgColor
                        }
                        sender.view!.layer.shadowOpacity = 1
                        break
                    } else {
                        sender.view!.layer.shadowOpacity = 1
                    }
                }
            }
            
        case .ended:
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseIn]) {
                if (sender.view?.frame != nil) {
                    self.dragEnded(draggableObject: sender, draggableZone: self.videoZone1)
                }
            }
            
        default:
            break
        }
    }
    
    @objc func dragVideo3(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            center = videoView3.center
            
        case .changed:
            view.bringSubviewToFront(sender.view!)
            
            let translation = sender.translation(in: view)
            videoView3.center = CGPoint(x: center.x + translation.x, y: center.y + translation.y)
            
            for zone in zones {
                if (sender.view?.frame != nil) {
                    if (sender.view!.frame.intersects(zone)) {
                        sender.view!.layer.shadowRadius = 15
                        
                        if (zone == videoZone2.frame) {
                            sender.view!.layer.shadowColor = UIColor.green.cgColor
                        } else {
                            sender.view!.layer.shadowColor = UIColor.red.cgColor
                        }
                        sender.view!.layer.shadowOpacity = 1
                        break
                    } else {
                        sender.view!.layer.shadowOpacity = 1
                    }
                }
            }
            
        case .ended:
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseIn]) {
                if (sender.view?.frame != nil) {
                    self.dragEnded(draggableObject: sender, draggableZone: self.videoZone2)
                }
            }
            
        default:
            break
        }
    }
    
    func dragEnded(draggableObject: UIPanGestureRecognizer, draggableZone: UIView) {
        if (draggableObject.view!.frame.intersects(draggableZone.frame)) {
            draggableObject.view!.center = draggableZone.center
        } else {
            draggableObject.view!.center = CGPoint(x: Int.random(in: 30...900), y: Int.random(in: 50...600))
        }
        
        player?.play()
        
        draggableObject.view!.layer.shadowOpacity = 0
    }
    
    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "video2", ofType: "mp4") else {
            debugPrint("Not found")
            return
        }
        
        player = AVPlayer(url: URL(fileURLWithPath: path))

        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoView1.bounds
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.cornerRadius = 20
        self.videoView1.layer.addSublayer(playerLayer)
        
        self.player?.addObserver(self, forKeyPath: "rate", options: .new, context: nil)
        
        player?.play()
//        player?.pause()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        // Bikin button play dan pause di observeValue.
        if self.player?.rate == 0 {
            print("Pause") // Button pause
        } else {
            print("Play") // Button play
        }
    }
    
}
