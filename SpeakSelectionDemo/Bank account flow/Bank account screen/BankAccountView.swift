//
//  BankAccountView.swift
//  SpeakSelectionDemo
//
//  Created by Adam Niepokój on 12/06/2021.
//

import UIKit

/// A bank account view.
final class BankAccountView: UIView {

    /// A callback executed on proceed button tap.
    var onProceedTap: (() -> Void)?

    /// A top image view.
    let topImageView: UIImageView
    /// A title label.
    let titleLabel: UILabel
    /// A description  label.
    let descriptionLabel: UILabel
    /// A bank account label.
    let bankAccountLabel: UILabel

    /// A proceed button.
    let proceedButton: UIButton = {
        let button = UIButton(type: .system)
        return button.layoutable()
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView.layoutable()
    }()

    /// View mode.
    let mode: Mode

    /// Default initializer of `BankAccountView`.
    ///
    /// - Parameter mode: a view mode.
    init(mode: Mode) {
        self.mode = mode
        topImageView = BankAccountView.makeTopImage(mode: mode)
        titleLabel = BankAccountView.makeTitleLabel(mode: mode)
        descriptionLabel = BankAccountView.makeDescriptionLabel(mode: mode)
        bankAccountLabel = BankAccountView.makeBankAccountLabel(mode: mode)
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable, message: "Use init(mode:) instead")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BankAccountView {

    /// A bank account view mode, added for sake of demo app.
    enum Mode {
        case regular
        case inaccessible
        case accessible
    }
}

// MARK: - Implementation details

private extension BankAccountView {

    func setupView() {
        setupSubviews()
        setupConstraints()
        setupProperties()
    }

    func setupSubviews() {
        [
            topImageView, titleLabel, descriptionLabel, bankAccountLabel, proceedButton
        ].forEach(stackView.addArrangedSubview)
        addSubview(stackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        topImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    func setupProperties() {
        backgroundColor = .white
        proceedButton.addTarget(self, action: #selector(didTapProceed), for: .touchUpInside)
        setupMode()
    }

    func setupMode() {
        switch mode {
        case .inaccessible:
            descriptionLabel.text = Strings.AccessibleBankAccountScreen.description
            descriptionLabel.textColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
            proceedButton.setTitle(Strings.AccessibleBankAccountScreen.buttonTitle, for: .normal)
        case .regular:
            descriptionLabel.text = Strings.BankAccountScreen.description
            descriptionLabel.textColor = .black
            proceedButton.setTitle(Strings.BankAccountScreen.buttonTitle, for: .normal)
        case .accessible:
            descriptionLabel.text = Strings.AccessibleBankAccountScreen.description
            descriptionLabel.textColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
            proceedButton.isHidden = true
        }
    }

    @objc func didTapProceed() {
        onProceedTap?()
    }

    // MARK: - Factory methods

    static func makeTopImage(mode: Mode) -> UIImageView {
        let view = mode == .accessible ? AccessibleImageView() : UIImageView()
        view.image = .init(systemName: "banknote")
        view.tintColor = .green
        view.contentMode = .scaleAspectFit
        return view.layoutable()
    }

    static func makeTitleLabel(mode: Mode) -> UILabel {
        let label = mode == .accessible ? AccessibleLabel() : UILabel()
        label.text = Strings.BankAccountScreen.title
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label.layoutable()
    }

    static func makeDescriptionLabel(mode: Mode) -> UILabel {
        let label = mode == .accessible ? AccessibleLabel() : UILabel()
        label.numberOfLines = 0
        return label.layoutable()
    }

    static func makeBankAccountLabel(mode: Mode) -> UILabel {
        let label = mode == .accessible ? AccessibleLabel() : UILabel()
        label.text = generateBankAccountString()
        label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return label.layoutable()
    }

    static func generateBankAccountString() -> String {
        var numberString = ""
        numberString += "\(Int.random(in: 20...99))"
        for _ in 0..<6 {
            numberString += " \(Int.random(in: 1000...9999))"
        }
        return numberString
    }
}
