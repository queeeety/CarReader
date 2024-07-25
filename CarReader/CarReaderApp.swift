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


func Greetings() -> [String] {
    let hello = ["Доброї ночі!", "Доброго ранку!", "Доброго дня", "Доброго вечора"]
    let helloIcon = ["moon.stars", "sunrise","sun.max","cloud"]
    let currentDate = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: currentDate)
    return [hello[((hour + 1) % 24) / 6],
            helloIcon[((hour + 1) % 24) / 6]]
    
}


