//
//  OtherScreens.swift
//  testAppMainScreen
//
//  Created by Антон on 13.10.2022.
//

import Foundation
import UIKit

class Contacts: UIViewController {
	override func viewDidLoad() {
		title = "Контакты"
		view.backgroundColor = .gray
		super.viewDidLoad()
	}
}

class Profile: UIViewController {
	override func viewDidLoad() {
		view.backgroundColor = .lightGray
		title = "Профиль"
		super.viewDidLoad()
	}
}

class Bye: UIViewController {
	override func viewDidLoad() {
		view.backgroundColor = .tertiarySystemBackground
		title = "Корзина"
		super.viewDidLoad()
	}
}
