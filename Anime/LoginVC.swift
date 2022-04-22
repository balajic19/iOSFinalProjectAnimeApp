//
//  LoginVC.swift
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

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func loginbButtonTapped(_ sender: Any) {
        
        if let emailAddress = emailTextField.text,
           let password = passwordTextField.text,
           !emailAddress.isEmpty, !password.isEmpty {
            
            if let user = DatabaseHelper.shareInstance.getUser(name: emailAddress) {
                if emailAddress == user.emailAddress, password == user.password {
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AnimeVC") as? AnimeVC
                    self.navigationController?.pushViewController(vc!, animated: true)
                    UserDefaults.standard.set(user.name, forKey: "userName")
                    UserDefaults.standard.synchronize()
                } else {
                    displayAlert(message: "invalid user details")
                }
            } else {
                displayAlert(message: "invalid user details")
            }
        } else {
            displayAlert(message: "Please fill all details")
        }
    }
    
    func displayAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
