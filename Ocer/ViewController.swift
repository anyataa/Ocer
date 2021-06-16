//
//  ViewController.swift
//  Ocer
//
//  Created by Anya Akbar on 03/06/21.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let stories: [Story] = [
        Story(storyName: "StoryTitle1", storyImage: "Story1"),
        Story(storyName: "StoryTitle2", storyImage: "Story2"),
        Story(storyName: "StoryTitle3", storyImage: "Story3")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Refactor this to new file
        let nib = UINib(nibName: "CardView", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CardViewCell")
        
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
        
        cell.cardName.image = UIImage(named: "\(stories[indexPath.row].storyName)")
        
        cell.cardImage.image = UIImage(named: "\(stories[indexPath.row].storyImage)")
        cell.cardImage.layer.cornerRadius = 30
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            Setting.playSoundEffect(fileName: "pressButton")
            self.performSegue(withIdentifier: "toSubMenu", sender: indexPath)
        } else {
            self.performSegue(withIdentifier: "toUnderDevelopment", sender: indexPath)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSubMenu" {
            _ = segue.destination as? SubMenu
        } else if segue.identifier == "toUnderDevelopment" {
            _ = segue.identifier as? UnderDevelopment
        }
    }
    
}

