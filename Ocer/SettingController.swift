//
//  SettingController.swift
//  Ocer
//
//  Created by Karin Lim on 14/06/21.
//

import Foundation
import UIKit
import AVFoundation

public class Setting{
    public static var musicButton: UIButton!
    public static var soundButton: UIButton!
    public static var musicPlayer: AVAudioPlayer!
    public static var effectPlayer: AVAudioPlayer!
    
    public static func addButtonToView(destination: UIViewController){
        playBGM()
        var musicButtonImage = "musicOff.png"
        if !musicPlayer.isPlaying{
            musicButtonImage = "musicOn.png"
        }
        
        var soundButtonImage = "soundOff.png"
        if  UserDefaults.standard.object(forKey: "volume") != nil && UserDefaults.standard.float(forKey: "volume") == 0{
            soundButtonImage = "soundOn.png"
        }
        
        let musicButton = UIButton()
        musicButton.setBackgroundImage(UIImage.init(named: musicButtonImage), for: UIControl.State.normal)
        musicButton.translatesAutoresizingMaskIntoConstraints = false
        musicButton.addTarget(self, action: #selector(Setting.toggleMusic), for: UIControl.Event.touchUpInside)
        destination.view.addSubview(musicButton)

        let soundButton = UIButton()
        soundButton.setBackgroundImage(UIImage.init(named: soundButtonImage), for: UIControl.State.normal)
        soundButton.translatesAutoresizingMaskIntoConstraints = false
        soundButton.addTarget(self, action: #selector(Setting.toggleSound), for: UIControl.Event.touchUpInside)
        destination.view.addSubview(soundButton)

        musicButton.topAnchor.constraint(equalTo: destination.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        musicButton.trailingAnchor.constraint(equalTo: destination.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        musicButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        musicButton.widthAnchor.constraint(equalToConstant: 50).isActive = true

        soundButton.topAnchor.constraint(equalTo: musicButton.bottomAnchor, constant: 20).isActive = true
        soundButton.trailingAnchor.constraint(equalTo: destination.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        soundButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        soundButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.musicButton = musicButton
        self.soundButton = soundButton
        
    }
    
    public static func playBGM(){
        
        if let url = Bundle.main.url(forResource: "bgMusic", withExtension: "mp3"){
            do{
                
                musicPlayer = try AVAudioPlayer(contentsOf: url)
            }
            catch{
                
            }
            if let player = musicPlayer{
                if UserDefaults.standard.object(forKey: "musicState") != nil{
                    if UserDefaults.standard.bool(forKey: "musicState") == false {return}
                }
                player.numberOfLoops = -1
                player.prepareToPlay()
                player.play()
            }
        }
    }
    
    
    public static func playSoundEffect(fileName: String){
        
        
        if let url = Bundle.main.url(forResource: fileName, withExtension: "mp3"){
            do{
                
                effectPlayer = try AVAudioPlayer(contentsOf: url)
            }
            catch{
                
            }
            if let player = effectPlayer{
                if UserDefaults.standard.object(forKey: "volume") != nil{
                    player.volume = UserDefaults.standard.float(forKey: "volume")
                    if player.volume == 0 {return}
                }
                else{
                    player.volume = 0.5
                }
                player.play()
            }
        }
    }
    
    @objc public static func toggleMusic () -> Bool{
        if musicPlayer.isPlaying{
            musicPlayer.pause()
            musicButton.setBackgroundImage(UIImage.init(named: "musicOn.png"), for: UIControl.State.normal)
        }
        else{
            musicPlayer.play()
            musicButton.setBackgroundImage(UIImage.init(named: "musicOff.png"), for: UIControl.State.normal)
        }
        UserDefaults.standard.set(musicPlayer.isPlaying, forKey: "musicState")
        return musicPlayer.isPlaying
        
    }
    
    @objc public static func toggleSound(){
        if UserDefaults.standard.object(forKey: "volume") != nil {
            var volume = UserDefaults.standard.float(forKey: "volume")
            if volume == 0{
                volume = 0.5
                soundButton.setBackgroundImage(UIImage.init(named: "soundOff.png"), for: UIControl.State.normal)
            }
            else{
                volume = 0
                soundButton.setBackgroundImage(UIImage.init(named: "soundOn.png"), for: UIControl.State.normal)
            }
            if effectPlayer != nil{
                effectPlayer.setVolume(volume, fadeDuration: 0)
            }
            UserDefaults.standard.set(volume, forKey: "volume")
        }
        else{
            UserDefaults.standard.set(0, forKey: "volume")
        }
        
    }
    
    
}
