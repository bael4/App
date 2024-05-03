//
//  ProductDetails.swift
//  new
//
//  Created by Баэль Рыспеков on 2/5/24.
//

import UIKit
import DeviceKit

class ProductDetailsController: UIViewController {

    private let layoutSetup = AppConfigs.LayoutSettings.self

    private let container = BaseView()

    private let imageView = BaseImageView()

    private let favoriteButton = FavoriteButton()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: AppConfigs.FontSize.medium, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: AppConfigs.FontSize.large, weight: .bold)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: AppConfigs.FontSize.small, weight: .medium)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: AppConfigs.FontSize.medium, weight: .black)
        label.textColor = .lightBlue
        label.textAlignment = .left
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: AppConfigs.FontSize.medium, weight: .medium)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    private var product: ProductModel
    private var viewModel: ViewModel

    init(product: ProductModel, viewModel: ViewModel) {
        self.product = product
        self.viewModel = viewModel
        super.init(nibName: .none, bundle: .none)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onConfigureViewController()
        onAddSubviews()
        onSetupConstraints()
        onConfigureButtonActions()
    }

    private func onConfigureViewController() {

        view.backgroundColor = .whisperingLilac
        
        if let urlImage = product.image {
            imageView.kf.setImage(with: URL(string: urlImage))
        }
        
        if
            let title = product.title,
            let description = product.descriptionProduct,
            let rate = product.rating?.rate,
            let price = product.price,
            let count = product.rating?.count
        {
            titleLabel.text = title
            descriptionLabel.text = description
            priceLabel.text = "\(price)$"
            ratingLabel.text = "\(rate)✨"
            countLabel.text = "amount \(count)"
        }

        DispatchQueue.main.async {
            self.favoriteButton.setImage(UIImage(systemName: self.product.isFavorite ? "heart.fill" : "heart")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: self.layoutSetup.iconSizeCard)), for: .normal
            )
        }
        
    }

    private func onAddSubviews() {

        view.addSubviews(
            container,
            favoriteButton,
            titleLabel,
            priceLabel,
            ratingLabel,
            countLabel,
            descriptionLabel
        )

        container.addSubview(imageView)

    }

    private func onSetupConstraints() {

        container.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(layoutSetup.detailsPadding)
            make.height.equalToSuperview().multipliedBy(Device.current.isPad ? 0.6 : 0.4)
        }

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }

        favoriteButton.snp.makeConstraints { make in
            make.trailing.equalTo(imageView.snp.trailing)
            make.bottom.equalTo(imageView.snp.bottom).offset(-10)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(container.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(layoutSetup.detailsPadding)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(layoutSetup.detailsPadding)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
            make.leading.equalTo(layoutSetup.detailsPadding)
        }
        
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel.snp.bottom).offset(5)
            make.leading.equalTo(layoutSetup.detailsPadding)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.bottom).offset(layoutSetup.paddinSpecial)
            make.leading.trailing.equalToSuperview().inset(layoutSetup.paddinSpecial)
        }

    }

    func onConfigureButtonActions() {
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }

    @objc private func favoriteButtonTapped() {

        let id = product.id

        viewModel.toogleFavourite(at: id)

        guard let product = viewModel.getProducts().first(where: { $0.id == id }) else { return }

        DispatchQueue.main.async {
            self.favoriteButton.setImage(
                UIImage(systemName: product.isFavorite ? "heart.fill" : "heart")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: self.layoutSetup.iconSizeDetails)),
                for: .normal
            )
        }

    }

}
