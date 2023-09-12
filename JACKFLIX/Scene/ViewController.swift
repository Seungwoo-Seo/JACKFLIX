//
//  ViewController.swift
//  JACKFLIX
//
//  Created by 서승우 on 2023/07/18.
//

import SnapKit
import UIKit

final class ViewController: UIViewController {
    // MARK: - View
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "JACKFLIX"
        label.textColor = .red
        label.font = .systemFont(ofSize: 32, weight: .black)

        return label
    }()

    private let textFieldStackView: TextFieldStackView = {
        let stackView = TextFieldStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 16

        return stackView
    }()

    private let moreInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .white
        label.text = "추가 정보 입력"

        return label
    }()

    private let moreInfoSwitch: UISwitch = {
        let moreInfoSwitch = UISwitch()
        moreInfoSwitch.setOn(true, animated: true)
        moreInfoSwitch.onTintColor = .red
        moreInfoSwitch.thumbTintColor = .white

        return moreInfoSwitch
    }()

    // MARK: - ViewModel
    let viewModel = ViewModel()
    var flag = true

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureAttributes()
        configureHierarchy()

        viewModel.emailPhoneNumber.bind { text in
            self.textFieldStackView.emailPhoneNumberTextField.text = text
        }
        viewModel.password.bind { text in
            self.textFieldStackView.passwordTextField.text = text
        }
        viewModel.nickname.bind { text in
            self.textFieldStackView.nickNameTextField.text = text
        }
        viewModel.location.bind { text in
            self.textFieldStackView.locationTextField.text = text
        }
        viewModel.suggestionCode.bind { text in
            self.textFieldStackView.suggestionCodeTextField.text = text
        }
        viewModel.isValid.bind { bool in
            self.textFieldStackView.signUpButton.isEnabled = bool
            self.textFieldStackView.signUpButton.setTitleColor(bool ? .black : .gray, for: .normal)
            self.textFieldStackView.signUpButton.backgroundColor = bool ? .white : .lightGray
        }
        viewModel.isValid.value = false
    }

    override func touchesBegan(
        _ touches: Set<UITouch>,
        with event: UIEvent?
    ) {
        super.touchesBegan(touches, with: event)

        view.endEditing(true)
    }

    @objc
    func editChangedEmailPhoneNumberTextField(_ sender: UITextField) {
        viewModel.emailPhoneNumber.value = sender.text ?? ""
        viewModel.checkValidation()
    }
    @objc
    func editChangedPasswordTextField(_ sender: UITextField) {
        viewModel.password.value = sender.text ?? ""
        viewModel.checkValidation()
    }
    @objc
    func editChangedNicknameTextField(_ sender: UITextField) {
        viewModel.nickname.value = sender.text ?? ""
        viewModel.checkValidation()
    }
    @objc
    func editChangedLocationTextField(_ sender: UITextField) {
        viewModel.location.value = sender.text ?? ""
    }
    @objc
    func editChangedSuggestionCodeTextField(_ sender: UITextField) {
        viewModel.suggestionCode.value = sender.text ?? ""
    }

}

// MARK: - UI
private extension ViewController {

    func configureAttributes() {
        // view
        view.backgroundColor = .black

        textFieldStackView.emailPhoneNumberTextField.addTarget(
            self,
            action: #selector(editChangedEmailPhoneNumberTextField),
            for: .editingChanged
        )
        textFieldStackView.passwordTextField.addTarget(
            self,
            action: #selector(editChangedPasswordTextField),
            for: .editingChanged
        )
        textFieldStackView.nickNameTextField.addTarget(
            self,
            action: #selector(editChangedNicknameTextField),
            for: .editingChanged
        )
        textFieldStackView.locationTextField.addTarget(
            self,
            action: #selector(editChangedLocationTextField),
            for: .editingChanged
        )
        textFieldStackView.suggestionCodeTextField.addTarget(
            self,
            action: #selector(editChangedSuggestionCodeTextField),
            for: .editingChanged
        )

        // signUpButton
        textFieldStackView.signUpButton.addTarget(
            self,
            action: #selector(didTapSignUpButton),
            for: .touchUpInside
        )
    }

    func configureHierarchy() {
        [
            titleLabel,
            textFieldStackView,
            moreInfoLabel,
            moreInfoSwitch
        ].forEach { view.addSubview($0) }

        let spacing: CGFloat = 16
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(spacing)
            make.centerX.equalToSuperview()
        }

        textFieldStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(spacing)
        }

        moreInfoLabel.snp.makeConstraints { make in
            make.leading.equalTo(textFieldStackView)
            make.centerY.equalTo(moreInfoSwitch.snp.centerY)
        }

        moreInfoSwitch.snp.makeConstraints { make in
            make.top.equalTo(textFieldStackView.snp.bottom).offset(spacing)
            make.trailing.equalTo(textFieldStackView)
        }
    }

}

// MARK: - 이벤트
private extension ViewController {

    @objc
    func didTapSignUpButton(_ sender: UIButton) {
        let message = viewModel.message
        presentAlert(
            title: textFieldStackView.nickNameTextField.text,
            message: message,
            isError: false
        )
    }

}

// MARK: - 화면 전환
private extension ViewController {

    // 알럿 구성하고 띄우기
    func presentAlert(
        title: String?,
        message: String?,
        isError: Bool
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        if isError {
            let confirm = UIAlertAction(
                title: "확인",
                style: .default
            )
            alert.addAction(confirm)

        } else {
            let cancel = UIAlertAction(
                title: "취소",
                style: .cancel
            )
            let confirm = UIAlertAction(
                title: "확인",
                style: .default
            )

            [cancel, confirm].forEach { alert.addAction($0) }
        }

        present(alert, animated: true)
    }

}

