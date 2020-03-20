//
//  WineDetailViewController.swift
//  Wines
//
//  Created by Lagash Systems on 06/03/2020.
//  Copyright © 2020 Lagash Systems. All rights reserved.
//

import UIKit

class WineDetailViewController: UIViewController {
  var downloadTask: URLSessionDownloadTask?
    @IBOutlet weak var wineImageView: UIImageView!
    @IBOutlet weak var grape: UILabel!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var typeOfWine: UILabel!
    @IBOutlet weak var wineryLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet var wineRating: [UIImageView]!
    var wine: WineModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
        
       
    }
    
    func getGrapes(grapes: [Grape]) -> String {
        var str = ""
        var array:[String] = []
        if grapes.count == 1{
            
            str = "100 % \(grapes[0].grape)"
        }else{
            
                   for grape in wine!.grapes{
                    array.append(grape.grape)
                    print(grape.grape)
                    }
            str = array.joined(separator: ", ")
        }
        return str
    }
    func displayRating(rating: Int){
        
        let image = UIImage(named: "glass")
        for i in 0..<rating {
            wineRating[i].image = image
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowWeb" {
            let controller = segue.destination as! WebViewController
            controller.urlString = wine!.wineWeb
        }
    }
    
    func updateViews(){
        if let wine = wine {
        displayRating(rating: wine.rating)
        title = wine.name
        grape.text = getGrapes(grapes: wine.grapes)
        wineryLabel.text = wine.company
        typeOfWine.text = wine.type
        origin.text = wine.origin
        descriptionTextView.text = wine.notes
        
        grape.text = getGrapes(grapes: wine.grapes)
        
        downloadTask = wineImageView.loadImage(url: URL(string: wine.picture)!)
       
            
        }
    }
   
   
    
}
