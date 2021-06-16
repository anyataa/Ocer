//
//  CongratsPage.swift
//  CongratulationPage
//
//  Created by Adlan Nourindiaz on 12/06/21.
//

import UIKit

@objc protocol CongratsDelegate {
    func ulangButtonTapped()
    func keluarButtonTapped()
    func lanjutButtonTapped()
   
}

class CongratsPage: UIViewController{
    
    @IBOutlet var congratsDelegate: CongratsDelegate?
    
    
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var ulangButton: UIButton!
    @IBOutlet weak var lanjutButton: UIButton!
    @IBOutlet weak var keluarButton: UIButton!
    @IBOutlet weak var darkView: UIVisualEffectView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
      
    }
    
    @IBAction func didUlangButtonTapped(_ sender: Any) {
        congratsDelegate?.ulangButtonTapped()
        print("ulang button ok")
    }
    
    @IBAction func didLanjutButtonTapped(_ sender: Any) {
        congratsDelegate?.lanjutButtonTapped()
      
        print("lanjut button okay")
    }
    
    @IBAction func didKeluarButtonTapped(_ sender: Any) {
        congratsDelegate?.keluarButtonTapped()
        print("keluar button okay")
    }
}


enum Games {
    case game1
    case game2
    case game3
    case game4
}


// MARK: - Nambah function dibawah


//
//
//@IBAction func popUpButton(_ sender: Any) {
//    let congratsPage = CongratsPage()
//
//    congratsPage.modalPresentationStyle = .custom
//    congratsPage.congratsDelegate = self
//
//    present(congratsPage, animated: true, completion: nil)
//
//}
//
//
//
//
//}
//
////game bangun tidur
//
//extension ViewController: CongratsDelegate{
//func ulangButtonTapped() {
//    self.dismiss(animated: true, completion: nil)
//    performSegue(withIdentifier: "toPage1", sender: nil)
//}
//
//func keluarButtonTapped() {
//    self.dismiss(animated: true, completion: nil)
//    performSegue(withIdentifier: "toSubMenu", sender: nil)
//}
//
//func lanjutButtonTapped() {
//    self.dismiss(animated: true, completion: nil)
//    performSegue(withIdentifier: "toPage2", sender: nil)
//    print("from main page")
//}
//}
