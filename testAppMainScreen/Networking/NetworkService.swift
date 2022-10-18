//
//  NetworkService.swift
//  testAppMainScreen
//
//  Created by Антон on 14.10.2022.
//

import UIKit

protocol NetworkServiceProtocol: Any {
	func fetchProducts(urlString: String, responce: @escaping ([Product]?) -> Void)
	func loadImage(item: Product, cell: CustomCell)
}

protocol NetworkDataFetcherProtocol: Any {
	func request(urlString: String, complition: @escaping (Result<Data, Error>) -> Void)
}


final class NetworkService: NetworkDataFetcherProtocol {
	
	func request(urlString: String, complition: @escaping (Result<Data, Error>) -> Void) {
		let urlString = urlString
		guard let url = URL(string: urlString) else { return }
		URLSession.shared.dataTask(with: url) { data, responce, error in
			DispatchQueue.main.async {
				if let error = error {
					print("Ups, error")
					complition(.failure(error))
					return
				}
				guard let data = data else { return }
				complition(.success(data))
			}
		}.resume()
	}
}


final class NetworkDataFetcher: NetworkServiceProtocol {
	let networkService = NetworkService()
	lazy var cahedataSource: NSCache<AnyObject, UIImage> = {
		let cache = NSCache<AnyObject, UIImage>()
		return cache
	}()
	
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
	
	func loadImage(item: Product, cell: CustomCell) {
		if let image = cahedataSource.object(forKey: "\(item)" as AnyObject) {
			cell.image.image = image
		} else {
			guard let apiURL = URL(string: "\(item.image)") else { fatalError() }
			let session = URLSession(configuration: .default)
			let task = session.dataTask(with: apiURL) { data, _, error in
				guard let data = data, error == nil else { return }
				DispatchQueue.main.async {
					cell.image.image = UIImage(data: data)!
				}
			}
			task.resume()
		}
	}
}
