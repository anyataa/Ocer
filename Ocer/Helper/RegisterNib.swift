//
//  RegisterNib.swift
//  Ocer
//
//  Created by Stefan Adisurya on 20/06/21.
//

import UIKit

class RegisterNib {
    
    static func registerCollectionViewNib(nibName: String, collectionView: UICollectionView, cellId id: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: id)
    }
    
}
