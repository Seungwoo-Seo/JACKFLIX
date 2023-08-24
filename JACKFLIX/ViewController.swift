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

    override func viewDidLoad() {
        super.viewDidLoad()

        configureAttributes()
        configureHierarchy()
    }

    override func touchesBegan(
        _ touches: Set<UITouch>,
        with event: UIEvent?
    ) {
        super.touchesBegan(touches, with: event)

        view.endEditing(true)
    }

}

// MARK: - UI
private extension ViewController {

    func configureAttributes() {
        // view
        view.backgroundColor = .black

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
        // 이메일 주소 또는 전화번호, 비밀번호, 닉네임
        // 있는지 검사
        guard textFieldStackView.emailPhoneNumberTextField.text?.isEmpty == false
                && textFieldStackView.passwordTextField.text?.isEmpty == false
                && textFieldStackView.nickNameTextField.text?.isEmpty == false
        else {
            presentAlert(
                title: "이메일 주소 전화번호, 비밀번호, 닉네임은 필수",
                message: nil,
                isError: true
            )
            return
        }

        // 비밀번호 자리수 검사
        guard textFieldStackView.passwordTextField.text!.count >= 6
        else {
            presentAlert(
                title: "비밀번호는 6자리 이상",
                message: nil,
                isError: true
            )
            return
        }

        guard let emailPhonNumber = textFieldStackView.emailPhoneNumberTextField.text,
              let location = textFieldStackView.locationTextField.text,
              let suggestionCode = textFieldStackView.suggestionCodeTextField.text
        else {return}

        // 모든 검사 통과 시 가입 정보 띄우기
        let message = """
ID : \(emailPhonNumber)
위치 : \(location.isEmpty ? "X" : location)
추천코드 : \(suggestionCode.isEmpty ? "X" : suggestionCode)
"""
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

