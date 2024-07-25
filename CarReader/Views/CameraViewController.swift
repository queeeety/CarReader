//
//  CameraViewController.swift
//  CarReader
//
//  Created by Тимофій Безверхий on 09.07.2024.
//

import AVFoundation
import Vision
import UIKit

class MyCameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var lastProcessedTime = Date()
    private let frameProcessingInterval: TimeInterval = 1.0 // Interval in seconds
    var onTextRecognized: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCamera()
    }
    
    func setupCamera() {
        captureSession = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            return
        }
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(videoOutput)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        let currentTime = Date()
        if currentTime.timeIntervalSince(lastProcessedTime) >= frameProcessingInterval {
            lastProcessedTime = currentTime
            guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
            
            let request = VNRecognizeTextRequest { [weak self] (request, error) in
                guard let self = self else { return }
                guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
                
                for observation in observations {
                    guard let candidate = observation.topCandidates(1).first else { continue }
                    var recognizedString = candidate.string
                    
                    let isPropperNumber = NumberCheck(inputStr: recognizedString)

                    if (isPropperNumber) {
                        // Stop the capture session and return the recognized string
                        self.captureSession.stopRunning()
                        recognizedString.removeAll{ $0 == " " }
                        self.onTextRecognized?(recognizedString)
                        return
                    }
                }
            }
            request.recognitionLevel = .accurate
            
            let requestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
            try? requestHandler.perform([request])
        }
    }
    
    func NumberCheck (inputStr: String) -> Bool{
        let str = inputStr.replacingOccurrences(of: " ", with: "")
        if (str.count == 8
            && str.prefix(2).allSatisfy({$0.isLetter})
            && str.suffix(2).allSatisfy({$0.isLetter})
            && str.dropFirst(2).prefix(4).allSatisfy({$0.isNumber})
        ){
            return true
        }
        else{
            return false
        }
        
    }
}
