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
	
	let mainScreen = MainScreen()
	let contactScreen = Contacts()
	let profileScreen = Profile()
	let byeScreen = Bye()

	func setupTabBar() {
		let mainScreenNC = createNavTabController(vc: MainScreen(), name: "Меню", image: "mappin.and.ellipse")
		let contactScreenNC = createNavTabController(vc: Contacts(), name: "Контакты", image: "mappin.and.ellipse")
		let profileScreenNC = createNavTabController(vc: Profile(), name: "Профиль", image: "person.fill")
		let byeScreenNC = createNavTabController(vc: Bye(), name: "Корзина", image: "dollarsign.square")
		viewControllers = [mainScreenNC, contactScreenNC, profileScreenNC, byeScreenNC]
	}

	
	func createNavTabController(vc: UIViewController, name: String, image: String) -> UINavigationController {
		let item = UITabBarItem(title: name, image: UIImage(systemName: image), tag: 0)
		let navController = UINavigationController(rootViewController: vc)
		navController.tabBarItem = item
		return navController
	}
}
