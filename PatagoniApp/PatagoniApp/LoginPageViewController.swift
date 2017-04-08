//
//  LoginPageViewController.swift
//  PatagoniApp
//
//  Created by Omar Arias Mele on 8/4/17.
//  Copyright © 2017 OYSGroup SA. All rights reserved.
//

import UIKit

class LoginPageViewController: UIPageViewController
{
	weak var loginDelegate: LoginPageViewControllerDelegate?
	var orderedViewControllers: [UIViewController] = []
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		dataSource = self
		delegate = self
		
		let vc1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Slide1ViewController")
		orderedViewControllers.append(contentsOf: [vc1])
		
		loginDelegate?.loginPageViewController(loginPageViewController: self, didUpdatePageCount: orderedViewControllers.count)
		
		let firstViewController = orderedViewControllers[0]
		setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
	}
	
	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
	}
}

extension LoginPageViewController: UIPageViewControllerDataSource
{
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
	{
		let currentIndex = orderedViewControllers.index(of: viewController)!
		if currentIndex == orderedViewControllers.count - 1 {
			return nil
		}
		let nextIndex = abs((currentIndex + 1) % orderedViewControllers.count)
		return orderedViewControllers[nextIndex]
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
	{
		let currentIndex = orderedViewControllers.index(of: viewController)!
		if currentIndex == 0 {
			return nil
		}
		let previousIndex = abs((currentIndex - 1) % orderedViewControllers.count)
		return orderedViewControllers[previousIndex]
	}
}

extension LoginPageViewController: UIPageViewControllerDelegate
{
	
	func pageViewController(_ pageViewController: UIPageViewController,
	                        didFinishAnimating finished: Bool,
	                        previousViewControllers: [UIViewController],
	                        transitionCompleted completed: Bool)
	{
		if let firstViewController = viewControllers?[0],
			let index = orderedViewControllers.index(of: firstViewController) {
			loginDelegate?.loginPageViewController(loginPageViewController: self, didUpdatePageIndex: index)
		}
	}
	
}

protocol LoginPageViewControllerDelegate: class {
	//Called when the number of pages is updated.
	func loginPageViewController(loginPageViewController: LoginPageViewController, didUpdatePageCount count: Int)
	
	//Called when the current index is updated.
	func loginPageViewController(loginPageViewController: LoginPageViewController, didUpdatePageIndex index: Int)
}
