//
//  SceneDelegate.swift
//  FirstMVVMproject
//
//  Created by 김동준 on 2020/07/16.
//  Copyright © 2020 김동준. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

      guard let windowScene = (scene as? UIWindowScene) else { return }
      window = UIWindow(frame: windowScene.coordinateSpace.bounds)
      window?.windowScene = windowScene
    let vc = MainViewController()
        vc.view.backgroundColor = .blue
        window?.rootViewController = vc
      window?.makeKeyAndVisible()
    }

}

