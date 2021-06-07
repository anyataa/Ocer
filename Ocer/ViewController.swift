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
        Story(storyName: "Berangkat Sekolah", storyImage: "Sekolah"),
        Story(storyName: "Berangkat Sekolah", storyImage: "Sekolah"),
        Story(storyName: "Berangkat Sekolah", storyImage: "Sekolah")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CardView", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CardViewCell")
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardViewCell", for: indexPath) as! CardView
        
        cell.storyName.image = UIImage(named: "AppName")
        cell.storyImage.image = UIImage(named: "\(stories[indexPath.row].storyImage)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
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

