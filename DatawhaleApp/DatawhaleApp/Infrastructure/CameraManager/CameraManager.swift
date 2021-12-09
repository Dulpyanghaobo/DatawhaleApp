//
//  CameraManager.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/12/9.
//

import UIKit
import AVFoundation

protocol CameraManagerDelegate : NSObjectProtocol{
    func cameraCaptureManager(manager : CameraManager, didCaptureImageData imageData : NSData)
    func cameraCaptureManager(manager : CameraManager, didFailedWithError error : NSError)

}


class CameraManager: NSObject {
    
    weak var delegate : CameraManagerDelegate?
    
    // 定义相机输入源
    func configCameraSetting() {
        let lock = NSLock.init()
        lock.lock()
        self.device = camera(with: .back)
        do {
            guard let device = self.device else {
                return
            }
            input = try AVCaptureDeviceInput.init(device: device)
        } catch let error as NSError {
            input = nil
            print("Error: \(error.localizedDescription)")
            return
        }
        guard let input = input else { return  }
        if (!session.canAddInput(input)) {
            session.addInput(input)
        }
        configOutPutTypes()
        self.capturePreviewLayer = AVCaptureVideoPreviewLayer.init(session: session)
        if let conntection = self.capturePreviewLayer?.connection {
            if conntection.isVideoMirroringSupported {
                conntection.videoOrientation = .portrait
            }
        }
        self.capturePreviewLayer?.videoGravity = .resizeAspectFill
        lock.unlock()
        NotificationCenter.default.addObserver(self, selector: #selector(sessionRuntimeError), name: NSNotification.Name.AVCaptureSessionRuntimeError, object: nil)
        
        
    }
    
    /// 开启相机
    public func captureImage() {
        do {
            self.photoOutput .capturePhoto(with: self.photoSettings, delegate: self)
        } catch let error as NSError {
            
        }
    }
    
    @objc func sessionRuntimeError(notifcation : NSNotification) {
        
    }
    
    /// 定义相机输出源
    func configOutPutTypes() {
        session.beginConfiguration()
        if !self.session.outputs.contains(self.photoOutput) && self.session.canAddOutput(self.photoOutput) {
            self.session.addOutput(self.photoOutput)
        }
        photoOutput.setPreparedPhotoSettingsArray([photoSettings]) { isSuccess, error in
            
        }
        self.session.commitConfiguration()
    }
    
    
    /// 配置前置摄像头与后置摄像头
    /// - Parameter position: 方向
    /// - Returns: 返回对应摄像头
    func camera(with position : AVCaptureDevice.Position) -> AVCaptureDevice? {
        let session = AVCaptureDevice.DiscoverySession.init(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: position)
        return session.devices.filter { $0.position == position}.first
    }
    
    /// 开启相机
    func startRunningCamera() {
        DispatchQueue.main.async {
            if !self.session.isRunning {
                self.session.startRunning()
            }
        }
    }
    
    /// 关闭相机
    func stopRunningCamera() {
        DispatchQueue.main.async {
            if self.session.isRunning {
                self.session.stopRunning()
            }
        }
    }

    
    private var device : AVCaptureDevice?
    
    private let session : AVCaptureSession = {
        let session = AVCaptureSession.init()
        session.canSetSessionPreset(.high)
        return session
    } ()
    
    private var input : AVCaptureDeviceInput?
    
    let photoSettings : AVCapturePhotoSettings = {
        let photoSettings = AVCapturePhotoSettings.init(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])
        return photoSettings
    } ()
    let photoOutput : AVCapturePhotoOutput = {
        let photoOutput = AVCapturePhotoOutput.init()
        return photoOutput
    } ()
    
    var capturePreviewLayer : AVCaptureVideoPreviewLayer?


}

extension CameraManager : AVCapturePhotoCaptureDelegate
{
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            self.delegate?.cameraCaptureManager(manager: self, didFailedWithError: error as NSError)
        }
        
        let imageData = photo.fileDataRepresentation()
        if imageData != nil{
            self.delegate?.cameraCaptureManager(manager: self, didCaptureImageData: imageData! as NSData)
        }
    }
}
