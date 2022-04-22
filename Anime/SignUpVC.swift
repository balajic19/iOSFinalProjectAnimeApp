//
//  SignUpVC.swift
//  AnimeApp
//
//  Created by
// Balaji Chandupatla
// Shiva Rama Krishna nutakki
// Alekhya Gollamudi
// Kavya Chapparapu
// Satya Venkata Rohit
//
//

import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtpassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        let backButton = UIBarButtonItem(image: UIImage.init(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem  = backButton
        
    }
    
    
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signUpButtonOnTapped(_ sender: Any) {
        if let name = txtName.text,
           let emailAddress = txtEmailAddress.text,
           let password = txtpassword.text, !name.isEmpty, !emailAddress.isEmpty, !password.isEmpty {
            
            let dict = ["name": name, "emailAddress": emailAddress,"password": password]
            DatabaseHelper.shareInstance.save(object: dict as! [String: String])
            
            self.navigationController?.popViewController(animated: true)
            
        } else {
            let alert = UIAlertController(title: "Alert", message: "Please fill all details", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
