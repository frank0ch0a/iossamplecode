//
//  MunicipioCell.swift
//  El Comun
//
//  Created by Francisco Ochoa on 31/05/17.
//  Copyright © 2017 fochoa. All rights reserved.
//

import UIKit
import ImageSlideshow

class MunicipioCell: UITableViewCell {
    
    let myNotification = Notification.Name(rawValue:"MyNotification")
    
    @IBOutlet var slideShow: ImageSlideshow!
    let alamofireSource = [AlamofireSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, AlamofireSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, AlamofireSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]

    override func awakeFromNib() {
        super.awakeFromNib()
        slideShow.backgroundColor = UIColor.white
        slideShow.slideshowInterval = 5.0
        slideShow.pageControlPosition = PageControlPosition.underScrollView
        slideShow.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        slideShow.pageControl.pageIndicatorTintColor = UIColor.black
        slideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        // slideshow.activityIndicator = DefaultActivityIndicator()
        slideShow.currentPageChanged = { page in
            print("current page:", page)
        }
        
        // try out other sources such as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        
        slideShow.setImageInputs(alamofireSource)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(MunicipioCell.didTap))
        slideShow.addGestureRecognizer(recognizer)

        
        
    }
    
    func didTap() {
         print("Hola")
        let nc = NotificationCenter.default
        
        nc.post(name: myNotification, object: nil)
        
        

        // set the activity indicator for full screen controller; skip the line if no activity indicator should be shown
        // fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
