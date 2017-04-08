//
//  ViewController.swift
//  PatagoniApp
//
//  Created by Omar Arias Mele on 8/4/17.
//  Copyright © 2017 OYSGroup SA. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController
{
	
	@IBOutlet weak var containerView: UIView!
	@IBOutlet weak var registroButton: UIButton!
	
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
	}

	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		if let pageViewController = segue.destination as? LoginPageViewController {
			pageViewController.loginDelegate = self
		}		
	}
    override func viewWillAppear(_ animated: Bool)
    {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }

	func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle
	{
		return .none
	}
	
}



extension LoginViewController: LoginPageViewControllerDelegate
{
	
	func loginPageViewController(loginPageViewController: LoginPageViewController, didUpdatePageCount count: Int)
	{
//		self.pageControl.numberOfPages = count
	}
	
	func loginPageViewController(loginPageViewController: LoginPageViewController, didUpdatePageIndex index: Int)
	{
//		self.pageControl.currentPage = index
	}
}
