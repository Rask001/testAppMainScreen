//
//  TabBarController.swift
//  testAppMainScreen
//
//  Created by Антон on 13.10.2022.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupTabBar()
	}
	
	func setupTabBar() {
		let mainScreen = createNavController(vc: MainScreen(), name: "Меню", image: "menucard")
		let contactScreen = createNavController(vc: Contacts(), name: "Контакты", image: "mappin.and.ellipse")
		let profileScreen = createNavController(vc: Profile(), name: "Профиль", image: "person.fill")
		let byeScreen = createNavController(vc: Bye(), name: "Корзина", image: "dollarsign.square")
		
		viewControllers = [mainScreen, contactScreen, profileScreen, byeScreen]
	}
	
	func createNavController(vc: UIViewController, name: String, image: String) -> UINavigationController {
		let item = UITabBarItem(title: name, image: UIImage(systemName: image), tag: 0)
		let navController = UINavigationController(rootViewController: vc)
		navController.tabBarItem = item
		return navController
	}
}
