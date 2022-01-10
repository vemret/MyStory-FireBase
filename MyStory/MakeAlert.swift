//
//  MakeAlert.swift
//  MyStory
//
//  Created by Vahit Emre TELLİER on 9.01.2022.
//

import Foundation
import UIKit

struct MakeAlert {
    
    static let sharedMakeAlert = MakeAlert()
    
    func makeAlert(title : String, message : String , context : UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okBtn)
        context.present(alert, animated: true, completion: nil)
    }
}
