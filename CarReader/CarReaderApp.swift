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



@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

let screenSize = UIScreen.main.bounds.size


func Greetings() -> String {
    let hello = ["Доброї ночі!", "Доброго ранку!", "Доброго дня", "Доброго вечора"]
    let currentDate = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: currentDate)
    return hello[((hour + 1) % 24) / 6]
}


