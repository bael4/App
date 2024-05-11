//
//  FavoritesViewController.swift
//  new
//
//  Created by Баэль Рыспеков on 2/5/24.
//

import UIKit
import DeviceKit

class FavoritesProductListViewController: BaseController {

    private let viewModel = FavoritesViewModel.shared
    
    override func onConfigureViewController() {
        super.onConfigureViewController()
        viewModel.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getFavoriteProducts()
    }

}

extension FavoritesProductListViewController:
    FavoritesViewModelDelegate,
    ProductCardCVCellDelegate
{

    func updateCollection() {

        if viewModel.products.isEmpty {
            label.isHidden = false
            label.text = "No result"
        } else {
            label.isHidden = true
        }

        reloadCollection()

    }
    
    
    func cellTapped(at indexPath: IndexPath) {

         let product = viewModel.products[indexPath.row]
         let controller = ProductDetailsController(product: product, viewModel: viewModel)
         navigationController?.pushViewController(controller, animated: true)

     }

     func configureCell(at cell: ProductCardCVCell,at indexPath: IndexPath) {

         cell.setupCell(product: viewModel.products[indexPath.row])
         cell.delegate = self

     }

     func didTapFavoriteButton(at id: Int?) {

         guard let id = id else { return }
         
         viewModel.toogleFavourite(at: id)

     }

    func someWrong() {}

}

extension FavoritesProductListViewController:
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout
{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        viewModel.products.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConfigs.CVCell.cardCVCell, for: indexPath) as? ProductCardCVCell else { fatalError("Can not create CardCVCell ")}
        
        configureCell(at: cell, at: indexPath)
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        cellTapped(at: indexPath)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {


        let contentInsets = collectionView.contentInset
        let totalContentWidth = collectionView.bounds.width - (contentInsets.left + contentInsets.right)

        let numberOfColumns: CGFloat
        numberOfColumns = 2

        let spacingBetweenCells: CGFloat = 16
        let totalSpacing = spacingBetweenCells * (numberOfColumns - 1)
        let widthForItem = (totalContentWidth - totalSpacing) / numberOfColumns
        let height: CGFloat = collectionView.bounds.height/3.2

        return CGSize(width: widthForItem, height: height)

    }

}
