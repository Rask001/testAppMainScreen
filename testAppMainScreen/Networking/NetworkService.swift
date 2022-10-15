//
//  NetworkService.swift
//  testAppMainScreen
//
//  Created by Антон on 14.10.2022.
//

import Foundation
import UIKit

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

	func showImageView(urlImage: String) -> UIImage {
		var result = UIImage()
		guard let url = URL(string: urlImage) else { fatalError() }
			let session = URLSession.shared
			session.dataTask(with: url) { data, responce, error in
				if let data = data, let image = UIImage(data: data) {
						result = image
				}
			}.resume()
		return result
	}
}
