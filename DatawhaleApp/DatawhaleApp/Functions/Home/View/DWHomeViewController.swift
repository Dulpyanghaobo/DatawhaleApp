//
//  DWHomeViewController.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/11/14.
//

import UIKit

class DWHomeViewController: DWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    private let collectionView : UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        collectionView.backgroundColor = UIColor.lightGray6()
        collectionView.bounces = true
        collectionView.register(DWHomeBoardCell.self, forCellWithReuseIdentifier: DWHomeBoardCell.reuseIdentifier)
        return collectionView
    } ()
    
}

extension DWHomeViewController : UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return DWHomeBoardCell.size
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DWHomeBoardCell.reuseIdentifier, for: indexPath) as? DWHomeBoardCell else {
            fatalError()
        }
        return cell
        
    }
}
