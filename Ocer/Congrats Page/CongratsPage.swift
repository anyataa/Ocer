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





//class CongratsPage: UIView {
//
//    let nibName = "CongratsPage"
//    var contentView: UIView?
//
   
//
//
//
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//        guard let view = loadViewFromNib() else{ return}
//        view.frame = self.bounds
//        self.addSubview(view)
//        contentView = view
//    }
//
//    func loadViewFromNib() -> UIView?{
//        let bundle = Bundle(for: type(of: self))
//        let nib = UINib(nibName: nibName, bundle: bundle)
//        return nib.instantiate(withOwner: self, options: nil).first as? UIView
//    }
//
//
//
//}
