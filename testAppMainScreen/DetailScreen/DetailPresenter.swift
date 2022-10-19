//
//  DetailPresenter.swift
//  testAppMainScreen
//
//  Created by Антон on 19.10.2022.
//

import Foundation
//MARK: - VIEW PROTOCOL
protocol DetailViewProtocol: AnyObject {
	func setProduct(product: Product?)
}


//MARK: - PRESENTER PROTOCOL
protocol DetailViewPresenterProtocol: AnyObject {
	init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, product: Product?)
	func setProduct()
}


//MARK: - PRESENTER
class DetailPresenter: DetailViewPresenterProtocol {
weak var view: DetailViewProtocol?
let networkService: NetworkServiceProtocol!
var product: Product?

	
required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, product: Product?) {
	self.view = view
	self.networkService = networkService
	self.product = product
}
	
	public func setProduct() {
		self.view?.setProduct(product: product)
	}
	
	
}
