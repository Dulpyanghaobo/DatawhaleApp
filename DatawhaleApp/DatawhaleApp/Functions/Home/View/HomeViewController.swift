//
//  DWHomeViewController.swift
//  DatawhaleApp
//
//  Created by 杨皓博 on 2021/11/14.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    @objc func click() {
        
    }
    private let collectionView : UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = UIColor.lightGray6()
        // 确定接收器在其超视图边界更改时如何调整自身大小
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.alwaysBounceVertical = true
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        collectionView.dg_addPullToRefreshWithActionHandler({
            () -> Void in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
                   collectionView.dg_stopLoading()
               })
        }, loadingView: loadingView)
        collectionView.dg_setPullToRefreshFillColor(UIColor.brandBlue())
        collectionView.dg_setPullToRefreshBackgroundColor(collectionView.backgroundColor!)
        collectionView.register(DWHomeBoardCell.self, forCellWithReuseIdentifier: DWHomeBoardCell.reuseIdentifier)
        return collectionView
    } ()
    deinit {
        collectionView.dg_removePullToRefresh()
    }

}

extension HomeViewController
{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource
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


