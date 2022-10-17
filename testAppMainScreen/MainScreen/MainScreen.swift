//
//  ViewController.swift
//  testAppMainScreen
//
//  Created by Антон on 13.10.2022.
//

import UIKit
//MARK: - Constants
enum Constants {
	static var tableViewRowHeight: CGFloat { 156 }
	static var urlString = "https://my-json-server.typicode.com/Rask001/testAppMainScreen/items"
	static var burgers = "Бургеры"
	static var combo = "Комбо"
	static var deserts = "Десерты"
	static var drinks = "Напитки"
	static var borderColor = UIColor(named: "BorderColor")
	static var borderColor20 = UIColor(named: "BorderColor20")
	static var borderColor40 = UIColor(named: "BorderColor40")
}

final class MainScreen: UIViewController {
	
	//MARK: - Property
	private let tableView = UITableView()
	private let networkDataFetcher = NetworkDataFetcher()
	private var product = [Product]()
	private var burgers = [Product]()
	private var combo = [Product]()
	private var drinks = [Product]()
	private var dessert = [Product]()
	private var sectionStruct = [SectionStruct]()
	private var heightAnchorCollection: CGFloat = 136
	private var heightAnchorCollectionZero: CGFloat = 0
	private var sender = 0
	private var tableHeaderView = MainHeaderView()
	private var tableHeaderViewTopConstraint: NSLayoutConstraint?
	
	lazy var cahedataSource: NSCache<AnyObject, UIImage> = {
		let cache = NSCache<AnyObject, UIImage>()
		return cache
	}()
	
	//MARK: - Init
	override func viewDidLoad() {
		super.viewDidLoad()
		addSubview()
		layout()
		setupTableView()
		setupView()
		fetchData()
	  navItem()
	}
	
	private func navItem() {
		let rightButtonItem = UIBarButtonItem(
			title: "Москва ▼",
			style: .done,
			target: self,
			action: #selector(leftNavItem)
		)
		self.navigationItem.leftBarButtonItem = rightButtonItem
		self.navigationItem.leftBarButtonItem?.tintColor = .black
	}
	
	@objc func leftNavItem() {
		print(#function)
	}
	
	private func fetchData() {
		self.networkDataFetcher.fetchProducts(urlString: Constants.urlString) { [weak self] res in
			guard let self = self else { return }
			guard let result = res else { return }
			self.product = result
			DispatchQueue.main.async {
				self.arraySection()
				self.sectionStruct = [ SectionStruct(header: Constants.burgers, row: self.burgers),
															 SectionStruct(header: Constants.combo, row: self.combo),
															 SectionStruct(header: Constants.deserts , row: self.dessert),
															 SectionStruct(header: Constants.drinks, row: self.drinks)
				]
				print(self.sectionStruct)
				self.tableView.reloadData()
			}
		}
	}
	
	private func arraySection() {
		for i in product {
			let category = i.category
			switch category {
			case Constants.burgers:
				self.burgers.append(i)
			case Constants.combo:
				self.combo.append(i)
			case Constants.deserts:
				self.dessert.append(i)
			case Constants.drinks:
				self.drinks.append(i)
			default:
				print("проверь json, возможно новая категория")
			}
		}
	}
	
	//MARK: - Setup
	private func setupView() {
		self.view.backgroundColor = .secondarySystemBackground
		let item = UITabBarItem(title: "Меню", image: UIImage(systemName: "menucard"), tag: 0)
		tabBarItem = item
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
		
		tableHeaderView.complitionSender = { [weak self] sender in
			guard let self = self else { return }
			self.sender = sender
			self.tableView.scrollToRow(at: IndexPath(row: 0, section: sender), at: .top, animated: true)
			UIView.animate(withDuration: 0.4) {
				self.view.layoutIfNeeded()
			}
		}
	}
	
	//MARK: - AddSubViews
		private func addSubview() {
			self.view.addSubview(tableHeaderView)
			self.view.addSubview(tableView)
		}
	
	//MARK: - Constraints
	private func layout() {
		self.tableHeaderViewTopConstraint = self.tableHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
		self.tableHeaderView.translatesAutoresizingMaskIntoConstraints = false
		self.tableHeaderView.heightAnchor.constraint(equalToConstant: 216).isActive = true
		self.tableHeaderViewTopConstraint!.isActive = true
		self.tableHeaderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		self.tableHeaderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		
		self.tableView.translatesAutoresizingMaskIntoConstraints = false
		self.tableView.topAnchor.constraint(equalTo: self.tableHeaderView.bottomAnchor).isActive = true
		self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
	}
}

//MARK: - extension
extension MainScreen: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sectionStruct[section].row.count // self.product.count
	}
	
	func addData(indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
			let item = sectionStruct[indexPath.section].row[indexPath.row]
		 if let image = cahedataSource.object(forKey: "\(sectionStruct[indexPath.section].row[indexPath.row])" as AnyObject) {
				cell.image.image = image
		 } else {
				 guard let apiURL = URL(string: "\(self.sectionStruct[indexPath.section].row[indexPath.row].image)") else { fatalError() }
				 let session = URLSession(configuration: .default)
				 let task = session.dataTask(with: apiURL) { data, _, error in
					 guard let data = data, error == nil else { return }
					 DispatchQueue.main.async {
						 cell.image.image = UIImage(data: data)!
					 }
				 }
				 task.resume()
			 }
			cell.titleLabel.text = item.name
			cell.descript.text = item.description
			cell.buttonPrice.text = "oт \(item.price) р"
		return cell
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return addData(indexPath: indexPath)
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		sectionStruct.count
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return sectionStruct[section].header
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let y = scrollView.contentOffset.y
		
		let swipingDown = y <= 30
		let shouldSnap = y > 30
		let collectionViewHeight = tableHeaderView.collectionView.frame.height
		
		UIView.animate(withDuration: 0.3) {
			self.tableHeaderView.collectionView.alpha = swipingDown ? 1.0 : 0.0
		}
		
		UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0) {
			self.tableHeaderViewTopConstraint?.constant = shouldSnap ? -collectionViewHeight : 0
			self.view.layoutIfNeeded()
		}
	}
}
