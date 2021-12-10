//
//  DWCameraViewModel.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/12/9.
//

import Foundation
import AVFoundation

protocol DWCameraViewModelProtocol {
    
}

class DWCameraViewModel : NSObject {
    
    weak var controllerView : UIViewController!
    
    func configCamera() {
        AVCaptureDevice.requestAccess(for: .video) { grant in
            if grant {
                self.cameraCaptureManager.configCameraSetting()
                DispatchQueue.main.async {
                    self.cameraCaptureManager.capturePreviewLayer?.frame = self.controllerView.view.bounds
                    self.controllerView.view.layer.insertSublayer(self.cameraCaptureManager.capturePreviewLayer!, below: self.controllerView.view.layer.sublayers?.first)
                    self.cameraCaptureManager.startRunningCamera()
                }
            }
        }
        
        self.cameraCaptureManager.delegate = self
    }
    
    private let cameraCaptureManager : CameraCaptureManager = {
        let cameraCaputureManager = CameraCaptureManager()
        return cameraCaputureManager
    }()
}

extension DWCameraViewModel : CameraCaptureManagerDelegate
{
    func cameraCaptureManager(manager: CameraCaptureManager, didCaptureImageData imageData: NSData) {
        
    }
    
    func cameraCaptureManager(manager: CameraCaptureManager, didFailedWithError error: NSError) {
        
    }
    
    
}
