//
//  MainPresenter.swift
//  testAppMainScreen
//
//  Created by Антон on 18.10.2022.
//

import Foundation

//MARK: - ScreenProtocol
protocol MainScreenProtocol: AnyObject {
	func reloadTableView()
}

//MARK: - PresrnterProtocol
protocol MainScreenPresenterProtocol: AnyObject {
	func fetchData()
	func arraySection()
	
	var products: [Product] { get set }
	var burgers: [Product] { get set }
	var combo: [Product] { get set }
	var drinks: [Product] { get set }
	var dessert: [Product] { get set }
	var sectionStruct: [SectionStruct] { get set }
	
	init(view: MainScreenProtocol,
			 networkService: NetworkServiceProtocol,
			 products: [Product],
			 burgers: [Product],
			 combo: [Product],
			 drinks: [Product],
			 dessert: [Product],
			 sectionStruct: [SectionStruct])
}

//MARK: - Presrnter
class MainPresenter: MainScreenPresenterProtocol {
	
	weak var view: MainScreenProtocol?
	let networkService: NetworkServiceProtocol!
	var products = [Product]()
	var burgers = [Product]()
	var combo = [Product]()
	var drinks = [Product]()
	var dessert = [Product]()
	var sectionStruct = [SectionStruct]()
	
	required init(view: MainScreenProtocol, networkService: NetworkServiceProtocol, products: [Product], burgers: [Product], combo: [Product], drinks: [Product], dessert: [Product], sectionStruct: [SectionStruct]) {
		self.view = view
		self.networkService = networkService
		self.burgers = burgers
		self.combo = combo
		self.drinks = drinks
		self.dessert = dessert
		self.sectionStruct = sectionStruct
		fetchData()
	}
	
	func fetchData() {
		networkService.fetchProducts(urlString: Constants.urlString) { [weak self] res in
			guard let self = self else { return }
			guard let result = res else { return }
			self.products = result
			DispatchQueue.main.async {
				self.arraySection()
				self.sectionStruct = [ SectionStruct(header: Constants.burgers, row: self.burgers),
															 SectionStruct(header: Constants.combo, row: self.combo),
															 SectionStruct(header: Constants.deserts , row: self.dessert),
															 SectionStruct(header: Constants.drinks, row: self.drinks)
				]
				self.view?.reloadTableView()
			}
		}
	}
	
	func arraySection() {
		for i in products {
			let category = i.category
			switch category {
			case Constants.burgers:
				self.burgers.append(i)
			case Constants.combo:
				self.combo.append(i)
			case Constants.deserts:
				self.dessert.append(i)
			case Constants.drinks:
				self.drinks.append(i)
			default:
				print("проверь json, возможно новая категория")
			}
		}
	}
}
