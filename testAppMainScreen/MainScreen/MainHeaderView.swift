//
//  MainHeaderView.swift
//  testAppMainScreen
//
//  Created by Антон on 17.10.2022.
//

import UIKit

final class MainHeaderView: UIView {
  let collectionView = CollectionView()
  let scrollView = UIScrollView()
	weak var mainScreen: MainScreen?
	private let stackView = UIStackView()
	private var lastSelectedButton = UIButton()
	private var tagButton = 0
	private var sectionNumber = 0
	private var buttonCategoryArray = [Constants.burgers, Constants.combo, Constants.deserts, Constants.drinks]
	var complitionSender: ((Int) -> ())?
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		setCells()
		addSubview()
		layout()
		setupStackView()
		createScrollView()
		setupScrollView()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension MainHeaderView {
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
	
	private func createScrollView() {
		let array = createButtons(input: buttonCategoryArray)
		addButtonToStackView(input: array)
	}
	
	@objc func tapToCategory(sender: UIButton) {
		self.lastSelectedButton.isSelected = false
		self.lastSelectedButton.backgroundColor = .secondarySystemBackground
		self.lastSelectedButton.layer.borderWidth = 1
		self.lastSelectedButton = sender
		sender.isSelected = true
		sender.backgroundColor = Constants.borderColor20
		sender.layer.borderWidth = 0
		tagButton = sender.tag
		getSenderTag(sender: sender)
	}
	
	func getSenderTag(sender: UIButton) {
		complitionSender!(sender.tag)
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
	
	func setCells() {
		collectionView.set(cells: CollectionModel.fetchArray())
	}
	
	
	//MARK: - AddSubViews
		private func addSubview() {
			addSubview(collectionView)
			addSubview(scrollView)
			scrollView.addSubview(stackView)
		}
	
	//MARK: - Layout
	func layout() {
		self.collectionView.translatesAutoresizingMaskIntoConstraints = false
		self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		self.collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		
		self.stackView.translatesAutoresizingMaskIntoConstraints = false
		self.stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
		self.stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
		self.stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
		self.stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
		
		self.scrollView.translatesAutoresizingMaskIntoConstraints = false
		self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		self.scrollView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
		self.scrollView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor).isActive = true
		self.scrollView.heightAnchor.constraint(equalToConstant: 80).isActive = true
	}
}
