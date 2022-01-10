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
                    MakeAlert.sharedMakeAlert.makeAlert(title: "Error!", message: error?.localizedDescription ?? "Error!", context: self)
                    
                } else {
                    self.performSegue(withIdentifier: "signinToFeedVC", sender: nil)
                    
                }
            }
        } else {
            MakeAlert.sharedMakeAlert.makeAlert(title: "Error", message: "Please fill the blanks!", context: self)

        }
    }
    
    @IBAction func signupBtnClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toSignupVC", sender: nil)
    }
    

    
}

