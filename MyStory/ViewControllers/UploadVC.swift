//
//  UploadVC.swift
//  MyStory
//
//  Created by Vahit Emre TELLİER on 7.01.2022.
//

import UIKit
import Firebase
import grpc

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    

    @IBOutlet weak var uploadImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        uploadImg.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
        uploadImg.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func choosePhoto(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadImg.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    


    @IBAction func uploadBtnClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageRefrence = storage.reference()
        
        let mediaFolder = storageRefrence.child("media")
        
        if let data = uploadImg.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            let imageRefrence = mediaFolder.child("\(uuid).jpg")
            
            imageRefrence.putData(data, metadata: nil) { data, error in
                if error != nil {
                    
                    MakeAlert.sharedMakeAlert.makeAlert(title: "Error", message: error?.localizedDescription ?? "error", context: self)
                } else {
                    imageRefrence.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
//                            Firebasae Store
                            
                            let fireStore = Firestore.firestore()
                            
                            fireStore.collection("Stories").whereField("storyOwner", isEqualTo: UserSingleton.sharedUserInfo.userName).getDocuments { snapshot, error in
                                if error != nil {
                                    
                                    MakeAlert.sharedMakeAlert.makeAlert(title: "Error!", message: error?.localizedDescription ?? "Error", context: self)
                                } else {
                                    if snapshot?.isEmpty == false && snapshot != nil {
                                        for document in snapshot!.documents {
                                            
                                            let documentId = document.documentID
                                            
                                            if var imageUrlArray = document.get("imgUrlArray") as? [String] {
                                                imageUrlArray.append(imageUrl!)
                                                
                                                let additionalDictionary = ["imgUrlArray" : imageUrlArray] as [String : Any]
                                                
                                                fireStore.collection("Stories").document(documentId).setData(additionalDictionary, merge: true) { error in
                                                    if error == nil {
                                                        self.tabBarController?.selectedIndex = 0
                                                        self.uploadImg.image = UIImage(named: "Select.png")
                                                    }
                                                }
                                            }
                                            
                                        }
                                    } else {
                                        
                                        let snapDictionary = ["imgUrlArray" : [imageUrl!], "storyOwner" : UserSingleton.sharedUserInfo.userName, "date" : FieldValue.serverTimestamp()] as [String : Any]
                                        fireStore.collection("Stories").addDocument(data: snapDictionary) { error in
                                            if error != nil {
                                                MakeAlert.sharedMakeAlert.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error", context: self)
                                            } else {
            //                                    go to FeedVC
                                                self.tabBarController?.selectedIndex = 0
            //                                    change image
                                                self.uploadImg.image = UIImage(named: "Select.png")
                                            }
                                        }
                                        
                                    }
                                }
                            }
                            
                            

                        }
                    }
                }
            }
        }
    }
    

    
}
