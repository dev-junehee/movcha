//
//  SceneDelegate.swift
//  movcha
//
//  Created by junehee on 6/4/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        // MARK: TabBar Controller 탭 바 컨트롤러
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        let boxOfficeViewController = UINavigationController(rootViewController: BoxOfficeViewController())
        let trendingViewController = UINavigationController(rootViewController: TrendingViewController())
        
        // 임시 순서 변경 (기존: 홈 - 박스오피스 - 인기급상승)
        let controllers = [homeViewController, boxOfficeViewController, trendingViewController]
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers(controllers, animated: true)
        
        if let items = tabBarController.tabBar.items {
            items[0].title = Text.Title.home
            items[0].image = SystemImage.home
            
            items[1].title = Text.Title.boxOffice
            items[1].image = SystemImage.boxOffice
            
            items[2].title = Text.Title.trending
            items[2].image = SystemImage.trending
        }
        
        tabBarController.view.backgroundColor = .systemBackground
        tabBarController.tabBar.tintColor = Color.Primary.pink
        window?.rootViewController = tabBarController
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

