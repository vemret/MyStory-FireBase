//
//  FeedVC.swift
//  MyStory
//
//  Created by Vahit Emre TELLİER on 7.01.2022.
//

import UIKit
import Firebase
import SDWebImage

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let fireStroeDatabase = Firestore.firestore()
    var storyArray  = [Story]()
    var choosenStory : Story?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        tableView
        tableView.delegate = self
        tableView.dataSource = self
        
        getStoriesFromFirebase()
        getInfo()
    }
    
    func getStoriesFromFirebase(){
//        snapshotlistener => her değişiklik olduğunda güncelle
        fireStroeDatabase.collection("Stories").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                self.makeAlert(alertTitle: "Error!", alertMessage: error?.localizedDescription ?? "Error")
            } else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    self.storyArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents {
                        
                        let documentID = document.documentID
                        
                        if let userName = document.get("storyOwner") as? String {
                            if let imgUrlArray = document.get("imgUrlArray") as? [String]{
                                if let date = document.get("date") as? Timestamp {
                                    
                                    if let timeDifference = Calendar.current.dateComponents([.hour], from: date.dateValue(), to: Date()).hour {
                                        if timeDifference >= 24 {
//                                            Delete
                                            self.fireStroeDatabase.collection("Stories").document(documentID).delete { error in
                                                
                                            }
                                        } else {
                                            //                                        TIMELEFT -> StoryVC
                                            //                                        self.timeLeft = 24 - timeDifference
                                            let story = Story(userName: userName, imgUrlArray: imgUrlArray, date: date.dateValue(), timeDifference: 24 - timeDifference)
                                            self.storyArray.append(story)
                                        }

                                        

                                        }

                                    
                                    }
                                }
                            }
                        }
                    self.tableView.reloadData()
                    }
                }
            }
        }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryCell", for: indexPath) as! FeedCell
        cell.userNameTxt.text = storyArray[indexPath.row].userName
        print(storyArray[indexPath.row].userName)
//        cell.userNameTxt.text = storyArray[indexPath.row].userName
        cell.imageView?.sd_setImage(with: URL(string: storyArray[indexPath.row].imgUrlArray[0]))
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStoryDetail" {
            let destinationVC = segue.destination as! StoryVC
            destinationVC.selectedStory = choosenStory
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choosenStory = self.storyArray[indexPath.row]
        performSegue(withIdentifier: "toStoryDetail", sender: nil)
    }

    func getInfo(){
        fireStroeDatabase.collection("Users").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { snapshot, error in
            if error != nil {
                self.makeAlert(alertTitle: "Error!", alertMessage: error?.localizedDescription ?? "Error")
            } else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    for document in snapshot!.documents {
                        if let userName = document.get("username") as? String{
                            UserSingleton.sharedUserInfo.email = Auth.auth().currentUser!.email!
                            UserSingleton.sharedUserInfo.userName = userName
                        }
                    }
                }
            }
        }
    }

    
    func makeAlert(alertTitle : String, alertMessage : String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let okBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }
}
