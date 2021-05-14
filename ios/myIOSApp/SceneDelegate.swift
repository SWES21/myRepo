//
//  SceneDelegate.swift
//  myIOSApp
//
//  Created by Michael  on 3/31/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        let myRoot = LoginOrSignUpViewController()
        let mainView = myNavController(rootViewController: myRoot)
        mainView.navigationBar.isHidden = true
        myRoot.delegate = mainView
        self.window?.rootViewController = mainView
        self.window?.makeKeyAndVisible()
    }
}

