//
//  ViewController.swift
//  Wines
//
//  Created by Lagash Systems on 29/02/2020.
//  Copyright © 2020 Lagash Systems. All rights reserved.
//

import UIKit

class WineViewController: UITableViewController {
var indicator = UIActivityIndicatorView()
 var wines = [WineModel]()
    var downloadTask: URLSessionDownloadTask?
    
    struct Objects { //  Se crea struct para agrupar los vinos segun tipo

        var sectionName : String!
        var sectionObjects : [WineModel]!
    }
    var objectArray = [Objects]() // generamos un Array de las Struct antes creada
    let winesURLString = "http://static.keepcoding.io/baccus/wines.json"
    let CustomCellIdentifier = "WineCustomCell"
    var groupedItems = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Vinos"
        // Registro el xib de la nueva tableviewcell personalizada, ojo  tener cuidado que este nombre coincida
         let cellNib = UINib(nibName: "WineCustomCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: CustomCellIdentifier)
        tableView.backgroundColor = UIColor(red: 251/255, green: 244/255, blue: 199/255, alpha: 1)
         loadApi()
    }
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = .medium
        indicator.color = .gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    private func loadApi() {
        wines = []
          
           activityIndicator()
           indicator.startAnimating()
        let session = URLSession.shared
        let dataTask = session.dataTask(with: URL(string: winesURLString)!, completionHandler:  { data, response, error in
               
               if let error = error {
                   print("Failure! \(error.localizedDescription)")
                   
               }else if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 {
                   if let data = data {
                    
                    self.wines = self.parse(data: data)
                    self.groupedItems = Dictionary(grouping: self.wines, by: {$0.type}) as NSDictionary
                    for (key, value) in self.groupedItems {
                        print("\(key) -> \(value)")
                        self.objectArray.append(Objects(sectionName: key as? String, sectionObjects: value as? [WineModel]))
                    }
                    print(self.objectArray)
                    
                    DispatchQueue.main.async {
                        self.indicator.stopAnimating()
                        self.indicator.hidesWhenStopped = true
                        self.tableView.reloadData()
                       }
                       return
                   }
               }else{
                   print("Failure! \(response!)")
               }
               DispatchQueue.main.async {
                   self.indicator.stopAnimating()
                   self.indicator.hidesWhenStopped = true
               }
           })
           dataTask.resume()
       }
func parse(data: Data) -> [WineModel] {
   
    
    do {
    let decoder = JSONDecoder()
        let result = try decoder.decode([FailableDecodable<WineModel>].self, from:data).compactMap{$0.base}
        

    return result
    } catch {
    print("JSON Error: \(error)")
    return []
        }
   }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WineDetail" {
            let controller = segue.destination as! WineDetailViewController
            controller.wine = sender as? WineModel
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return objectArray.count // Obtenemos el numero de secciones
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return objectArray[section].sectionObjects.count // Obtenemos los vinos por sección
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: CustomCellIdentifier, for: indexPath) as! WineCustomCellTableViewCell // casteo la nueva cell
        
        let wine = objectArray[indexPath.section].sectionObjects[indexPath.row]
        cell.wineNameLabel.text = wine.name
        cell.wineryNameLabel.text = wine.company
        downloadTask = cell.wineImageView.loadImage(url: URL(string: wine.picture)!)
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let wineModel = objectArray[indexPath.section].sectionObjects[indexPath.row]
        performSegue(withIdentifier: "WineDetail", sender: wineModel)
        
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30  // Definimos la altura  de la sección
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hOrigin = CGPoint(x: 20, y: 2)
        let hSize = CGSize(width: tableView.frame.size.width, height: CGFloat(24))
        let hFrame = CGRect(origin: hOrigin, size: hSize)
        let hView = UIView(frame: hFrame)
        hView.backgroundColor =  UIColor(red: 148/255, green: 17/255, blue: 0/255, alpha: 1)
        let label = UILabel()
        label.text = objectArray[section].sectionName
        label.textColor = .white
        label.frame = hView.frame
         hView.addSubview(label)
        return hView
    }

}




