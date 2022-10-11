//
//  ProfileViewController.swift
//  SocialMedia-App-iOS
//
//  Created by Pavel Palancica on 10/1/22.
//

import UIKit

protocol ProfileViewControllerDelegate: AnyObject {
    
    func didTapSignupOnSignupFlowEnterEmailView(controller: ProfileViewController)
    func didTapSigninOnSignupFlowEnterEmailView(controller: ProfileViewController)
}

final class ProfileViewController: UIViewController {
    
    weak var delegate: ProfileViewControllerDelegate?

    @objc
    var signUpSuccess = false
    @objc
    var proceedToFirstUserScreen = false
    
    // MARK: - UI Properties
    
    lazy var backgroundGradientLayer = makeBackgroundGradientLayer()
    lazy var scrollView = makeScrollView()
    lazy var rootStackView = makeRootStackView()
    
    lazy var topSpaceView = makeTopSpaceView()
    lazy var titleLabel = makeTitleLabel()
    lazy var subtitleLabel = makeSubtitleLabel()
    
    lazy var emailLabel = makeEmailLabel()
    lazy var emailTextField = makeEmailTextField()
    lazy var emailBottomSeparator = makeEmailBottomSeparator()
    
    lazy var signupButton = makeSignupButton()
    
    lazy var signinStackView = makeSigninStackView()
    lazy var signinLabel = makeSigninLabel()
    lazy var signinButton = makeSigninButton()
    
    // MARK: - UI Lifecycle Methods
    
    private init() {
        fatalError("init has not been implemented")
    }
    
    init(delegate: ProfileViewControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupViews()
        setupLayoutConstraints()
        
        emailTextField.delegate = self
        scrollView.delegate = self

        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(handleScrollViewTapGesture)
        )
        scrollView.addGestureRecognizer(tapGestureRecognizer)
        
        signupButton.addTarget(self, action: #selector(handleSignupButtonTap), for: .touchUpInside)
        signinButton.addTarget(self, action: #selector(handleSigninButtonTap), for: .touchUpInside)
    }
    
    @objc
    func proceedToAccountActivationOrResetPasswordViewController() {
        
    }
}

// MARK: - UI Action Methods

private extension ProfileViewController {
    @objc
    func handleScrollViewTapGesture() {
        if emailTextField.isFirstResponder {
            emailTextField.resignFirstResponder()
        } else {
            view.endEditing(true)
        }
    }
    
    @objc
    func handleSignupButtonTap() {
        delegate?.didTapSignupOnSignupFlowEnterEmailView(controller: self)
    }
    
    @objc
    func handleSigninButtonTap() {
        delegate?.didTapSigninOnSignupFlowEnterEmailView(controller: self)
    }
}

// MARK: - UI Creation Methods

private extension ProfileViewController {
    
    func setupViews() {
        view.backgroundColor = .lightGray
        view.layer.insertSublayer(backgroundGradientLayer, at: 0) // view.layer.addSublayer(backgroundGradientLayer)
        view.addSubview(scrollView)
        scrollView.addSubview(rootStackView)
        
        rootStackView.addArrangedSubview(topSpaceView)
        rootStackView.addArrangedSubview(titleLabel)
        rootStackView.addArrangedSubview(subtitleLabel)
        rootStackView.addArrangedSubview(emailLabel)
        rootStackView.addArrangedSubview(emailTextField)
        rootStackView.addArrangedSubview(emailBottomSeparator)
        rootStackView.addArrangedSubview(signupButton)
        rootStackView.addArrangedSubview(UIView())
        rootStackView.addArrangedSubview(signinStackView)
        
        signinStackView.addArrangedSubview(UIView())
        signinStackView.addArrangedSubview(signinLabel)
        signinStackView.addArrangedSubview(signinButton)
        signinStackView.addArrangedSubview(UIView())
    }
    
    func setupLayoutConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        topSpaceView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailBottomSeparator.translatesAutoresizingMaskIntoConstraints = false
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signinStackView.translatesAutoresizingMaskIntoConstraints = false
        signinLabel.translatesAutoresizingMaskIntoConstraints = false
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            rootStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
            rootStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            rootStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -15),
            rootStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            rootStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -30),
            
            topSpaceView.heightAnchor.constraint(equalToConstant: 90),
            emailLabel.heightAnchor.constraint(equalToConstant: 30),
            emailTextField.heightAnchor.constraint(equalToConstant: 30),
            emailBottomSeparator.heightAnchor.constraint(equalToConstant: 1),
            signupButton.heightAnchor.constraint(equalToConstant: 45),
            
            signinStackView.heightAnchor.constraint(equalToConstant: 60),
            
            rootStackView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor, constant: -30)
        ])
        
        rootStackView.setCustomSpacing(15, after: titleLabel)
        rootStackView.setCustomSpacing(90, after: subtitleLabel)
        rootStackView.setCustomSpacing(60, after: emailBottomSeparator)
    }
    
    func makeBackgroundGradientLayer() -> CAGradientLayer {
        let colorTop = UIColor.orange
        let colorBottom = UIColor.blue
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        return gradientLayer
    }
    
    func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = .clear
        return scrollView
    }
    
    func makeRootStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }
    
    func makeTopSpaceView() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.text = "Create an Account"
        label.numberOfLines = 0
        return label
    }
    
    func makeSubtitleLabel() -> UILabel {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.text = "Please enter your email to start the process."
        label.numberOfLines = 0
        return label
    }
    
    func makeEmailLabel() -> UILabel {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.text = "Email"
        return label
    }
    
    func makeEmailTextField() -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.placeholder = "john.doe@gmail.com"
        return textField
    }
    
    func makeEmailBottomSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }
    
    func makeSignupButton() -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.setTitle("Sign up", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }
    
    func makeSigninStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }
    
    func makeSigninLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .right
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.text = "Have an account?"
        return label
    }
    
    func makeSigninButton() -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.contentHorizontalAlignment = .left
        button.setTitle("Sign in", for: .normal)
        return button
    }
}

// MARK: - UITextFieldDelegate Methods

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UIScrollViewDelegate Methods

extension ProfileViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if emailTextField.isFirstResponder {
            emailTextField.resignFirstResponder()
        } else {
            view.endEditing(true)
        }
    }
}
