//
//  NetworkService.swift
//  testAppMainScreen
//
//  Created by Антон on 14.10.2022.
//

import Foundation


class NetworkService {
	
	func fetchRequest(urlString: String, complition: @escaping (Result<[Product], Error>) -> Void) {
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
				do {
					let items = try JSONDecoder().decode([Product].self, from: data)
					//print(items)
					complition(.success(items))
				} catch let jsonError {
					print("Failed to Decode JSON", jsonError)
					complition(.failure(jsonError))
				}
			}
		}.resume()
	}
}
