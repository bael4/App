//
//  BaseController.swift
//  new
//
//  Created by Баэль Рыспеков on 2/5/24.
//

import UIKit

class BaseController: UIViewController {

    let layoutSetup = AppConfigs.LayoutSettings.self

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.contentInset = UIEdgeInsets(
            top: 0,
            left: layoutSetup.padding,
            bottom: 0,
            right: layoutSetup.padding
        )
        view.register(ProductCardCVCell.self, forCellWithReuseIdentifier: AppConfigs.CVCell.cardCVCell)
        view.register(LiteCell.self, forCellWithReuseIdentifier: AppConfigs.CVCell.liteCell)
        view.backgroundColor = .clear
        return view
    }()

    let indicator: UIActivityIndicatorView = {
        let indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
        indicator.color = .electricAmethyst
        indicator.isHidden = true
        return indicator
    }()

    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: AppConfigs.FontSize.large, weight: .black)
        label.textColor = .lightBlue
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        onConfigureViewController()
        onAddSubviews()
        onSetupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadCollection()
    }

   func onConfigureViewController() {

        view.backgroundColor = .whisperingLilac
     
    }

    func onAddSubviews() {

        view.addSubviews(
            collectionView,
            label,
            indicator
        )

    }

    func onSetupConstraints() {

        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

    }

    
}

extension BaseController {

    func reloadCollection() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

}
