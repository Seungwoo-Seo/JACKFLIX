//
//  TextFieldStackView.swift
//  JACKFLIX
//
//  Created by 서승우 on 2023/08/24.
//

import SnapKit
import UIKit

final class TextFieldStackView: UIStackView {

    let emailPhoneNumberTextField: GrayWhiteTextField = {
        let textField = GrayWhiteTextField(
            placeholder: "이메일 주소 또는 전화번호",
            keyboardType: .emailAddress,
            isSecureTextEntry: false
        )

        return textField
    }()

    let passwordTextField: GrayWhiteTextField = {
        let textField = GrayWhiteTextField(
            placeholder: "비밀번호",
            keyboardType: .default,
            isSecureTextEntry: true
        )

        return textField
    }()

    let nickNameTextField: GrayWhiteTextField = {
        let textField = GrayWhiteTextField(
            placeholder: "닉네임",
            keyboardType: .default,
            isSecureTextEntry: false
        )

        return textField
    }()

    let locationTextField: GrayWhiteTextField = {
        let textField = GrayWhiteTextField(
            placeholder: "위치",
            keyboardType: .default,
            isSecureTextEntry: false
        )

        return textField
    }()

    let suggestionCodeTextField: GrayWhiteTextField = {
        let textField = GrayWhiteTextField(
            placeholder: "추천 코드 입력",
            keyboardType: .numberPad,
            isSecureTextEntry: false
        )

        return textField
    }()

    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = .systemFont(
            ofSize: 17,
            weight: .black
        )
        button.layer.cornerRadius = 8

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureHierarchy()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension TextFieldStackView {

    func configureHierarchy() {
        [
            emailPhoneNumberTextField,
            passwordTextField,
            nickNameTextField,
            locationTextField,
            suggestionCodeTextField,
            signUpButton
        ].forEach { addArrangedSubview($0) }

        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
    }

}
