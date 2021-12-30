//
//  DWCameraViewController.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/12/9.
//

import UIKit

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
    }
    
    
    let cameraViewModel = DWCameraViewModel()

}
