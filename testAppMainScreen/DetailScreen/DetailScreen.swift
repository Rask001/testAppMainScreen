//
//  DetailScreen.swift
//  testAppMainScreen
//
//  Created by Антон on 19.10.2022.
//

import UIKit

//MARK: - VIEW
class DetailScreen: UIViewController {
	
	//MARK: - PROPERTY
	lazy var titleLabel = makeTitleLabel()
	lazy var button = makeButton()
	lazy var buttonPrice = makeButtonPrice()
	lazy var image = makeImageView()
	lazy var descript = makeDescription()
	var presenter: DetailViewPresenterProtocol!
	
	//MARK: - LIVECYCLE
	override func viewDidLoad() {
		super.viewDidLoad()
		addSubview()
		layout()
		presenter.setProduct()
	}
	
	//MARK: - SETUP
	

}

//MARK: - EXTENSION
extension DetailScreen: DetailViewProtocol {
	func setProduct(product: Product?) {
		titleLabel.text = product?.name
		buttonPrice.text = "\(product?.price ?? 0) р"
		descript.text = product?.description
	}
	
	
}

