//
//  SignupVC.swift
//  MyStory
//
//  Created by Vahit Emre TELLİER on 7.01.2022.
//

import UIKit
import Firebase

class SignupVC: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signupBtnClicked(_ sender: Any) {
        
        if (emailTxt.text != "" && userNameTxt.text != "" && passwordTxt.text != ""){
            Auth.auth().createUser(withEmail: emailTxt.text!, password:passwordTxt.text!) { authData, error in
                if error != nil {
//                    self.makeAlert(alertTitle: "Error", alertMessage: error?.localizedDescription ?? "Error")
                    MakeAlert.sharedMakeAlert.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error", context: self)
                    
                } else {
                    
                    let fireStore = Firestore.firestore()
                    let userDictionary = ["email" : self.emailTxt.text!, "username" : self.userNameTxt.text!, "password" : self.passwordTxt.text!] as [String : Any]
                    fireStore.collection("Users").addDocument(data: userDictionary) { error in
                        if error != nil {
                            MakeAlert.sharedMakeAlert.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error", context: self)
                        }
                    }
                    
                    self.performSegue(withIdentifier: "signupToFeedVC", sender: nil)
                }
            }
        } else {
//            self.makeAlert(alertTitle: "Error!", alertMessage: "Please fill the blanks!")
            
            MakeAlert.sharedMakeAlert.makeAlert(title: "Error", message: "Please fill the blanks", context: self)
        }
    }



}
