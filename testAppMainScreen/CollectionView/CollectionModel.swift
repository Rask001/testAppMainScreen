//
//  CollectionViewModel.swift
//  testAppMainScreen
//
//  Created by Антон on 13.10.2022.
//

import Foundation
import UIKit

struct CollectionModel {
	let image: UIImage
	
	static func fetchArray() -> [UIImage] {
		let imageOne: UIImage = UIImage(named: "one")!
		let imageTwo: UIImage = UIImage(named: "two")!
		let imageThree: UIImage = UIImage(named: "three")!
		return [imageOne, imageTwo, imageThree]
	}
}
