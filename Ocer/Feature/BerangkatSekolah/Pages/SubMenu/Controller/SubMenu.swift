//
//  SubMenu.swift
//  Ocer
//
//  Created by Stefan Adisurya on 07/06/21.
//

import UIKit

class SubMenu: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var subSceneView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let scenes: [Scene] = [
        Scene(sceneName: "Bangun Tidur", sceneImage: "SubMenu 1"),
        Scene(sceneName: "Menyikat Gigi", sceneImage: "SubMenu 2"),
        Scene(sceneName: "Sarapan", sceneImage: "SubMenu 3"),
        Scene(sceneName: "Pergi ke Sekolah", sceneImage: "SubMenu 4")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameProgress()
        
        self.subSceneView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        self.subSceneView.layer.cornerRadius = 30
        
        self.collectionView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        self.collectionView.layer.cornerRadius = 30
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        RegisterNib.registerCollectionViewNib(nibName: "CardView", collectionView: collectionView, cellId: "CardViewCell")
        Setting.addButtonToView(destination: self)
    }
    
    func gameProgress() {
        if Progress.shared.defaults.bool(forKey: "progress2") == false {
            self.scenes[1].sceneImage = "Lock SubMenu 2"
        }
        
        if Progress.shared.defaults.bool(forKey: "progress3") == false {
            self.scenes[2].sceneImage = "Lock SubMenu 3"
        }
        
        if Progress.shared.defaults.bool(forKey: "progress4") == false {
            self.scenes[3].sceneImage = "Lock SubMenu 4"
        }
        
        if Progress.shared.defaults.bool(forKey: "progress2") == true && Progress.shared.defaults.bool(forKey: "progress3") == true && Progress.shared.defaults.bool(forKey: "progress4") == true  {
            self.scenes[1].sceneImage = "SubMenu 2"
            self.scenes[2].sceneImage = "SubMenu 3"
            self.scenes[3].sceneImage = "SubMenu 4"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scenes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardViewCell", for: indexPath) as! CardView
        cell.cardName.text = scenes[indexPath.row].sceneName
        cell.cardImage.image = UIImage(named: "\(scenes[indexPath.row].sceneImage)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            Setting.playSoundEffect(fileName: "pressButton")
            self.performSegue(withIdentifier: "toBangunTidur", sender: nil)
        case 1:
            Setting.playSoundEffect(fileName: "pressButton")
            if Progress.shared.defaults.bool(forKey: "progress2") == true {
                self.performSegue(withIdentifier: "toMandi", sender: nil)
            }
        case 2:
            Setting.playSoundEffect(fileName: "pressButton")
            if Progress.shared.defaults.bool(forKey: "progress3") == true {
                self.performSegue(withIdentifier: "toSarapan", sender: nil)
            }
        case 3:
            Setting.playSoundEffect(fileName: "pressButton")
            if Progress.shared.defaults.bool(forKey: "progress4") == true {
                self.performSegue(withIdentifier: "toKeSekolah", sender: nil)
            }
        default:
            print("Default")
        }
    }
    
}
