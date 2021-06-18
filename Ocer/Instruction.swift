//
//  InstructionController.swift
//  Ocer
//
//  Created by Karin Lim on 16/06/21.
//

import Foundation
import UIKit
import AVFoundation
import GhostTypewriter

class Instruction: UIViewController{
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var darkView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var instructionLabel: TypewriterLabel!
    
    var setting = Setting()
    var instructionList: [InstructionScript]!
    
    var currOrderNo: Int = 0{
        didSet{
            animateInstruction(orderNo: currOrderNo)
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        currOrderNo = 1
    }
    
    
    @IBAction func onNextTapped(_ sender: Any) {
        self.dismiss(animated: true) {
            Setting.normalizeVolume()
        }
    }
    
    
    func animateInstruction(orderNo: Int){
        if orderNo > instructionList.count {
            return
        }
        let script = instructionList[orderNo - 1]
        var instruction = ""
        instruction = script.description
        
        if let label = instructionLabel{
            label.text? = instruction
            setting.playInstructionSound(fileName: "\(script.gameId)" + "_" + "\(script.orderNo)") {
                Setting.normalizeVolume()
            }
            label.startTypewritingAnimation {
                self.currOrderNo += 1
            }
        }
    }
    
    static func showFinishInstructionPage(_ sender:UIViewController, gameId: String){
        let instructionPage = Instruction()
        instructionPage.instructionList = InstructionScript.generateFinishScript(gameId: gameId)
        if instructionPage.instructionList.count == 0 {
            return
        }
        instructionPage.modalPresentationStyle = .custom
        sender.present(instructionPage, animated: true, completion: nil)
    }
    
    static func showInstructionPage(_ sender:UIViewController, gameId: String) {
        let instructionPage = Instruction()
        instructionPage.instructionList = InstructionScript.generateScript(gameId: gameId)
        instructionPage.modalPresentationStyle = .custom
        sender.present(instructionPage, animated: true, completion: nil)
    }
}

