//
//  InstructionScript.swift
//  Ocer
//
//  Created by Karin Lim on 17/06/21.
//

import Foundation

struct InstructionScript{
    private(set) var gameId: String = ""
    private(set) var orderNo: Int = 0
    private(set) var description: String = ""
    
    static func generateScript(gameId: String)->[InstructionScript]{
        var resultList: [InstructionScript] = []
        for instruction in instructionList{
            if instruction.gameId == gameId{
                resultList.append(instruction)
            }
        }
        return resultList
    }
    
    static func generateFinishScript(gameId: String)->[InstructionScript]{
        var resultList: [InstructionScript] = []
        for instruction in finishedInstructionList{
            if instruction.gameId == gameId{
                resultList.append(instruction)
            }
        }
        return resultList
    }
    
    static func getInstruction(list: [InstructionScript], orderNo: Int)-> InstructionScript{
        if orderNo != nil && orderNo > 0 && orderNo <= list.count{
            return list[orderNo-1]
        }
        else{
            return InstructionScript()
        }
    }
    
}

var instructionList: [InstructionScript] = [
    InstructionScript(gameId: "bedroom", orderNo: 1, description: "Hoahhmmmmm"),
    InstructionScript(gameId: "bedroom", orderNo: 2, description: "Udah pagi aja, Ocer masih ngantuk banget tapi"),
    InstructionScript(gameId: "bedroom", orderNo: 3, description: ". . . . ."),
    InstructionScript(gameId: "bedroom", orderNo: 4, description: "Waduh kamar Ocer kok berantakan banget ya?"),
    InstructionScript(gameId: "bedroom", orderNo: 5, description: "Beresin dulu ah sebelum pergi ke sekolah! Yuk bantuin Ocer beresin kamar! 🐒"),
//    InstructionScript(gameId: "bedroom", orderNo: 6, description: "Yayyy, kamar Ocer sudah rapi, terima kasih sudah membantu Ocer! 🌟"),
    
    InstructionScript(gameId: "toilet", orderNo: 1, description: "*sniff sniff* (merasakan bau mulut) 👃🏻"),
    InstructionScript(gameId: "toilet", orderNo: 2, description: "Aduduhh, mulut Ocer bau pisang! 🍌"),
    InstructionScript(gameId: "toilet", orderNo: 3, description: "Ocer mau sikat gigi dulu deh! 🪥"),
    InstructionScript(gameId: "toilet", orderNo: 4, description: "Bantuin Ocer mengurutkan langkah-langkah sikat gigi ya! 🦷"),
//    InstructionScript(gameId: "toilet", orderNo: 5, description: "Nah, kalau gini kan gigi Ocer wangi dan kinclong! 😁✨ Terima kasih sudah membantu Ocer! 🌟"),
    
    InstructionScript(gameId: "eat", orderNo: 1, description: "Halo, sekarang Ocer mau sarapan. Nah, tolong bantu Ocer masukan makanan ke mangkok Ocer ya! "),
    InstructionScript(gameId: "eat", orderNo: 2, description: "Bagaimana caranya?"),
    InstructionScript(gameId: "eat", orderNo: 3, description: "Masukan makanan seperti gerakan di bawah ya!  (Ada demo bergerak makanan ke mangkok)."),
    InstructionScript(gameId: "eat", orderNo: 4, description: "Nah, yang bukan makanan jangan dimasukan ke mangkok Ocer!"),
    InstructionScript(gameId: "eat", orderNo: 5, description: "Jangan sampai salah nanti Ocer sakit perut."),
    
    InstructionScript(gameId: "school", orderNo: 1, description: "Ocer sudah siap ke sekolah! Terimakasih sudah membantu Ocer membereskan tempat tidur, mandi, dan sarapan."),
    InstructionScript(gameId: "school", orderNo: 2, description: "Sekarang Ocer sudah siap ke sekolah."),
    InstructionScript(gameId: "school", orderNo: 3, description: "Tapi, Ocer lupa jalannya ke sekolah."),
    InstructionScript(gameId: "school", orderNo: 4, description: "Tolong bantu Ocer dalam menentukan jalan ke sekolah dengan cara memasukan panah yang sesuai ke kotak"),
    InstructionScript(gameId: "school", orderNo: 5, description: "Nah, kalau semua panah sudah sesuai dengan jalan yang tepat ke sekolah sekarang injak pedal ya!"),
    InstructionScript(gameId: "school", orderNo: 6, description: "Bantu menunjukan jalan yang benar ya supaya Ocer bisa ke sekolah!")
    
]

var finishedInstructionList: [InstructionScript] = [
    InstructionScript(gameId: "bedroom", orderNo: 1, description: "Yayyy, kamar Ocer sudah rapi, terima kasih sudah membantu Ocer! 🌟"),
    InstructionScript(gameId: "toilet", orderNo: 1, description: "Nah, kalau gini kan gigi Ocer wangi dan kinclong! 😁✨ Terima kasih sudah membantu Ocer! 🌟"),
]
