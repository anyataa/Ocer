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
        if orderNo > 0 && orderNo <= list.count{
            return list[orderNo-1]
        }
        else{
            return InstructionScript()
        }
    }
    
}

var instructionList: [InstructionScript] = [
    InstructionScript(gameId: "bedroom", orderNo: 1, description: "Hoahmm… 🥱\n Udah pagi aja, Ocer masih ngantuk nih! 💤\n ……"),
    InstructionScript(gameId: "bedroom", orderNo: 2, description: "Waduh kamar Ocer berantakan banget ya?"),
    InstructionScript(gameId: "bedroom", orderNo: 3, description: "Beresin dulu yuk sebelum pergi ke sekolah!"),
    InstructionScript(gameId: "bedroom", orderNo: 4, description: "Teman, yuk bantuin Ocer beresin kamar! 🐒"),
    InstructionScript(gameId: "bedroom", orderNo: 5, description: "Bantu Ocer meletakan benda sesuai bentuknya ya, Teman!"),
//    InstructionScript(gameId: "bedroom", orderNo: 6, description: "Yayyy, kamar Ocer sudah rapi, terima kasih sudah membantu Ocer! 🌟"),
    
    InstructionScript(gameId: "toilet", orderNo: 1, description: "👃🏻 Aduh, mulut Ocer bau pisang banget nih karena baru bangun tidur!🍌"),
    InstructionScript(gameId: "toilet", orderNo: 2, description: "Kalo gitu Ocer mau sikat gigi dulu deh! 🪥"),
    InstructionScript(gameId: "toilet", orderNo: 3, description: "Teman! Bantuin Ocer mengurutkan langkah-langkah sikat gigi ya! 🦷"),
    InstructionScript(gameId: "toilet", orderNo: 4, description: "Biar Ocer mulutnya bisa bersih dan ga bau lagi"),
    InstructionScript(gameId: "toilet", orderNo: 5, description: "Teman! kamu bisa tahan gambar ke kotak sesuai urutan langkah sikat gigi ya!"),
    InstructionScript(gameId: "toilet", orderNo: 6, description: "Setelah itu letakkan gambar ke kotak secara berurutan!"),
    InstructionScript(gameId: "toilet", orderNo: 7, description: "Teman, kamu pasti bisa! Semangat ya"),
    
    InstructionScript(gameId: "eat", orderNo: 1, description: "Halo, sekarang Ocer mau sarapan. Bantu Ocer masukan makanan ke mangkok Ocer ya! "),
    InstructionScript(gameId: "eat", orderNo: 2, description: "Bagaimana caranya?\n Mudah kok, masukan aja makanan ke mangkuk Ocer ya!"),
    InstructionScript(gameId: "eat", orderNo: 3, description: "Nah, yang bukan makanan jangan dimasukan ke mangkok Ocer!"),
    InstructionScript(gameId: "eat", orderNo: 4, description: "Jangan sampai salah ya, Teman!\n Nanti Ocer bisa sakit perut..."),
    
    InstructionScript(gameId: "school", orderNo: 1, description: "Terima kasih sudah membantu Ocer membereskan tempat tidur, mandi, dan sarapan."),
    InstructionScript(gameId: "school", orderNo: 2, description: "Sekarang Ocer sudah siap ke sekolah. Tapi, Ocer lupa jalan ke sekolah."),
    InstructionScript(gameId: "school", orderNo: 3, description: "Teman, tolong bantu Ocer menentukan jalan ke sekolah ya..."),
    InstructionScript(gameId: "school", orderNo: 4, description: "Caranya masukan panah ke kotak berdasarkan arah yang sesuai untuk ditempuh mobil."),
    InstructionScript(gameId: "school", orderNo: 5, description: "Sekarang kalau semua kotak panah di jalan sudah terisi untuk menunjukan jalan ke sekolah,"),
    InstructionScript(gameId: "school", orderNo: 6, description: "Kamu sekarang bisa tekan tombol di kanan bawah supaya mobilnya bisa jalan!"),
    InstructionScript(gameId: "school", orderNo: 7, description: "Nah, bantu menunjukan jalan yang benar ke Ocer ya supaya Ocer bisa ke sekolah nih!")
    
]

var finishedInstructionList: [InstructionScript] = [
    InstructionScript(gameId: "bedroom", orderNo: 1, description: "Yayyy, kamar Ocer sudah rapi, terima kasih sudah membantu Ocer! 🌟"),
    InstructionScript(gameId: "toilet", orderNo: 1, description: "Nah, kalau gini kan gigi Ocer wangi dan kinclong! 😁✨ Terima kasih sudah membantu Ocer! 🌟"),
]
