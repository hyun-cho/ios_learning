//
//  TabBarController.swift
//  WorldTrotterCode
//
//  Created by NHN on 2021/04/08.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bounds: CGRect = UIScreen.main.bounds
        super.view.frame = bounds
        
        view.backgroundColor = .white // 배경색
        tabBar.barTintColor = .white // tabbar 배경 색
        tabBar.tintColor = .blue // 선택 되었을 때
        tabBar.unselectedItemTintColor = .black // 선택 안되었을 때
        
        setUpTabBar()
    }
    
    private func setUpTabBar() {
        let firstViewController = ConversionViewController()
        firstViewController.tabBarItem.image = UIImage(named: "ConvertIcon")
        firstViewController.tabBarItem.title = "Convert"
        
        let secondViewController = MapViewController()
        secondViewController.tabBarItem.image = UIImage(named: "MapIcon")
        secondViewController.tabBarItem.title = "Map"
        
        let tabs = [firstViewController, secondViewController]
        self.setViewControllers(tabs, animated: false)
    }
}
