//
//  DWVisionManager.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/12/13.
//

import Vision
import CoreImage.CIFilterBuiltins
import UIKit
import Combine

class DWImageProcess {
    static let shared = DWImageProcess()
    
    @Published var photoOutput = UIImage()

    let context = CIContext()
    let request = VNGeneratePersonSegmentationRequest()
    
    func generatePhotoGreeting(greeting: Greeting) {
        guard
            let backgroundImage = greeting.backgroundImage.cgImage,
            let foregroundImage = greeting.foregroundImage.cgImage else {
                print("Missing required images")
                return
            }
        // Create request
        request.qualityLevel = .accurate
        request.revision = VNGeneratePersonSegmentationRequestRevision1
        request.outputPixelFormat = kCVPixelFormatType_OneComponent8
        
        // Create request handler
        let requestHandler = VNImageRequestHandler(
            cgImage: foregroundImage,
            options: [:])
        
        do {
            // Process request
            try requestHandler.perform([request])
            guard let mask = request.results?.first else {
                print("Error generating person segmentation mask")
                return
            }
            
            let foreground = CIImage(cgImage: foregroundImage)
            let maskImage = CIImage(cvPixelBuffer: mask.pixelBuffer)
            let background = CIImage(cgImage: backgroundImage)
            
            guard let output = blendImages(
                background: background,
                foreground: foreground,
                mask: maskImage) else {
                    print("Error blending images")
                    return
                }
            // Update photoOutput
            if let photoResult = renderAsUIImage(output) {
                self.photoOutput = photoResult
            }
        } catch {
            print("Error processing person segmentation request")
        }
    }
    
    func blendImages(
      background: CIImage,
      foreground: CIImage,
      mask: CIImage,
      isRedMask: Bool = false
    ) -> CIImage? {
      // scale mask
      let maskScaleX = foreground.extent.width / mask.extent.width
      let maskScaleY = foreground.extent.height / mask.extent.height
      let maskScaled = mask.transformed(by: __CGAffineTransformMake(maskScaleX, 0, 0, maskScaleY, 0, 0))

      // scale background
      let backgroundScaleX = (foreground.extent.width / background.extent.width)
      let backgroundScaleY = (foreground.extent.height / background.extent.height)
      let backgroundScaled = background.transformed(
        by: __CGAffineTransformMake(backgroundScaleX, 0, 0, backgroundScaleY, 0, 0))

      let blendFilter = isRedMask ? CIFilter.blendWithRedMask() : CIFilter.blendWithMask()
      blendFilter.inputImage = foreground
      blendFilter.backgroundImage = backgroundScaled
      blendFilter.maskImage = maskScaled

      return blendFilter.outputImage
    }
    
    private func renderAsUIImage(_ image: CIImage) -> UIImage? {
      guard let cgImage = context.createCGImage(image, from: image.extent) else {
        return nil
      }
      return UIImage(cgImage: cgImage)
    }
    
    
    /// 视频流图像处理
    /// - Parameters:
    ///   - foreground: 前面显示界面
    ///   - background: 背景图
    /// - Returns: 返回
    func processVideoFrame(
      foreground: CVPixelBuffer,
      background: CGImage
    ) -> CIImage? {
      // Create request handler
      let ciForeground = CIImage(cvPixelBuffer: foreground)
      let personSegmentFilter = CIFilter.personSegmentation()
      personSegmentFilter.inputImage = ciForeground
      if let mask = personSegmentFilter.outputImage {
        guard let output = blendImages(
          background: CIImage(cgImage: background),
          foreground: ciForeground,
          mask: mask,
          isRedMask: true) else {
            print("Error blending images")
            return nil
          }
        return output
      }
      return nil
    }
    
    /// 图像合成算法
    /// - Parameters:
    ///   - foreground: 前置图片
    ///   - background: 后置图片
    ///   - filterType: 合成类型
    /// - Returns: 返回图像
    func processImageFrame(foreground: CGImage?,
                           background: CGImage?,
                           filterType: FilterType
    ) -> CIImage? {
        guard let foreground = foreground, let background = background else {
            print("Error the foreground or background")
            return nil
        }
        let ciForeground = CIImage(cgImage: foreground)
        let ciBackround = CIImage(cgImage: background)
        /// 处理前置图像
        let processImage = DWFilter.shared.filterSegment(inputImage: ciForeground, filterType: .person)
        guard let output = blendImages(background: ciBackround, foreground: ciForeground, mask: processImage) else {
            print("Errir blending images")
            return nil }
        return output
        
    }
}
