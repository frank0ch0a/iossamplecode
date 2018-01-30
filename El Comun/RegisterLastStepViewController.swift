//
//  RegisterLastStepViewController.swift
//  El Comun
//
//  Created by Francisco Ochoa on 20/06/17.
//  Copyright © 2017 fochoa. All rights reserved.
//

import UIKit

class RegisterLastStepViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var circleView: UIView!
    @IBOutlet var termsTextView: UITextView!
    let termsAndConditionsURL = "http://www.example.com/terms";
    let privacyURL = "http://www.example.com/privacy";
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let saveCenter2: CGPoint = circleView.center
        let newFrame2 = CGRect(x: CGFloat(circleView.frame.origin.x), y: CGFloat(circleView.frame.origin.y), width: CGFloat(128), height: CGFloat(128))
        circleView.frame = newFrame2
        circleView.layer.cornerRadius = 128 / 2.0
        circleView.center = saveCenter2
        circleView.layer.masksToBounds = true
    }
    
    
    @IBAction func photoBtnPressed(_ sender: Any) {
    }
  

    @IBAction func createAccountBtnPressed(_ sender: Any) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
