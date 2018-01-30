//
//  CategoryRow.swift
//  El Comun
//
//  Created by Francisco Ochoa on 10/05/17.
//  Copyright © 2017 fochoa. All rights reserved.
//

import UIKit

class CategoryRow: UITableViewCell {
    
    var categoryName:String? = nil
    
     var mainData = DataConnect()
    

     var showDetailDelegate:ShowDetailDelegate? = nil

   @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        mainData.downloadData {
            
            print(self.mainData.searchResults)
            
            self.collectionView.reloadData()
            
        }
    }
    
    
    
    
}

extension CategoryRow : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return mainData.searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCell
        
       let searchResult = mainData.searchResults[indexPath.row]
        
        cell.imageView.af_setImage(withURL: URL(string: searchResult.artworkSmallURL)!)
    
        cell.nameLabel.text! = searchResult.name
        
        return cell
    }
    
}

extension CategoryRow : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? ImageCell {
            
            let displayText = "selected cell number: \(indexPath.row) from category: \(String(describing: selectedCell.categoryName))"
            showDetailDelegate?.showDetail(displayText)
        
      
        }

    }
}

extension CategoryRow : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 149, height: 170)
    }
    
}
