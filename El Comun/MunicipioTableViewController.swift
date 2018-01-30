//
//  MunicipioTableViewController.swift
//  El Comun
//
//  Created by Francisco Ochoa on 23/05/17.
//  Copyright © 2017 fochoa. All rights reserved.
//

import UIKit
import ImageSlideshow
import MapKit
import AARatingBar
class MunicipioTableViewController: UITableViewController {

    @IBOutlet var photoLabel: UILabel!
    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var ratingBar: AARatingBar!
    let alamofireSource = [AlamofireSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, AlamofireSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, AlamofireSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]

    var selectedRowIndex = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slideShow.backgroundColor = UIColor.white
        slideShow.slideshowInterval = 5.0
        slideShow.pageControlPosition = PageControlPosition.underScrollView
        slideShow.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        slideShow.pageControl.pageIndicatorTintColor = UIColor.black
        slideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        // slideshow.activityIndicator = DefaultActivityIndicator()
        slideShow.currentPageChanged = { page in
            //print("current page:", page)
        }
        
        // try out other sources such as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        
        slideShow.setImageInputs(alamofireSource)
        
        ratingBar.ratingDidChange = { ratingValue in
            print("Rating: \(ratingValue)")
        }
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(MunicipioTableViewController.didTap))
        slideShow.addGestureRecognizer(recognizer)
        
        let recognizerLabel = UITapGestureRecognizer(target: self, action: #selector(didTapLabel))
        slideShow.addGestureRecognizer(recognizer)
        photoLabel.addGestureRecognizer(recognizerLabel)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(triggerTouchAction))
      
        mapView.addGestureRecognizer(gestureRecognizer)
        
        
    }
    
    func triggerTouchAction() {
        
        print("Map touched")
        
        performSegue(withIdentifier: "showMap", sender: self)
    }
    
    func didTapLabel() {
        
        
        self.performSegue(withIdentifier: "goToRegister", sender: self)
        print("photo")
      //  pickPhoto()
    }
    
    func didTap() {
        _ = slideShow.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller; skip the line if no activity indicator should be shown
        // fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Indexpath \(indexPath.row)")
        
    }

}

extension MunicipioTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func pickPhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            showPhotoMenu()
        } else {
            choosePhotoFromLibrary()
        }
    }
    
    func showPhotoMenu() {
        let alertController = UIAlertController(title: nil, message: nil,
                                                preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default, handler: { _ in self.takePhotoWithCamera() })
        
        alertController.addAction(takePhotoAction)
        
        let chooseFromLibraryAction = UIAlertAction(title: "Choose From Library", style: .default, handler: { _ in self.choosePhotoFromLibrary() })
        
        alertController.addAction(chooseFromLibraryAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func takePhotoWithCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func choosePhotoFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
       // image = info[UIImagePickerControllerEditedImage] as? UIImage
        
       /*if let theImage = image {
            show(image: theImage)
        }*/
        
        //tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}



