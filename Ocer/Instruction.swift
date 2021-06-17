//
//  InstructionController.swift
//  Ocer
//
//  Created by Karin Lim on 16/06/21.
//

import Foundation
import UIKit


class Instruction: UIViewController{
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var darkView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var instructionLabel: UILabel!
    
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    }
    
    
    @IBAction func onNextTapped(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
    func animateInstruction(instruction: String){
        if let label = instructionLabel{
            for char in instruction{
//                instructionLabel.text += "\(char)"
                label.text? += "\(char)"
                RunLoop.current.run(until: Date()+0.12)
            }
        }
            
    }
    
    static func showInstructionPage(_ sender:UIViewController) {
        let instructionPage = Instruction()
        instructionPage.animateInstruction(instruction: "Hoahmmmmmmm")
        instructionPage.modalPresentationStyle = .custom

        sender.present(instructionPage, animated: true, completion: nil)
    }
}

