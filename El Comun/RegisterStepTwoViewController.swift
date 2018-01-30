//
//  RegisterStepTwoViewController.swift
//  El Comun
//
//  Created by Francisco Ochoa on 20/06/17.
//  Copyright © 2017 fochoa. All rights reserved.
//

import UIKit

class RegisterStepTwoViewController: UIViewController, UITextViewDelegate,UITextFieldDelegate{
    
    
    @IBOutlet var birthdayTextField: UITextField!

    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var municipioTextField: UITextField!
    
    
    @IBOutlet var termsTextView: UITextView!
    let termsAndConditionsURL = "http://www.example.com/terms";
    let privacyURL = "http://www.example.com/privacy";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        birthdayTextField.useUnderline2()
        emailTextField.useUnderline2()
        municipioTextField.useUnderline2()
      
        
        
        
        // create the attributed colour
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let attributedStringColour : NSDictionary = [NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 16),NSParagraphStyleAttributeName: paragraph];
        self.termsTextView.delegate = self
        let str = "Al pulsar “Continuar” o “Crear cuenta” acepto las Condiciones de Servicio y privacidad de la aplicación."
        let attributedString = NSMutableAttributedString(string: str, attributes: attributedStringColour as? [String : AnyObject])
        var foundRange = attributedString.mutableString.range(of: "Condiciones de Servicio")
        
        attributedString.addAttributes([NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue], range: foundRange)
        
        attributedString.addAttribute(NSLinkAttributeName, value: termsAndConditionsURL, range: foundRange)
        foundRange = attributedString.mutableString.range(of: "privacidad")
        
        attributedString.addAttributes([NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue], range: foundRange)
        attributedString.addAttribute(NSLinkAttributeName, value: privacyURL, range: foundRange)
        termsTextView.attributedText = attributedString
        

    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        if (URL.absoluteString == termsAndConditionsURL) {
            let myAlert = UIAlertController(title: "Terms", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(myAlert, animated: true, completion: nil)
        } else if (URL.absoluteString == privacyURL) {
            let myAlert = UIAlertController(title: "Conditions", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(myAlert, animated: true, completion: nil)
        }
        return false
    }
    

    @IBAction func backButtonPressed(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "goToLastStep", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UITextField {
    func useUnderline2() {
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width+50, height: self.frame.size.height))
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}



