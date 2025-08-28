//
//  CustomSkeletonView.swift
//  ListProductsProject
//
//  Created by Mohanad Ramdan on 28/08/2025.
//

import UIKit

class CustomSkeletonView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        isSkeletonable = true
        showAnimatedGradientSkeleton()
    }
    
    convenience init(){
        self.init(frame: .zero)
        layer.cornerRadius = 3
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {fatalError()}
}
