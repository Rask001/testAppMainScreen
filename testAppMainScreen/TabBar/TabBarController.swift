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

	let mainScreen = ModuleBuilder.createMainScreen()
	let contactScreen = Contacts()
	let profileScreen = Profile()
	let byeScreen = Bye()

	func setupTabBar() {
		let mainScreenNC = createNavTabController(vc: mainScreen, name: "Меню", image: "menucard")
		let contactScreenNC = createNavTabController(vc: contactScreen, name: "Контакты", image: "mappin.and.ellipse")
		let profileScreenNC = createNavTabController(vc: profileScreen, name: "Профиль", image: "person.fill")
		let byeScreenNC = createNavTabController(vc: byeScreen, name: "Корзина", image: "dollarsign.square")
		self.viewControllers = [mainScreenNC, contactScreenNC, profileScreenNC, byeScreenNC]
	}
	
	func createNavTabController(vc: UIViewController, name: String, image: String) -> UINavigationController {
		let item = UITabBarItem(title: name, image: UIImage(systemName: image), tag: 0)
		let navController = UINavigationController(rootViewController: vc)
		navController.tabBarItem = item
		return navController
	}
}
