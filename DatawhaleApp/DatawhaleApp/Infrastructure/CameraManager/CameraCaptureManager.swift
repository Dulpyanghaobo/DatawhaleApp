//
//  CameraManager.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/12/9.
//

import UIKit
import AVFoundation

protocol CameraCaptureManagerDelegate : NSObjectProtocol{
    func cameraCaptureManager(manager : CameraCaptureManager, didCaptureImageData imageData : NSData)
    func cameraCaptureManager(manager : CameraCaptureManager, didFailedWithError error : NSError)
    /// 视频帧捕获数据
    func cameraVideoSample(manager: CameraCaptureManager, image: CIImage?)
}

/// 相机
class CameraCaptureManager: NSObject {
        
    weak var delegate : CameraCaptureManagerDelegate?
    
    // 定义相机输入源
    func configCameraSetting() {
        let lock = NSLock.init()
        lock.lock()
        self.device = camera(with: .front)
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
        if (session.canAddInput(input) && !session.inputs.contains(input)) {
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
            self.photoOutput.capturePhoto(with: self.photoSettings, delegate: self)
        } catch let _ as NSError {
            
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
        if !self.session.outputs.contains(self.videoOutput) && self.session.canAddOutput(self.videoOutput) {
            self.session.addOutput(self.videoOutput)
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
    let videoOutput : AVCaptureVideoDataOutput = {
        let videoOutput = AVCaptureVideoDataOutput.init()
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as AnyHashable as! String :NSNumber(value: kCVPixelFormatType_32BGRA)]
        return videoOutput
    } ()
    var capturePreviewLayer : AVCaptureVideoPreviewLayer?
}

extension CameraCaptureManager : AVCapturePhotoCaptureDelegate
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

extension CameraCaptureManager: AVCaptureVideoDataOutputSampleBufferDelegate
{
    /// 获取捕获数据
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
      // Grab the pixelbuffer frame from the camera output
      guard
        let pixelBuffer = sampleBuffer.imageBuffer,
        let backgroundImage = UIImage.creatImageWithColor(color: UIColor.white)?.cgImage else {
        return
      }
      DispatchQueue.global().async {
          if let output = DWImageProcess.shared.processVideoFrame(foreground: pixelBuffer, background: backgroundImage) {
              DispatchQueue.main.async {
                  self.delegate?.cameraVideoSample(manager: self, image: output)
              }
          }
      }
    }

}
