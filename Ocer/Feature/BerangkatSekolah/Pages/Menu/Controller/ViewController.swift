//
//  ViewController.swift
//  Ocer
//
//  Created by Anya Akbar on 03/06/21.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var stories: [Story] = SeederStaticDataStore.generateStories()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RegisterNib.registerCollectionViewNib(nibName: "CardView", collectionView: collectionView, cellId: "CardViewCell")
        
        self.collectionView.backgroundColor = UIColor(white: 0, alpha: 0)
        Setting.addButtonToView(destination: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
    
}

extension ViewController {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardViewCell", for: indexPath) as! CardView
        
        cell.cardName.text = stories[indexPath.row].storyName
        cell.cardImage.image = UIImage(named: "\(stories[indexPath.row].storyImage)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            DispatchQueue.main.async {
                Setting.playSoundEffect(fileName: "pressButton")
            }
            self.performSegue(withIdentifier: "toSubMenu", sender: indexPath)
        }
    }
    
}
