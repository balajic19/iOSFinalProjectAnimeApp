//
//  profileVC.swift
//  Anime
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

class ProfileVC: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(image: UIImage.init(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem  = backButton

        setUserDetails()
        
    }

    
    func setUserDetails() {
        if let name = UserDefaults.standard.value(forKey: "userName") as? String,
           let user = DatabaseHelper.shareInstance.getUserName(name: name) {
            txtName.text = user.name
            txtEmailAddress.text = user.emailAddress
        }
    }

    @IBAction func favortiesButtonOnTapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AnimeVC") as? AnimeVC
        vc?.isFaviourteView = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func logoutButtonOnTapped(_ sender: Any) {
    
        let alertController = UIAlertController(title: "", message: "Do you want to logout?", preferredStyle: .alert)

        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            UserDefaults.standard.removeObject(forKey: "userName")
            UserDefaults.standard.synchronize()
            
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
            self.navigationController?.pushViewController(vc!, animated: true)

        }
        alertController.addAction(OKAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:nil)

    }
}
