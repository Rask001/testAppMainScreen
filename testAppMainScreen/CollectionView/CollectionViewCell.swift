//
//  CollectionViewCell.swift
//  testAppMainScreen
//
//  Created by Антон on 13.10.2022.
//

import Foundation
import UIKit

final class CollectionViewCell: UICollectionViewCell {
	static let identifier = "CollectionCell"
	
	let imageView: UIImageView = {
		let image = UIImageView()
		image.clipsToBounds = true
		return image
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview()
		setConstraint()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		imageView.layer.cornerRadius = 10
	}
	
	//MARK: - AddSubview
	private func addSubview() {
		addSubview(imageView)
	}
	
	//MARK: - SetConstraint
	private func setConstraint() {
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
	}
}
