//
//  ViewController.swift
//  Ocer
//
//  Created by Anya Akbar on 03/06/21.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let stories: [Story] = SeederStaticDataStore.generateStories()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let nib = UINib(nibName: "CardView", bundle: nil)
//        collectionView.register(nib, forCellWithReuseIdentifier: "CardViewCell")
        
        RegisterNib.registerCollectionViewNib(nibName: "CardView", collectionView: collectionView, cellId: "CardViewCell")
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.backgroundColor = UIColor(white: 0, alpha: 0)
        Setting.addButtonToView(destination: self)
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardViewCell", for: indexPath) as! CardView
        
        cell.cardName.text = stories[indexPath.row].storyName
        
        cell.cardImage.image = UIImage(named: "\(stories[indexPath.row].storyImage)")
        cell.cardImage.layer.cornerRadius = 30
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            Setting.playSoundEffect(fileName: "pressButton")
            self.performSegue(withIdentifier: "toSubMenu", sender: indexPath)
        }
    }
    
}

