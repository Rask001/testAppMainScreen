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
	static var burgers = "Бургеры"
	static var combo = "Комбо"
	static var deserts = "Десерты"
	static var drinks = "Напитки"
	static var borderColor = UIColor(named: "BorderColor")
	static var borderColor20 = UIColor(named: "BorderColor20")
	static var borderColor40 = UIColor(named: "BorderColor40")
}

class MainScreen: UIViewController {
	
	//MARK: - Property
	private let tableView = UITableView()
	private let collectionView = CollectionView()
	private let scrollView = UIScrollView()
	private let stackView = UIStackView()
	private var lastSelectedButton = UIButton()
	private var buttonCategoryArray = [Constants.burgers, Constants.combo, Constants.deserts, Constants.drinks]
	private let networkDataFetcher = NetworkDataFetcher()
	private var product = [Product]()
	private var burgers = [Product]()
	private var combo = [Product]()
	private var drinks = [Product]()
	private var dessert = [Product]()
	private var sectionStruct = [SectionStruct]()
	var img = UIImage()
	
	lazy var cahedataSource: NSCache<AnyObject, UIImage> = {
		let cache = NSCache<AnyObject, UIImage>()
		return cache
	}()
	
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
		let array = createButtons(input: buttonCategoryArray)
		addButtonToStackView(input: array)
	}
	
	private func addButtonToStackView(input: [UIButton]) {
		for item in input {
			self.stackView.addArrangedSubview(item)
		}
	}

	
	private func createButtons(input: [String]) -> [UIButton] {
		var buttonArray = [UIButton]()
		var buttonTag = 0
		for item in input {
			let button = UIButton()
			button.setTitle(item, for: .normal)
			button.setTitleColor(Constants.borderColor40, for: .normal)
			button.setTitleColor(Constants.borderColor, for: .selected)
			button.translatesAutoresizingMaskIntoConstraints = false
			button.heightAnchor.constraint(equalToConstant: 32).isActive = true
			button.widthAnchor.constraint(equalToConstant: 88).isActive = true
			button.backgroundColor = .secondarySystemBackground
			button.layer.borderColor = Constants.borderColor40?.cgColor
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
		sender.backgroundColor = Constants.borderColor20
		sender.layer.borderWidth = 0
		self.tableView.scrollToRow(at: IndexPath(row: 0, section: sender.tag), at: .top, animated: true)
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
		self.tableView.topAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
		//self.tableView.heightAnchor.constraint(greaterThanOrEqualToConstant: 516).isActive = true
		self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
		
		self.collectionView.translatesAutoresizingMaskIntoConstraints = false
		//self.collectionView.bottomAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
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
		//self.scrollView.bottomAnchor.constraint(equalTo: self.tableView.topAnchor).isActive = true
		//self.scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
		self.scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
		self.scrollView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor).isActive = true
		self.scrollView.heightAnchor.constraint(equalToConstant: 80).isActive = true
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
}


//MARK: - Sctoll
extension MainScreen: UIScrollViewDelegate {
	func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
		self.collectionView.heightAnchor.constraint(equalToConstant: 0).isActive = true
		UIView.animate(withDuration: 0.4) {
			self.view.layoutIfNeeded()
		}
		print("start scroll")
	}
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
			self.collectionView.heightAnchor.constraint(equalToConstant: 136).isActive = true
			UIView.animate(withDuration: 0.4) {
				self.view.layoutSubviews()
			}
		
		//self.collectionView.heightAnchor.constraint(equalToConstant: 136).isActive = true
	
		print("scroll end")
	}
}
