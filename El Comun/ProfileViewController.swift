//
//  ProfileViewController.swift
//  El Comun
//
//  Created by Francisco Ochoa on 12/05/17.
//  Copyright © 2017 fochoa. All rights reserved.
//

import UIKit

// MARK: - Section Data Structure
//


class ProfileViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileStatiticsView: UIView!
    
    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var userNickLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
   var profileMenu = [Any]()
    override func viewDidLoad() {
        super.viewDidLoad()

       tableView.delegate = self
       tableView.dataSource = self
        
        profileMenu = ["Datos personales","Mis intereses","Recomendar","Editar mi contraseña","Términos y condiciones"]
        
        
        
    }

   
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        
        let saveCenter2: CGPoint = profileImageView.center
        let newFrame2 = CGRect(x: CGFloat(profileImageView.frame.origin.x), y: CGFloat(profileImageView.frame.origin.y), width: CGFloat(80), height: CGFloat(80))
        profileImageView.frame = newFrame2
        profileImageView.layer.cornerRadius = 80 / 2.0
        profileImageView.center = saveCenter2
        profileImageView.layer.masksToBounds = true
        
       
        profileStatiticsView.layer.borderColor = UIColor.lightGray.cgColor
        profileStatiticsView.layer.borderWidth = 1
        
        
    }
    

    
    
}

extension ProfileViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        switch indexPath.row {
        case 0:
                performSegue(withIdentifier: "showProfile", sender: self)
        default:
            break
        }
        
        
    }
      
    }

extension ProfileViewController : UITableViewDataSource{
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileMenu.count
    }
    
    // Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell? ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = profileMenu[indexPath.row] as? String
        cell.textLabel?.font = UIFont(name: "Montserrat-Light", size: 17)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 55
    }
   

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let myImage = UIImage(named: "bannercomun")
        let imageView = UIImageView(image: myImage)
        imageView.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(320), height: CGFloat(122))
        return imageView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 122
    }

        
}

