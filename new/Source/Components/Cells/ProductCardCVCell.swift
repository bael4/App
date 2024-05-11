//
//  CardCVCell.swift
//  new
//
//  Created by Баэль Рыспеков on 2/5/24.
//

import UIKit
import Kingfisher
import DeviceKit

final class ProductCardCVCell: BaseCVCell {
    
    private let container = BaseView()
    
    private let imageView = BaseImageView()

    let favoriteButton = FavoriteButton()

    private let categoryabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: AppConfigs.FontSize.small, weight: .medium)
        label.textColor = .black
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: AppConfigs.FontSize.small, weight: .bold)
        label.textColor = .black
        return label
    }()

    private let rateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: AppConfigs.FontSize.small, weight: .black)
        label.textColor = .white
        return label
    }()

    private var idProduct: Int?
    
    weak var delegate: ProductCardCVCellDelegate?

    override func onConfigureCell() {

        setUpButtonActions()

    }
    
    override func onAddSubViews() {
        
        addSubview(container)

        container.addSubviews(
            imageView,
            favoriteButton,
            categoryabel,
            priceLabel,
            rateLabel
        )

    }

    override func onSetupConstraints() {

        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(layoutSetup.imageCellPadding)
            make.height.equalToSuperview().multipliedBy(Device.current.isPad ? 0.6 : 0.4)
        }

        favoriteButton.snp.makeConstraints { make in
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-layoutSetup.paddinSpecial)
        }

        categoryabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(layoutSetup.textCellPadding)
            make.leading.equalTo(layoutSetup.imageCellPadding)
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryabel.snp.bottom)
            make.leading.equalTo(layoutSetup.imageCellPadding)
        }

        rateLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom)
            make.leading.equalTo(layoutSetup.imageCellPadding)
        }

    }

    func setupCell(product: ProductModelRealm) {
        
        idProduct = product.id

        if let urlImage = product.image {

            imageView.kf.setImage(with: URL(string: urlImage))

        }

        DispatchQueue.main.async {
            self.favoriteButton.setImage(UIImage(systemName: product.isFavorite ? "heart.fill" : "heart")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: self.layoutSetup.iconSizeCard)), for: .normal
            )
        }

        categoryabel.text = product.category

        if let price = product.price, let rating = product.rating?.rate {
            self.priceLabel.text = "\(price)$"
            self.rateLabel.text = "\(rating)✨"
        }

    }

    func setUpButtonActions() {
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }

    @objc private func favoriteButtonTapped() {

        delegate?.didTapFavoriteButton(at: idProduct)

    }

}
