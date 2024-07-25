//
//  CarReaderApp.swift
//  CarReader
//
//  Created by Тимофій Безверхий on 09.07.2024.
//

import SwiftUI
import SwiftData
import Vision
import AVFoundation
import Foundation
import Firebase
import FirebaseFirestore


@main
struct CarReaderApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var carHistoryManager = CarHistoryFileManager()
//    init(){
//        FirebaseApp.configure()
//    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(carHistoryManager)
        }
    }
}
let screenSize = UIScreen.main.bounds.size

extension Color {
    func toRGB() -> (red: Int, green: Int, blue: Int) {
        let components = UIColor(self).cgColor.components
        guard let r = components?[0], let g = components?[1], let b = components?[2] else {
            return (red: Int(0), green: Int(0), blue: Int(0))
        }
        return (red: Int(r * 255), green: Int(g * 255), blue: Int(b * 255))
    }
}

func Greetings() -> [String] {
    let hello = ["Доброї ночі!", "Доброго ранку!", "Доброго дня", "Доброго вечора"]
    let helloIcon = ["moon.stars", "sunrise","sun.max","cloud"]
    let currentDate = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: currentDate)
    return [hello[((hour + 1) % 24) / 6],
            helloIcon[((hour + 1) % 24) / 6]]
    
}


func ColorChange (endColor: Color, output: Binding<Color>) async {
    let endColors = endColor.toRGB()
    var outColors = output.wrappedValue.toRGB()
    while endColors.red != outColors.red || endColors.blue != outColors.blue || endColors.green != outColors.green {
        outColors.red = outColors.red > endColors.red ? outColors.red - 1 :
        (outColors.red < endColors.red ? outColors.red + 1 : outColors.red)
        
        outColors.green = outColors.green > endColors.green ? outColors.green - 1 :
        (outColors.green < endColors.green ? outColors.green + 1 : outColors.green)
        
        outColors.blue = outColors.blue > endColors.blue ? outColors.blue - 1 :
        (outColors.blue < endColors.blue ? outColors.blue + 1 : outColors.blue)
    }
}



