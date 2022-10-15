//
//  NetworkDataFetcher.swift
//  testAppMainScreen
//
//  Created by Антон on 15.10.2022.
//

import Foundation

class NetworkDataFetcher {
	let networkService = NetworkService()
	
	func fetchProducts(urlString: String, responce: @escaping ([Product]?) -> Void) {
		networkService.request(urlString: urlString) { result in
			switch result {
			case .success(let data):
				do {
					let items = try JSONDecoder().decode([Product].self, from: data)
					responce(items)
				} catch let jsonError {
					print("Failed to Decode JSON", jsonError)
				}
			case .failure(let error):
				print(#function, error, error.localizedDescription)
				responce(nil)
			}
		}
	}
}
