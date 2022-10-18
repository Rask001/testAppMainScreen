//
//  Animations.swift
//  testAppMainScreen
//
//  Created by Антон on 18.10.2022.
//

import Foundation
import UIKit

final class Animations {
	func animateHeaderView(scrollView: UIScrollView, tableHeaderView: MainHeaderView, topConstraint: NSLayoutConstraint, view: UIViewController) {
		let y = scrollView.contentOffset.y
		let swipingDown = y <= 30
		let shouldSnap = y > 30
		let collectionViewHeight = tableHeaderView.collectionView.frame.height
		
		UIView.animate(withDuration: 0.3) {
			tableHeaderView.collectionView.alpha = swipingDown ? 1.0 : 0.0
		}
		
		UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0) {
			topConstraint.constant = shouldSnap ? -collectionViewHeight : 0
			view.view.layoutIfNeeded()
		}
	}
}
