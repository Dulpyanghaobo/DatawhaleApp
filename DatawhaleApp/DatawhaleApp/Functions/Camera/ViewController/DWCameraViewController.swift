//
//  DWCameraViewController.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/12/9.
//

import UIKit

class DWCameraViewController: DWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.cameraViewModel.controllerView = self
        self.cameraViewModel.configCamera()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    let cameraViewModel = DWCameraViewModel()

}
