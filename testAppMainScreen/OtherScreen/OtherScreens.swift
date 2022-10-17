//
//  OtherScreens.swift
//  testAppMainScreen
//
//  Created by Антон on 13.10.2022.
//

import Foundation
import UIKit

final class Contacts: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Контакты"
		view.backgroundColor = .gray
	}
}

final class Profile: UIViewController {
	override func viewDidLoad() {
		view.backgroundColor = .lightGray
		title = "Профиль"
		super.viewDidLoad()
	}
}

final class Bye: UIViewController {
	override func viewDidLoad() {
		view.backgroundColor = .tertiarySystemBackground
		title = "Корзина"
		super.viewDidLoad()
	}
}
