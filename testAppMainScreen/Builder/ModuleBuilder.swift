//
//  ModuleBuilder.swift
//  testAppMainScreen
//
//  Created by Антон on 18.10.2022.
//

import UIKit

protocol Builder {
	static func createMainScreen() -> UIViewController
	static func createDetailScreen(product: Product?) -> UIViewController
}

class ModuleBuilder: Builder {
	static func createMainScreen() -> UIViewController {
		let view = MainScreen()
		let networkService = NetworkDataFetcher()
		let products = [Product]()
		let burgers = [Product]()
		let combo = [Product]()
		let drinks = [Product]()
		let dessert = [Product]()
		let sectionStruct = [SectionStruct]()
		let presenter = MainPresenter(view: view,
																	networkService: networkService,
																	products: products,
																	burgers: burgers,
																	combo: combo,
																	drinks: drinks,
																	dessert: dessert,
																	sectionStruct: sectionStruct
																	)
		view.presenter = presenter
		return view
	}
	
	static func createDetailScreen(product: Product?) -> UIViewController {
		let view = DetailScreen()
		let networkService = NetworkDataFetcher()
		let presenter = DetailPresenter(view: view,
																		networkService: networkService, product: product)
		view.presenter = presenter
		return view
	}
	
}
