//
//  ArrowSquare.swift
//  Ocer
//
//  Created by Antony Susanto on 09/06/21.
//

import UIKit

class ArrowSquare: UIView {

    
    @IBOutlet weak var img: UIImageView!
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
            guard let view = loadViewFromNib() else { return }
            view.frame = self.bounds
            self.addSubview(view)
        }
        
        func loadViewFromNib() -> UIView? {
            let nib = UINib(nibName: "ArrowSquare", bundle: nil)
            return nib.instantiate(withOwner: self, options: nil).first as? UIView
        }

}
