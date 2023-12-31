//
//  SceneDelegate.swift
//  JACKFLIX
//
//  Created by 서승우 on 2023/07/18.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let vc = ViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }

}
