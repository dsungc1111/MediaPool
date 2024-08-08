//
//  TabBarViewController.swift
//  MediaPool
//
//  Created by 최대성 on 8/8/24.
//

import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // 투데이, 게임, 앱, 아케이드, 검색
        
        let today = TodayVC()
        let nav1 = UINavigationController(rootViewController: today)
        nav1.tabBarItem = UITabBarItem(title: "투데이", image: UIImage(systemName: "book"), tag: 0)
        
        let game = GameVC()
        let nav2 = UINavigationController(rootViewController: game)
        nav2.tabBarItem = UITabBarItem(title: "게임", image: UIImage(systemName: "gamecontroller"), tag: 1)
        
        let app = AppVC()
        let nav3 = UINavigationController(rootViewController: app)
        nav3.tabBarItem = UITabBarItem(title: "앱", image: UIImage(systemName: "square.stack.fill"), tag: 2)
        
        let arcade = ArcadeVC()
        let nav4 = UINavigationController(rootViewController: arcade)
        nav4.tabBarItem = UITabBarItem(title: "아케이드", image: UIImage(systemName: "star"), tag: 3)
        
        let search = SearchVC()
        let nav5 = UINavigationController(rootViewController: search)
        nav5.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 4)
        
        setViewControllers([nav1, nav2, nav3, nav4, nav5], animated: true)
        
    }
    

    
}
