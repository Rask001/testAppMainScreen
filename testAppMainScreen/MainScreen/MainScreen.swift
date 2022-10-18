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

  //MARK: - MainScreen
final class MainScreen: UIViewController {
	
	//MARK: - Property
	lazy var tableView = createTableView()
	internal var tableHeaderView = MainHeaderView()
	private var animation = Animations()
	internal var tableHeaderViewTopConstraint: NSLayoutConstraint?
	private var networkDataFetcher = NetworkDataFetcher()
	var presenter: MainScreenPresenterProtocol!
	private var sender = 0
	
	//MARK: - viewDidLoad
	override func viewDidLoad() {
		super.viewDidLoad()
		addSubview()
		layout()
		scrollToCategoryTableView()
		navItem()
	}
	
	//MARK: - Actions

	private func scrollToCategoryTableView() {
		tableHeaderView.complitionSender = { [weak self] sender in
			guard let self = self else { return }
			self.sender = sender
			self.tableView.scrollToRow(at: IndexPath(row: 0, section: sender), at: .top, animated: true)
			UIView.animate(withDuration: 0.3) {
				self.view.layoutIfNeeded()
			}
		}
	}
	
	private func setValues(cell: CustomCell, item: Product) {
		cell.titleLabel.text = item.name
		cell.descript.text = item.description
		cell.buttonPrice.text = "oт \(item.price) р"
	}
	
	@objc func leftNavItem() {
		print(#function)
	}
}

//MARK: - extension
extension MainScreen: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter.sectionStruct[section].row.count
	}
	
	func addData(indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
		let item = presenter.sectionStruct[indexPath.section].row[indexPath.row]
		networkDataFetcher.loadImage(item: item, cell: cell)
		setValues(cell: cell, item: item)
		return cell
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return addData(indexPath: indexPath)
	}
	
	func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
		print(section)
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		presenter.sectionStruct.count
	}
	
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return presenter.sectionStruct[section].header
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		animation.animateHeaderView(scrollView: scrollView, tableHeaderView: tableHeaderView, topConstraint: tableHeaderViewTopConstraint!, view: self)
	}
}

extension MainScreen: MainScreenProtocol {
	func reloadTableView() {
		self.tableView.reloadData()
	}
}
