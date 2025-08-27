//
//  Toast.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 09/05/2024.
//

import UIKit

class Toast: UIView {
    
    //MARK: Declare Variables
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var parentView: UIView?
    private var dismissTimer: Timer?
    private var isCurrentlyShowing = false
    
    static let shared = Toast()
    
    //MARK: - Initialization
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Toast
    private func setupToast(alertType: ToastType) {
        backgroundColor = .clear
        
        configureViews()
        applyConstraints()
        
        switch alertType {
        case .error(let errorMessage):
            initErrorAlert(message: errorMessage)
        }
    }
    
    //MARK: - Setup View
    private func configureViews() {
        addSubview(containerView)
        containerView.addSubview(stackView)
        
        // Add subviews to stack view
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(messageLabel)
        
        // Set icon constraints
        iconImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    //MARK: - Setup Alert Types
    private func initErrorAlert(message: String) {
        messageLabel.text = message
        containerView.backgroundColor = UIColor.systemRed.withAlphaComponent(0.9)
        containerView.layer.shadowColor = UIColor.red.withAlphaComponent(0.3).cgColor
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        
        iconImageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
        iconImageView.tintColor = .white
        
        configureTapGesture()
        autoDismiss()
    }
    
    //MARK: - Show and Dismiss
    private func show(in parentView: UIView) {
        guard !isCurrentlyShowing else { return }
        
        self.parentView = parentView
        parentView.addSubview(self)
        isCurrentlyShowing = true
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        // Animate in
        alpha = 0
        transform = CGAffineTransform(translationX: 0, y: 50)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.alpha = 1
            self.transform = .identity
        }
    }
    
    @objc private func dismissToast() {
        dismissCurrentToast()
    }
    
    private func dismissCurrentToast() {
        dismissTimer?.invalidate()
        dismissTimer = nil
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(translationX: 0, y: 50)
        }) { _ in
            self.removeFromSuperview()
            self.isCurrentlyShowing = false
            self.parentView = nil
        }
    }
    
    private func configureTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissToast))
        containerView.addGestureRecognizer(tap)
    }
    
    private func autoDismiss() {
        dismissTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { [weak self] _ in
            self?.dismissToast()
        }
    }
    
    //MARK: - Constraints
    private func applyConstraints(){
        NSLayoutConstraint.activate([
            // containerView constraints
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            // stackView constraints
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
    }
}
 
//MARK: - Alert Cases
enum ToastType {
    case error(errorMessage: String)
}

//MARK: - Present Initializer
extension Toast {
    static func showError(_ message: String, in parentView: UIView) {
        let toast = Toast.shared
        toast.setupToast(alertType: .error(errorMessage: message))
        toast.show(in: parentView)
    }
}
