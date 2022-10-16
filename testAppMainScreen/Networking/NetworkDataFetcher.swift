//
//  NetworkDataFetcher.swift
//  testAppMainScreen
//
//  Created by Антон on 15.10.2022.
//

import Foundation
import UIKit
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
	
//	func showImageView(urlImage: String) -> UIImage {
//		var result = UIImage()
//		guard let url = URL(string: urlImage) else { fatalError() }
//			let session = URLSession.shared
//		session.dataTask(with: url) { data, _, _  in
//				if let data = data, let image = UIImage(data: data) {
//						result = image
//				}
//			}.resume()
//		return result
//	}
	
//	func showImageView(urlImage: String) -> UIImage {
//		var img = UIImage()
//		let api = urlImage
//		guard let apiURL = URL(string: api) else { fatalError() }
//		let session = URLSession(configuration: .default)
//		let task = session.dataTask(with: apiURL) { data, _, error in
//			guard let data = data, error == nil else { return }
//			DispatchQueue.main.async {
//				img = UIImage(data: data)!
//			}
//		}
//		task.resume()
//		return img
//	}
	
//	func showImageView(urlString: String, image: inout UIImage) {
//		guard let apiURL = URL(string: urlString) else { fatalError() }
//		let session = URLSession(configuration: .default)
//		let task = session.dataTask(with: apiURL) { @escaping data, _, error in
//			guard let data = data, error == nil else { return }
//				image = UIImage(data: data)!
//		}
//		task.resume()
//	}
}
