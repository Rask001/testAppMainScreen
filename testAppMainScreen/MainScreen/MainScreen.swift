//
//  ViewController.swift
//  testAppMainScreen
//
//  Created by Антон on 13.10.2022.
//

import UIKit

fileprivate enum Constants {
	static var tableViewRowHeight: CGFloat { 156 }
	static var urlString = "https://my-json-server.typicode.com/Rask001/testAppMainScreen/items"
}

class MainScreen: UIViewController {
	
	//MARK: - Property
	private let tableView = UITableView()
	private let collectionView = CollectionView()
	private let scrollView = UIScrollView()
	private let stackView = UIStackView()
	private var lastSelectedButton = UIButton()
	private let buttonCategoryArray = ["Бургеры", "Комбо", "Десерты", "Напитки"]
	private let networkService = NetworkService()
	private var product = [Product]()
	
	
	//MARK: - Init
	override func viewDidLoad() {
		super.viewDidLoad()
		addSubview()
		setConstraints()
		setupTableView()
		setupView()
		setupScrollView()
		setupStackView()
		collectionView.set(cells: CollectionModel.fetchArray())
		createScrollView()
		
		networkService.fetchRequest(urlString: Constants.urlString) { [weak self] result in
			guard let self = self else { return }
			switch result{
			case .success(let product):
				self.product = product
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
				print(product.count)
			case .failure(let error):
				print(error)
			}
		}
	}
	
	//MARK: - Setup
	private func setupView() {
		self.view.backgroundColor = .secondarySystemBackground
	}
	
	private func setupScrollView() {
		self.scrollView.backgroundColor = .secondarySystemBackground
		self.scrollView.contentInset = UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
		self.scrollView.showsHorizontalScrollIndicator = false
		self.scrollView.showsVerticalScrollIndicator = false
	}
	
	private func setupStackView() {
		self.stackView.axis = .horizontal
		self.stackView.alignment = .center
		self.stackView.spacing = 8
		self.stackView.backgroundColor = .secondarySystemBackground
	}
	
	private func createScrollView() {
		let array = createButton(input: buttonCategoryArray)
		addButtonToStackView(input: array)
	}
	
	private func addButtonToStackView(input: [UIButton]) {
		for item in input {
			self.stackView.addArrangedSubview(item)
		}
	}

	
	private func createButton(input: [String]) -> [UIButton] {
		var buttonArray = [UIButton]()
		var buttonTag = 0
		for item in input {
			let button = UIButton()
			button.setTitle(item, for: .normal)
			button.setTitleColor(UIColor(named: "BorderColor40"), for: .normal)
			button.setTitleColor(UIColor(named: "BorderColor"), for: .selected)
			button.translatesAutoresizingMaskIntoConstraints = false
			button.heightAnchor.constraint(equalToConstant: 32).isActive = true
			button.widthAnchor.constraint(equalToConstant: 88).isActive = true
			button.backgroundColor = .secondarySystemBackground
			button.layer.borderColor = UIColor(named: "BorderColor40")?.cgColor
			button.layer.borderWidth = 1
			button.layer.cornerRadius = 16
			button.tag = buttonTag
			buttonTag += 1
			button.addTarget(self, action: #selector(tapToCategory(sender:)), for: .touchUpInside)
			buttonArray.append(button)
		}
		return buttonArray
	}
	
	@objc func tapToCategory(sender: UIButton) {
		self.lastSelectedButton.isSelected = false
		self.lastSelectedButton.backgroundColor = .secondarySystemBackground
		self.lastSelectedButton.layer.borderWidth = 1
		self.lastSelectedButton = sender
		sender.isSelected = true
		sender.backgroundColor = UIColor(named: "BorderColor20")
		sender.layer.borderWidth = 0
		print(sender.tag)
		//self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
//		UIView.animate(withDuration: 0.5) {
//			self.view.layoutIfNeeded()
//		}
	}


	private func setupTableView() {
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
		self.tableView.backgroundColor = .white
		self.tableView.layer.cornerRadius = 12
		self.tableView.bounces = true
		self.tableView.separatorStyle = .singleLine
		self.tableView.rowHeight = Constants.tableViewRowHeight
		self.tableView.isScrollEnabled = true
		self.tableView.allowsSelection = false
		//self.tableView.scrollRectToVisible(<#T##rect: CGRect##CGRect#>, animated: <#T##Bool#>)
		self.tableView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
	}
	

	//MARK: - AddSubViews
	
		private func addSubview() {
			self.view.addSubview(tableView)
			self.view.addSubview(collectionView)
			self.view.addSubview(scrollView)
			scrollView.addSubview(stackView)
		}
	
	
	//MARK: - Constraints
	private func setConstraints() {
		self.tableView.translatesAutoresizingMaskIntoConstraints = false
		//self.tableView.topAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
		self.tableView.heightAnchor.constraint(greaterThanOrEqualToConstant: 516).isActive = true
		
		self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
		
		self.collectionView.translatesAutoresizingMaskIntoConstraints = false
		self.collectionView.bottomAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
		self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		self.collectionView.heightAnchor.constraint(equalToConstant: 136).isActive = true //136
		//self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
		self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
		//self.collectionView.heightAnchor.constraint(equalToConstant: 112).isActive = true
		
		self.stackView.translatesAutoresizingMaskIntoConstraints = false
		self.stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
		self.stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
		self.stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
		self.stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
		
		self.scrollView.translatesAutoresizingMaskIntoConstraints = false
		self.scrollView.bottomAnchor.constraint(equalTo: self.tableView.topAnchor).isActive = true
		//self.scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
		self.scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
		self.scrollView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor).isActive = true
		self.scrollView.heightAnchor.constraint(equalToConstant: 80).isActive = true
	}

}
//MARK: - extension
extension MainScreen: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.product.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
		let item = product[indexPath.row]
		cell.titleLabel.text = item.name
		cell.descript.text = item.description
		cell.buttonPrice.text = "oт \(item.price) р"
		return cell
	}

	
	func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
		
		//self.collectionView.heightAnchor.constraint(equalToConstant: 0).isActive = true
//		self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
		UIView.animate(withDuration: 1) {
			self.view.layoutIfNeeded()
		}
		print("start scroll")
	}
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		//self.collectionView.heightAnchor.constraint(equalToConstant: 136).isActive = true
		UIView.animate(withDuration: 1) {
			self.view.layoutIfNeeded()
		}
		print("scroll end")
	}
}
