//
//  ProductModel.swift
//  testAppMainScreen
//
//  Created by Антон on 14.10.2022.
//

import Foundation

//struct MenuData: Codable {
//	var items: [Product]
//}


struct Product: Codable {
	var name: String
	var description: String
	var price: Int
	var image: String
	var category: String
}
