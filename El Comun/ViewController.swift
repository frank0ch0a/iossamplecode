//
//  ViewController.swift
//  El Comun
//
//  Created by Francisco Ochoa on 10/05/17.
//  Copyright © 2017 fochoa. All rights reserved.
//

import UIKit

protocol ShowDetailDelegate {
    func showDetail(_ displayText:String)
}


class ViewController: UIViewController {
      let myNotification = Notification.Name(rawValue:"MyNotification")
    
    let imageHeight:CGFloat = 150.0
    let OffsetSpeed: CGFloat = 25.0
    var categories = ["","Experiencia por Municipios", "Viajando con la gente del Comun", "Destinos destacados", "En Familia"]

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let nc = NotificationCenter.default
        nc.addObserver(forName:myNotification, object:nil, queue:nil, using:catchNotification)
         
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        /*   if let detailPage = segue.destination as? DetailSiteTableViewController,
         let displayString = sender as? String {
         detailPage.displayString = displayString
         }*/
    }
    
    func catchNotification(notification:Notification) -> Void {
        print("Catch notification")
        

        self.performSegue(withIdentifier: "goToMunicipio", sender: self)

    }
    
    
}

extension ViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "header") as! HeaderCell
        
        if section != 0 {
            
        
        
        cell.name = categories[section]
        // add a tap gesture to the section header.
        // this should be done inside the HeaderCell class,
        // but it's more convenient to have the target action in the table view
        // so you can convert the tap coordinates to a table secion.
        let tapHeader = UITapGestureRecognizer(target: self, action: #selector(ViewController.tappedOnHeader(_:)))
        tapHeader.delegate = self
        tapHeader.numberOfTapsRequired = 1
        tapHeader.numberOfTouchesRequired = 1
        cell.contentView.addGestureRecognizer(tapHeader)
        return cell
            
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 0
        }
        
        return 44
    }
    
    
    
    func tappedOnHeader(_ gesture:UIGestureRecognizer){
        // the view that the gesture recognizer grabbed onto
        if let cellContentView = gesture.view {
            // convert tap coordinates from the section header space to the table view space
            let tappedPoint = cellContentView.convert(cellContentView.bounds.origin, to: tableView)
            // tableView.indexPathForRowAtPoint is a great method.
            // unfortunately, it does not work on section headers!
            // sadly, if you use this, it will work on every section EXCEPT for section 0 ("Action")
            //
            // one way to get around this is to brute-force it:
            // get the rectangular area of each table section header,
            // and then see if the tapped point fits inside.
            for i in 0..<tableView.numberOfSections {
                let sectionHeaderArea = tableView.rectForHeader(inSection: i)
                if sectionHeaderArea.contains(tappedPoint) {
                    print("tapped on category:: \(categories[i])")
                }
            }
        }
    }




}

extension ViewController : UITableViewDataSource {
    
    /*func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
        }
        return categories[section]
    }*/
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        else  {
            return 1
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell") as! MainCell
            return cell

        }else if indexPath.section == 1 {
            
             let cell = tableView.dequeueReusableCell(withIdentifier: "MunicipioCell") as! MunicipioCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CategoryRow
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 181
        }else if indexPath.section == 1{
            return 189
        }
        
        return  189
    }
    
}

// Had to add this, even though it doesn't do anything.
extension ViewController : UIGestureRecognizerDelegate { }

extension ViewController : ShowDetailDelegate {
    func showDetail(_ displayText:String){
        performSegue(withIdentifier: "ShowDetail", sender: displayText)
    }
}
