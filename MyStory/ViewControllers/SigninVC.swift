//
//  ViewController.swift
//  MyStory
//
//  Created by Vahit Emre TELLİER on 7.01.2022.
//

import UIKit
import Firebase

class SigninVC: UIViewController {


    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func signinBtnClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { authData, error in
                if error != nil {
                    self.makeAlert(alertTitle: "Error!", alertMessage: error?.localizedDescription ?? "Error!")
                } else {
                    self.performSegue(withIdentifier: "signinToFeedVC", sender: nil)
                }
            }
        } else {
            makeAlert(alertTitle: "Error", alertMessage: "Please fill the blanks!")
        }
    }
    
    @IBAction func signupBtnClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toSignupVC", sender: nil)
    }
    
    func makeAlert(alertTitle : String, alertMessage : String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let okBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }
    
}

