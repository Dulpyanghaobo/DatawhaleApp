//
//  DWCameraViewController.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/12/9.
//

import UIKit
import MetalKit

class DWCameraViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.cameraViewModel.controllerView = self
        setUpView()
        self.cameraViewModel.configCamera()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setUpView() {
        self.view.backgroundColor = .black
        view.addSubview(self.cameraView)
        cameraView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
    }
    
    
    let cameraViewModel = DWCameraViewModel()

    // MARK: - private
    private lazy var albumButton: UIButton = {
        var button = UIButton.init(type: .custom)
//        button.setImage(UIImage.init(systemName: <#T##String#>), for: <#T##UIControl.State#>)
        return button
    }()
    
    lazy private var cameraView: CameraView = {
        var cameraView = CameraView.init()
        cameraView.setupMetal()
        cameraView.delegate = self
        return cameraView
    }()
    
}

extension DWCameraViewController: MTKViewDelegate
{
    func draw(in view: MTKView) {
      guard
        let commandBuffer = self.cameraView.metalCommandQueue.makeCommandBuffer(),
        let ciImage = cameraViewModel.currentImage,
        let currentDrawable = view.currentDrawable else {
        return
      }

      let drawSize = cameraView.drawableSize
      let scaleX = drawSize.width / ciImage.extent.width
      let scaleY = drawSize.height / ciImage.extent.height

      let newImage = ciImage.transformed(by: .init(scaleX: scaleX, y: scaleY))
      // render into the metal texture
        self.cameraView.ciContext.render(
        newImage,
        to: currentDrawable.texture,
        commandBuffer: commandBuffer,
        bounds: newImage.extent,
        colorSpace: CGColorSpaceCreateDeviceRGB())

      // register drawable to command buffer
      commandBuffer.present(currentDrawable)
      commandBuffer.commit()
    }

    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
      // No-op
    }
}
