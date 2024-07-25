//
//  CameraView.swift
//  CarReader
//
//  Created by Тимофій Безверхий on 09.07.2024.
//

import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    @Binding var recognizedText: String?
    
    func makeUIViewController(context: Context) -> MyCameraViewController {
            let controller = MyCameraViewController()
            controller.onTextRecognized = { text in
                self.recognizedText = text
            }
            return controller
    }
    
    func updateUIViewController(_ uiViewController: MyCameraViewController, context: Context) {}
}
