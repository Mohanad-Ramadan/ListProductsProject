//
//  ProductsListSkeletonView.swift
//  ListProductsProject
//
//  Created by Mohanad Ramdan on 28/08/2025.
//

import UIKit
import SkeletonView

class ProductsListSkeletonView: UIViewController {
    
    // MARK: - Properties
    private let mainContainerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var containersArray = [UIStackView]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground
        setupMainContainer()
        setupSkeletonItems()
    }
    
    private func setupMainContainer() {
        view.addSubview(mainContainerStack)
        
        NSLayoutConstraint.activate([
            mainContainerStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainContainerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainContainerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainContainerStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupSkeletonItems() {
        for _ in 0..<8 {
            let container = createSkeletonContainer()
            containersArray.append(container)
        }
        
        containersArray.forEach { mainContainerStack.addArrangedSubview($0) }
    }
    
    private func createSkeletonContainer() -> UIStackView {
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        horizontalStack.spacing = 20
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.alignment = .leading
        verticalStack.spacing = 10
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        let imageSkeleton = CustomSkeletonView()
        imageSkeleton.heightAnchor.constraint(equalToConstant: 85).isActive = true
        
        let titleSkeleton = CustomSkeletonView()
        titleSkeleton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        let subtitleSkeleton = CustomSkeletonView()
        subtitleSkeleton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // Add views to stacks
        horizontalStack.addArrangedSubview(imageSkeleton)
        horizontalStack.addArrangedSubview(verticalStack)
        
        verticalStack.addArrangedSubview(titleSkeleton)
        verticalStack.addArrangedSubview(subtitleSkeleton)
        
        // Set percentage-based widths after adding to hierarchy
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            imageSkeleton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
            titleSkeleton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
            subtitleSkeleton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4).isActive = true
        }
        
        return horizontalStack
    }
}


