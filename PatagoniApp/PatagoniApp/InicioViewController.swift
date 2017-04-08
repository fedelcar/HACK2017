//
//  InicioViewController.swift
//  PatagoniApp
//
//  Created by Omar Arias Mele on 8/4/17.
//  Copyright © 2017 OYSGroup SA. All rights reserved.
//

import UIKit

class InicioViewController: UIViewController
{
	var NombreApellido: String?
	var FechaNacimiento: Date?
	var FotoPerfil: UIImage?
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var nombreLabel: UILabel!
	@IBOutlet weak var edadLabel: UILabel!
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		
		self.nombreLabel.text = self.NombreApellido
		self.imageView.image = self.FotoPerfil
		self.imageView.contentMode = .scaleAspectFill
		self.edadLabel.text = "\(String(self.FechaNacimiento!.age)) Años"
    }
	override func viewDidLayoutSubviews()
	{
		imageView.layer.cornerRadius = imageView.frame.size.width/2
		imageView.layer.masksToBounds = true
	}
	override func viewWillAppear(_ animated: Bool)
	{
		UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
	}
	override func viewWillDisappear(_ animated: Bool)
	{
		UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
	}
    override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
    }
	
	
	
}
