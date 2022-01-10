//
//  SettingsVC.swift
//  MyStory
//
//  Created by Vahit Emre TELLİER on 7.01.2022.
//

import UIKit
import Firebase

class SettingsVC: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutBtnClicked(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toSigninFromSettings", sender: nil)
        } catch {

            MakeAlert.sharedMakeAlert.makeAlert(title: "Error", message: error.localizedDescription, context: self)
        }
    }

}
