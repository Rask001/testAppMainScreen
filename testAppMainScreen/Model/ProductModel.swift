//
//  ProductModel.swift
//  testAppMainScreen
//
//  Created by Антон on 14.10.2022.
//

import Foundation

struct Product: Codable {
	var name: String
	var description: String
	var price: Int
	var image: String
	var category: String
}

struct SectionStruct {
	var header: String
	var row: [Product]
}
