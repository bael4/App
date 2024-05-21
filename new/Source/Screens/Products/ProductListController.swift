//
//  ViewController.swift
//  new
//
//  Created by Баэль Рыспеков on 29/4/24.
//

import UIKit
import DeviceKit

final class ProductListController: BaseController {

    private let viewModel = ProductViewModel.shared

    override func onConfigureViewController() {
        super.onConfigureViewController()
        viewModel.delegate = self
        viewModel.fetchProducts()
        collectionView.delegate = self
        collectionView.dataSource = self
        
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Title"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let sm = Some()
        print(sm.quickSort([6, 3, 8]))
    }

}

class Some {
    func binarySearch(array: [Int], num: Int) -> Int? {

        var left = 0
        var right = array.count - 1
    
        while left <= right {
            let mid = (left+right) / 2
            print(mid)
            if array[mid] == num {
                return num
            } else if array[mid] < num {
                right = mid + 1
            } else {
                left = mid - 1
            }
        }
        return nil
    }
    
    func quickSort(_ array: [Int]) -> [Int] {
        if array.count <= 1 {
            return array
        }
        
        let pivot = array[array.count / 2]
        print("\(pivot) pivot")
        let less = array.filter { $0 < pivot }
        print("\(less) less")
        let equal = array.filter { $0 == pivot }
        print("\(equal) equal")
        let greater = array.filter { $0 > pivot }
        print("\(greater) greator")
        print(quickSort(less) + equal + quickSort(greater))
        return quickSort(less) + equal + quickSort(greater)
    }

}


extension ProductListController:
    ProductViewModelDelegate,
    ProductCardCVCellDelegate
{

   private func cellTapped(at indexPath: IndexPath) {

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

    func updateCollection() {
        DispatchQueue.main.async {
            if self.viewModel.products.isEmpty {
                self.indicator.startAnimating()
                self.indicator.isHidden = false
            } else {
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
            }
        }
       reloadCollection()
    }

    func handleError(_ error: String) {
        DispatchQueue.main.async {
            self.indicator.startAnimating()
            self.indicator.isHidden = false
            UIAlertController.showAlert(
                title: "",
                message: error,
                actionTitle: "Ok",
                presentingViewController: self
            )
        }
    }

}

extension ProductListController:
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
