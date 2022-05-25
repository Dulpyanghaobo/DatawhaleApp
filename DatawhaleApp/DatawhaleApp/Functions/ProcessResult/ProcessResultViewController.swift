//
//  ProcessResultViewController.swift
//  DatawhaleApp
//
//  Created by Hab Yang on 2022/2/24.
//

import UIKit

class ProcessResultViewController: UIViewController {

    //MARK: UIViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.addSubview(imageView)
        self.imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }

    // MARK: - private
    private lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        return imageView
    }()
    
}
