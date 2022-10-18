//
//  MainScreenSettings.swift
//  testAppMainScreen
//
//  Created by Антон on 18.10.2022.
//

import UIKit

extension MainScreen {
	
	//MARK: - Setup
	internal func createTableView() -> UITableView {
		let tableView = UITableView(frame: .zero, style: .grouped)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
		tableView.backgroundColor = .white
		tableView.layer.cornerRadius = 12
		tableView.bounces = true
		tableView.separatorStyle = .singleLine
		tableView.rowHeight = Constants.tableViewRowHeight
		tableView.isScrollEnabled = true
		tableView.allowsSelection = false
		return tableView
	}
	
	internal func navItem() {
		let leftButtonItem = UIBarButtonItem(
			title: "Москва ▼",
			style: .done,
			target: self,
			action: #selector(leftNavItem)
		)
		self.navigationItem.leftBarButtonItem = leftButtonItem
		self.navigationItem.leftBarButtonItem?.tintColor = .black
	}
	
	//MARK: - AddSubViews
	internal func addSubview() {
		self.view.backgroundColor = .secondarySystemBackground
		self.view.addSubview(tableHeaderView)
		self.view.addSubview(tableView)
	}
	
	//MARK: - Constraints
	internal func layout() {
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
