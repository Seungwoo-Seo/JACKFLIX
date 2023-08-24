//
//  GrayWhiteTextField.swift
//  JACKFLIX
//
//  Created by 서승우 on 2023/08/24.
//

import UIKit

final class GrayWhiteTextField: UITextField {

    convenience init(
        placeholder: String,
        keyboardType: UIKeyboardType,
        isSecureTextEntry: Bool
    ) {
        self.init(frame: .zero)
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .regular)
            ]
        )
        self.keyboardType = keyboardType
        self.isSecureTextEntry = isSecureTextEntry
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureAttributes()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension GrayWhiteTextField {

    func configureAttributes() {
        textAlignment = .center
        backgroundColor = .gray
        borderStyle = .roundedRect
        textColor = .white
    }

}
