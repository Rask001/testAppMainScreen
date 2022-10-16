//
//  NetworkService.swift
//  testAppMainScreen
//
//  Created by Антон on 14.10.2022.
//

import Foundation

class NetworkService {
	
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
