//
//  CustomCell.swift
//  testAppMainScreen
//
//  Created by Антон on 13.10.2022.
//

import Foundation
import UIKit

final class CustomCell: UITableViewCell {
	static let identifier = "CustomCell"
	
	lazy var titleLabel = makeTitleLabel()
	lazy var button = makeButton()
	lazy var buttonPrice = makeButtonPrice()
	lazy var image = makeImageView()
	lazy var descript = makeDescription()
	var id: String = ""
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		addSubviewAndConfigure()
		setConstraintsCell()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
