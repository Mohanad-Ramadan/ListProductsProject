//
//  ProductCollectionViewCell.swift
//  ListProductsProject
//
//  Created by Mohanad Ramdan on 26/08/2025.
//

import UIKit
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "ProductCollectionViewCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 6)
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray6
        imageView.tintColor = .systemGray3
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.systemGray4.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 2
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .systemBlue
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .secondaryLabel
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let ratingContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        label.textColor = UIColor.secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = UIColor.systemYellow
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Layout constraints
    private var gridConstraints: [NSLayoutConstraint] = []
    private var listConstraints: [NSLayoutConstraint] = []
    private var currentAppliedLayout: LayoutType?
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        priceLabel.text = nil
        categoryLabel.text = nil
        ratingLabel.text = nil
        productImageView.image = nil
        currentAppliedLayout = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupUI() {
        setupSubviews()
        setupConstraints()
        applyLayout(.list) // set list as initial layout
    }
    
    private func setupSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(productImageView)
        containerView.addSubview(contentStackView)
        containerView.addSubview(ratingContainer)
        
        // Add rating content
        ratingContainer.addSubview(starImageView)
        ratingContainer.addSubview(ratingLabel)
    }
    
    private func setupConstraints() {
        // Container constraints
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        // Rating content constraints
        NSLayoutConstraint.activate([
            starImageView.leadingAnchor.constraint(equalTo: ratingContainer.leadingAnchor, constant: 6),
            starImageView.centerYAnchor.constraint(equalTo: ratingContainer.centerYAnchor),
            starImageView.widthAnchor.constraint(equalToConstant: 12),
            starImageView.heightAnchor.constraint(equalToConstant: 12),
            
            ratingLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 4),
            ratingLabel.trailingAnchor.constraint(lessThanOrEqualTo: ratingContainer.trailingAnchor, constant: -6),
            ratingLabel.centerYAnchor.constraint(equalTo: ratingContainer.centerYAnchor)
        ])
        
        // Fixed image size
        NSLayoutConstraint.activate([
            productImageView.widthAnchor.constraint(equalToConstant: 80),
            productImageView.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        // Grid layout constraints
        gridConstraints = [
            // Product image
            productImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            productImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            // Content stack view
            contentStackView.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 12),
            contentStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            contentStackView.leadingAnchor.constraint(greaterThanOrEqualTo: containerView.leadingAnchor, constant: 8),
            contentStackView.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -8),
            contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            
            // Rating container
            ratingContainer.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            ratingContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            ratingContainer.heightAnchor.constraint(equalToConstant: 20),
            ratingContainer.widthAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ]
        
        // List layout constraints
        listConstraints = [
            // Product image
            productImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            productImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            // Content stack view
            contentStackView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 12),
            contentStackView.trailingAnchor.constraint(equalTo: ratingContainer.leadingAnchor, constant: -12),
            contentStackView.topAnchor.constraint(equalTo: productImageView.topAnchor),
            contentStackView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -12),
            
            // Rating container
            ratingContainer.topAnchor.constraint(equalTo: contentStackView.topAnchor),
            ratingContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            ratingContainer.widthAnchor.constraint(equalToConstant: 50),
            ratingContainer.heightAnchor.constraint(equalToConstant: 20)
        ]
    }
    
    func applyLayout(_ layout: LayoutType) {
        guard currentAppliedLayout != layout else { return }
        currentAppliedLayout = layout
        
        // reset constraints
        NSLayoutConstraint.deactivate(gridConstraints)
        NSLayoutConstraint.deactivate(listConstraints)
        contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        switch layout {
        case .grid:
            contentStackView.alignment = .center
            priceLabel.textAlignment = .center
            categoryLabel.textAlignment = .center
            
            contentStackView.addArrangedSubview(priceLabel)
            contentStackView.addArrangedSubview(categoryLabel)
            
            NSLayoutConstraint.activate(gridConstraints)
            
        case .list:
            contentStackView.alignment = .leading
            titleLabel.textAlignment = .natural
            priceLabel.textAlignment = .natural
            categoryLabel.textAlignment = .natural
            
            contentStackView.addArrangedSubview(titleLabel)
            contentStackView.addArrangedSubview(priceLabel)
            contentStackView.addArrangedSubview(categoryLabel)
            
            NSLayoutConstraint.activate(listConstraints)
        }
    }
    
    // MARK: - Setup Content
    func setupContent(with product: Product) {
        titleLabel.text = product.title
        priceLabel.text = String(format: "$%.2f", product.price)
        categoryLabel.text = product.category.capitalized
        
        if let rating = product.rating?.rate {
            ratingLabel.text = String(format: "%.1f", rating)
            ratingContainer.isHidden = false
        } else {
            ratingContainer.isHidden = true
        }
        
        processProductImage(urlString: product.imageURL)
    }
    
    private func processProductImage(urlString: String?) {
        KF.url(URL(string: urlString ?? ""))
            .placeholder(UIImage(systemName: "photo"))
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .set(to: productImageView)
    }
}
