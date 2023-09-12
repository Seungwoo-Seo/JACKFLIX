//
//  ViewModel.swift
//  JACKFLIX
//
//  Created by 서승우 on 2023/09/13.
//

import Foundation

class ViewModel {

    let emailPhoneNumber = Observable("")
    let password = Observable("")
    let nickname = Observable("")
    let location = Observable("")
    let suggestionCode = Observable("")
    let isValid = Observable(false)

    var message: String {
        return """
        ID : \(emailPhoneNumber.value)
        위치 : \(location.value.isEmpty ? "X" : location.value)
        추천코드 : \(suggestionCode.value.isEmpty ? "X" : suggestionCode.value)
        """
    }

    func checkValidation() {
        guard emailPhoneNumber.value.count >= 6,
              password.value.count >= 4,
              nickname.value.count >= 2
        else {
            isValid.value = false
            return
        }

        isValid.value = true
    }


}
