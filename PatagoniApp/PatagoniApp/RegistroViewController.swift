//
//  RegistroViewController.swift
//  PatagoniApp
//
//  Created by Omar Arias Mele on 8/4/17.
//  Copyright © 2017 OYSGroup SA. All rights reserved.
//

import UIKit

class RegistroViewController: UIViewController
{

    @IBOutlet weak var pataicon: UIImageView!
	@IBOutlet weak var txtNombre: UITextField!
	@IBOutlet weak var txtFechaNac: UITextField!
	@IBOutlet weak var txtEmail: UITextField!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var datePicker: UIDatePicker!
	@IBOutlet weak var registrarButton: UIButton!
	@IBOutlet weak var mainView: UIView!
	@IBOutlet weak var listoButton: UIButton!
	var imagePicker: UIImagePickerController!
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		self.datePicker.isHidden = true
		self.listoButton.isHidden = true
		self.datePicker.setValue(UIColor.white, forKeyPath: "textColor")
		self.initializeTextfields()
		
		let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.viewTapped (_:)))
		self.mainView.addGestureRecognizer(gesture)
		
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
	
	
	func viewTapped(_ sender:UITapGestureRecognizer){
		self.view.endEditing(true)
	}
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		if let dest = segue.destination as? InicioViewController
		{
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "dd/MM/yyyy"
			let date =  dateFormatter.date(from: self.txtFechaNac.text!)
			
			dest.NombreApellido = self.txtNombre.text!
			dest.FotoPerfil = self.imageView.image!
			dest.FechaNacimiento = date
		}
	}
	
	fileprivate func initializeTextfields()
	{
		self.txtNombre.borderStyle = UITextBorderStyle.none
//		self.txtNombre.layer.addSublayer(self.getBottomBorder(tf: self.txtNombre, color: UIColor.white))
		self.txtNombre.attributedPlaceholder = self.getPlaceholder(tf: self.txtNombre)
		self.txtNombre.delegate = self
		
		self.txtFechaNac.attributedPlaceholder = self.getPlaceholder(tf: self.txtFechaNac)
		self.txtFechaNac.delegate = self
		self.txtFechaNac.borderStyle = UITextBorderStyle.none
//		self.txtFechaNac.layer.addSublayer(self.getBottomBorder(tf: self.txtFechaNac, color: UIColor.white))
		
		self.txtEmail.attributedPlaceholder = self.getPlaceholder(tf: self.txtEmail)
		self.txtEmail.delegate = self
		self.txtEmail.borderStyle = UITextBorderStyle.none
//		self.txtEmail.layer.addSublayer(self.getBottomBorder(tf: self.txtEmail, color: UIColor.white))
        
        self.imageView.layer.cornerRadius = imageView.frame.size.width/2
        self.imageView.layer.masksToBounds = true
	}
    
	fileprivate func getBottomBorder(tf: UITextField, color: UIColor) -> CALayer
	{
		let bottomLine = CALayer()
		bottomLine.frame = CGRect(x: 0.0, y: tf.frame.height - 1, width: self.view.frame.width * 0.95, height: 1.0)
		bottomLine.backgroundColor = color.cgColor
		return bottomLine
	}
	fileprivate func getPlaceholder(tf: UITextField) -> NSAttributedString
	{
		let txt = tf.placeholder!
		let color = UIColor.white.withAlphaComponent(0.6)
		return NSAttributedString(string: txt, attributes: [NSForegroundColorAttributeName: color])
	}
	fileprivate func showAlert(_ mensaje: String)
	{
		let alertController = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
		self.present(alertController, animated: true, completion: nil)
	}
	fileprivate func setTimeout(delay:TimeInterval, block:@escaping ()->Void) -> Timer
	{
		return Timer.scheduledTimer(timeInterval: delay, target: BlockOperation(block: block), selector: #selector(Operation.main), userInfo: nil, repeats: false)
	}
	
	
	@IBAction func tomarFotoAction(_ sender: UIButton)
	{
		self.datePicker.isHidden = true
		self.listoButton.isHidden = true
		self.imagePicker =  UIImagePickerController()
		self.imagePicker.delegate = self
		self.imagePicker.sourceType = .camera
  
		self.present(imagePicker, animated: true, completion: nil)
	}
	@IBAction func registrarAction(_ sender: UIButton)
	{
		if(self.txtNombre.text == "")
		{
			self.showAlert("Complete todos los campos y añada su foto")
			return
		}
		if(self.txtEmail.text == "")
		{
			self.showAlert("Complete todos los campos y añada su foto")
			return
		}
		if(self.txtFechaNac.text == "")
		{
			self.showAlert("Complete todos los campos y añada su foto")
			return
		}
		if(self.imageView.image == UIImage(named: "emptyUser"))
		{
			self.showAlert("Complete todos los campos y añada su foto")
			return
		}
		
		
		
		SwiftSpinner.show("Registrando Usuario")
		
		_ = self.setTimeout(delay: TimeInterval(3))
		{ _ in
			SwiftSpinner.hide()
		}
		
		self.performSegue(withIdentifier: "goToInicioSegue", sender: self)
		
		
		
	}
	@IBAction func listoAction(_ sender: UIButton)
	{
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd/MM/yyyy"
		let date =  dateFormatter.string(from: self.datePicker.date)
		
		self.txtFechaNac.text = date
		self.datePicker.isHidden = true
		self.listoButton.isHidden = true
        self.pataicon.isHidden = false
		self.registrarButton.isHidden = false
	}
}

extension RegistroViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
	{
		if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
			self.imageView.contentMode = .scaleAspectFit
			self.imageView.image = pickedImage
		}
		dismiss(animated:true, completion: nil)
	}
}

extension RegistroViewController: UITextFieldDelegate
{
	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
	{
		if textField.tag == 2
		{
			self.datePicker.isHidden = false
			self.listoButton.isHidden = false
            self.pataicon.isHidden = true
			self.registrarButton.isHidden = true
			self.view.endEditing(true)
			return false
		}
		else
		{
            self.pataicon.isHidden = false
			self.datePicker.isHidden = true
			self.listoButton.isHidden = true
			self.registrarButton.isHidden = false
		}
		return true
	}
	func textFieldShouldReturn(_ textField: UITextField) -> Bool
	{
		textField.resignFirstResponder()
		return true
	}
}
