//
//  CameraView.swift
//  DatawhaleApp
//
//  Created by Hab Yang on 2022/2/25.
//

import UIKit
import MetalKit

class CameraView: MTKView {
    
    public var metalCommandQueue: MTLCommandQueue!
    
    public var ciContext: CIContext!
    
    func setupMetal() {
        let device = MTLCreateSystemDefaultDevice()
        self.metalCommandQueue = device?.makeCommandQueue()
        self.device = device
        self.isPaused = true
        self.enableSetNeedsDisplay = false
        self.framebufferOnly = false
        self.ciContext = CIContext(mtlDevice: device!)
    }

}
