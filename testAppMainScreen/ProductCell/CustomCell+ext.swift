//
//  CustomCell+ext.swift
//  testAppMainScreen
//
//  Created by Антон on 13.10.2022.
//
fileprivate enum Constant{
	static var descriptionFont: UIFont { UIFont(name: "Helvetica Neue Thin", size: 13)! }
	static var buttonBorderColor: CGColor { UIColor(named: "BorderColor")?.cgColor ?? UIColor.red.cgColor }
}

import Foundation
import UIKit

extension CustomCell {
	
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
	internal func addSubviewAndConfigure() {
		self.addSubview(self.image)
		self.addSubview(self.titleLabel)
		self.addSubview(self.descript)
		self.addSubview(self.button)
		self.button.addSubview(buttonPrice)
	}

	//MARK: - layout
	internal func layout() {
		self.image.translatesAutoresizingMaskIntoConstraints = false
		self.image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
		self.image.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		self.image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24).isActive = true
		self.image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -227).isActive = true
		
		self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
		self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 180).isActive = true
		self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
		self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -128).isActive = true
		self.titleLabel.trailingAnchor.constraint(equalTo: self.button.trailingAnchor).isActive = true
		
		self.descript.translatesAutoresizingMaskIntoConstraints = false
		self.descript.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor).isActive = true
		self.descript.topAnchor.constraint(equalTo: self.topAnchor, constant: 36).isActive = true
		self.descript.bottomAnchor.constraint(equalTo: self.button.topAnchor, constant: -16).isActive = true
		self.descript.trailingAnchor.constraint(equalTo: self.button.trailingAnchor).isActive = true
		
		self.button.translatesAutoresizingMaskIntoConstraints = false
		self.button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 264).isActive = true
		self.button.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
		self.button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24).isActive = true
		self.button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24).isActive = true
		
		self.buttonPrice.translatesAutoresizingMaskIntoConstraints = false
		self.buttonPrice.centerXAnchor.constraint(equalTo: self.button.centerXAnchor).isActive = true
		self.buttonPrice.centerYAnchor.constraint(equalTo: self.button.centerYAnchor).isActive = true
		self.buttonPrice.widthAnchor.constraint(equalToConstant: 51).isActive = true
		self.buttonPrice.heightAnchor.constraint(equalToConstant: 16).isActive = true
	}
}
