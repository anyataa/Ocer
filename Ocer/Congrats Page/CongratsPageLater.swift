//
//  CongratsPageLater.swift
//  CongratulationPage
//
//  Created by Adlan Nourindiaz on 14/06/21.
//

import UIKit

@objc protocol CongratsDelegateLater {
    func ulangButtonTapped()
    func keluarButtonTapped()
  
}


class CongratsPageLater: UIViewController {

    @IBOutlet var congratsDelegateLater: CongratsDelegateLater?
    
    
    @IBOutlet weak var darkView: UIVisualEffectView!
    @IBOutlet weak var ulangButton: UIButton!
    @IBOutlet weak var keluarButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didUlangButtonTapped(_ sender: Any) {
        congratsDelegateLater?.ulangButtonTapped()
        print("ulang button ok")
    }
    
    @IBAction func didKeluarButtonTapped(_ sender: Any) {
        congratsDelegateLater?.keluarButtonTapped()
        print("keluar button okay")
    }

}
