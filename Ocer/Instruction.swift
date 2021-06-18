//
//  InstructionController.swift
//  Ocer
//
//  Created by Karin Lim on 16/06/21.
//

import Foundation
import UIKit
import AVFoundation

class Instruction: UIViewController{
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var darkView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var instructionLabel: UILabel!
    
    var shouldKeepRunning: Bool = false
    var instructionList: [InstructionScript]!
//    var finishInstructionList: [InstructionScript]!
    var currOrderNo: Int = 0{
        didSet{
//            instructionLabel.text = ""
            animateInstruction(orderNo: currOrderNo)
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        currOrderNo = 1
//        animateInstruction(orderNo: currOrderNo)
    }
    
    
    @IBAction func onNextTapped(_ sender: Any) {
//        shouldKeepRunning = false
        if(currOrderNo < instructionList.count){
            instructionLabel.text = ""
            currOrderNo += 1
//            animateInstruction(orderNo: currOrderNo)
        }
        else{
            self.dismiss(animated: true) {
                
            }
        }
        
    }
    
    func animateInstruction(orderNo: Int){
        print("\(orderNo)")
        if orderNo > instructionList.count {return}
        let script = instructionList[orderNo - 1]
        var instruction = ""
        instruction = script.description
        if let label = instructionLabel{
//            shouldKeepRunning = true
            label.text? = ""
            Setting.playSoundEffect(fileName: "\(script.gameId)" + "_" + "\(script.orderNo)")
            for char in instruction{
//                instructionLabel.text += "\(char)"
                label.text? += "\(char)"
                RunLoop.current.run(until: Date() + 0.08)
                
//                let runLoop = RunLoop.current
//                while (shouldKeepRunning && runLoop.run(mode: .tracking, before: Date() - Setting.effectPlayer.duration)) {
//                }
            }
        }
        currOrderNo+=1
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
//        instructionPage.finishInstructionList = InstructionScript.generateFinishScript(gameId: gameId)
        instructionPage.modalPresentationStyle = .custom
        sender.present(instructionPage, animated: true, completion: nil)
    }
}

