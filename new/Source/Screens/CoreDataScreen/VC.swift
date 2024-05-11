//
//  VC.swift
//  new
//
//  Created by Баэль Рыспеков on 11/5/24.
//

import UIKit
import CoreData

final class ViewController: BaseController {

    let viewModel = VCViewModel.shared

    override func onConfigureViewController() {
        super.onConfigureViewController()

        collectionView.delegate = self
        collectionView.dataSource = self

        DispatchQueue.global().async{
            self.viewModel.fetchData()
        }

        viewModel.delegate = self

    }
    
}

extension ViewController:
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout
{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        viewModel.items.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConfigs.CVCell.liteCell, for: indexPath) as? LiteCell else { fatalError("Can not create CardCVCell ")}
        
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

extension ViewController: VCViewModelDelegate, VcCardCVCellDelegate {
    
    func didTapFavoriteButton(at id: LiteCell) {
        guard let indexPath = collectionView.indexPath(for: id) else { return }
        viewModel.coredataManager.toggleSelectionForItem(
            withID: Int(viewModel.items[indexPath.row].id)
        )
        let a = viewModel.coredataManager.fetchAllFavorites()
        print(a)
        DispatchQueue.main.async {
            self.reloadCollection()
        }
    }
    
    
    private func cellTapped(at indexPath: IndexPath) {

         let product = viewModel.items[indexPath.row]
//         let controller = ProductDetailsController(product: product, viewModel: viewModel)
//         navigationController?.pushViewController(controller, animated: true)

     }
    
    func configureCell(at cell: LiteCell,at indexPath: IndexPath) {

        cell.setupCell(product: viewModel.items[indexPath.row])
        cell.delegate = self
   
    }

    func didUpdate() {
        reloadCollection()
    }

}

