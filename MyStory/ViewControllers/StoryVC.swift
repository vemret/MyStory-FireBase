//
//  SnapVC.swift
//  MyStory
//
//  Created by Vahit Emre TELLİER on 7.01.2022.
//

import UIKit
import ImageSlideshow



class StoryVC: UIViewController {

    @IBOutlet weak var timeLeftLabel: UILabel!
    

    
    var selectedStory : Story?
    var inputArray = [AlamofireSource]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.


        
        if let story = selectedStory {
            
            timeLeftLabel.text = "Time Left : \(story.timeDifference)"
            
            for imageUrl in story.imgUrlArray {
                inputArray.append(AlamofireSource(urlString: imageUrl)!)
                print(imageUrl)
            }
            
            
            let imageSlideShow = ImageSlideshow(frame: CGRect(x: 10, y: 10, width: self.view.frame.width * 0.95, height: self.view.frame.height * 0.95))
            imageSlideShow.backgroundColor = UIColor.white
            
//            pageIndicator
            let pageIndicator = UIPageControl()
            pageIndicator.currentPageIndicatorTintColor = UIColor.lightGray
            pageIndicator.tintColor = UIColor.black
            imageSlideShow.pageIndicator = pageIndicator
            
            
            imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
            imageSlideShow.setImageInputs(inputArray)
            self.view.addSubview(imageSlideShow)
//            seçilen label hep önde gösterilecek
            self.view.bringSubviewToFront(timeLeftLabel)
        }
        
    }
    

}
