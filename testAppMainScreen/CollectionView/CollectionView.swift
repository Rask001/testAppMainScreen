//
//  CollectionView.swift
//  testAppMainScreen
//
//  Created by Антон on 13.10.2022.
//

import Foundation
import UIKit

class CollectionView: UICollectionView {
	
	var cell = [UIImage]()
	
	//MARK: - init
	init() {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 16
		super.init(frame: .zero, collectionViewLayout: layout)
		setupCollectionView()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	internal func set(cells: [UIImage]) {
		self.cell = cells
	}
	
	private func setupCollectionView() {
		contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
		showsHorizontalScrollIndicator = false
		backgroundColor = .secondarySystemBackground
		delegate = self
		dataSource = self
		register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
	}
}


//MARK: - extension
extension CollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		3
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
		cell.imageView.image = self.cell[indexPath.row]
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 300, height: 136)
	}
}
