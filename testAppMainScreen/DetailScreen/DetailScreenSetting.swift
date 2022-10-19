//
//  DetailScreenSetting.swift
//  testAppMainScreen
//
//  Created by Антон on 19.10.2022.
//

import Foundation
import UIKit

//MARK: - CONSTANT
fileprivate enum Constant{
	static var descriptionFont: UIFont { UIFont(name: "Helvetica Neue Thin", size: 13)! }
	static var buttonBorderColor: CGColor { UIColor(named: "BorderColor")?.cgColor ?? UIColor.red.cgColor }
}

//MARK: - EXTENSION
extension DetailScreen {
	//MARK: - SETUP
	internal func makeTitleLabel() -> UILabel {
		let label = UILabel()
		label.numberOfLines = 0
		label.adjustsFontSizeToFitWidth = true
		label.text = "Ветчина и грибы"
		return label
	}
	
	internal func makeButtonPrice() -> UILabel {
		let label = UILabel()
		label.text = "от 345 р"
		label.adjustsFontSizeToFitWidth = true
		return label
	}

	internal func makeButton() -> UIButton {
		let button = UIButton()
		button.backgroundColor = .white
		button.layer.borderColor = Constant.buttonBorderColor
		button.layer.borderWidth = 1
		button.layer.cornerRadius = 6
		return button
	}
	
	internal func makeDescription() -> UILabel {
		let label = UILabel()
		label.text = "Ветчина,шампиньоны, увеличинная порция моцареллы, томатный соус"
		label.font = Constant.descriptionFont
		label.numberOfLines = 0
		label.textAlignment = .left
		return label
	}

	internal func makeImageView() -> UIImageView {
		let imageView = UIImageView()
		imageView.clipsToBounds = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}
	
	//MARK: - addSubviewAndConfigure
	internal func addSubview() {
		self.view.backgroundColor = .secondarySystemBackground
		self.view.addSubview(self.image)
		self.view.addSubview(self.titleLabel)
		self.view.addSubview(self.descript)
		self.view.addSubview(self.button)
		self.button.addSubview(buttonPrice)
	}

	//MARK: - LAYOUT
	internal func layout() {
		self.image.translatesAutoresizingMaskIntoConstraints = false
		self.image.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
		self.image.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16).isActive = true
		self.image.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
		self.image.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: -32).isActive = true
		
		self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
		self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 180).isActive = true
		self.titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8).isActive = true
		self.titleLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -128).isActive = true
		self.titleLabel.trailingAnchor.constraint(equalTo: self.button.trailingAnchor).isActive = true
		
		self.descript.translatesAutoresizingMaskIntoConstraints = false
		self.descript.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor).isActive = true
		self.descript.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 36).isActive = true
		self.descript.bottomAnchor.constraint(equalTo: self.button.topAnchor, constant: -16).isActive = true
		self.descript.trailingAnchor.constraint(equalTo: self.button.trailingAnchor).isActive = true
		
		self.button.translatesAutoresizingMaskIntoConstraints = false
		self.button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 264).isActive = true
		self.button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
		self.button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -24).isActive = true
		self.button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24).isActive = true
		
		self.buttonPrice.translatesAutoresizingMaskIntoConstraints = false
		self.buttonPrice.centerXAnchor.constraint(equalTo: self.button.centerXAnchor).isActive = true
		self.buttonPrice.centerYAnchor.constraint(equalTo: self.button.centerYAnchor).isActive = true
		self.buttonPrice.widthAnchor.constraint(equalToConstant: 51).isActive = true
		self.buttonPrice.heightAnchor.constraint(equalToConstant: 16).isActive = true
	}
}
