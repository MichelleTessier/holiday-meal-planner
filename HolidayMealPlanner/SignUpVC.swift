//
//  SignUpVC.swift
//  HolidayMealPlanner
//
//  Created by Michelle Tessier on 11/3/16.
//  Copyright © 2016 Michelle Tessier. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController, UITextFieldDelegate {

    //UI Elements
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpBox: UIView!
    
    //Constraints
    
    @IBOutlet var yConstraintSignUpBox: NSLayoutConstraint!
    
    weak var shiftedConstraintSignUpBox: NSLayoutConstraint?
    
    //BOOLS
    
    var uiIsShiftedUp : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        formatNextButton()
        formatTextFields()
        registerForNotifications()
        
        uiIsShiftedUp = false
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Additional setup
    
    func registerForNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name:.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidDisappear), name: .UIKeyboardDidHide, object: nil)
        
    }
    
    //MARK: Format views
    
    //Formats the next button
    func formatNextButton() {
        
        nextButton.layer.borderColor = UIColor.init(netHex: 0xED7F69).cgColor
        nextButton.layer.cornerRadius = 45
        nextButton.layer.borderWidth = 6
        nextButton.backgroundColor = UIColor.white
        nextButton.setImage(#imageLiteral(resourceName: "NextArrow"), for: .normal)
    
    }
    
    //Formats all three textfields
    func formatTextFields() {
        
        self.nameTextField.returnKeyType = .next
        self.nameTextField.delegate = self
        self.emailTextField.returnKeyType = .next
        self.emailTextField.delegate = self
        self.passwordTextField.returnKeyType = .done
        self.passwordTextField.delegate = self
        
        
        
    }
    
    //Slides up the sign up box (box containing text fields)
    //For use when sliding box up to allow all textfields to be seen when entering info
    func slideUpSignUpBox(keyboardHeight: CGFloat) {
        
        shiftedConstraintSignUpBox = NSLayoutConstraint.init(item: view,
                                                         attribute: .bottom,
                                                         relatedBy: .equal,
                                                         toItem: signUpBox,
                                                         attribute: .bottom,
                                                         multiplier: 1.0,
                                                         constant: keyboardHeight)
        
        view.removeConstraint(yConstraintSignUpBox)
        
        UIView.animate(withDuration: 0.4) {
            self.view.addConstraint(self.shiftedConstraintSignUpBox!)
            self.uiIsShiftedUp = true
        }
        
        
        
    }
    
    //Slides down the sign up box (box containing text fields)
    //For use when returning UI to normal layout after shifting up to show keyboard
    func slideDownSignUpBox() {
        
        
        if let constraint = shiftedConstraintSignUpBox {
            
            if view.constraints.contains(constraint) {
                
                view.removeConstraint(constraint)
                
                UIView.animate(withDuration: 0.4) {
                    self.view.addConstraint(self.yConstraintSignUpBox)
                    self.uiIsShiftedUp = false
                }
                
            }
        }
  
        
    }
    
   
    
   
    
    //MARK: Notification handlers
    
    //Called when the keyboard is about to appear on the screen
    func keyboardWillAppear(notification: Notification) {
        
        if !uiIsShiftedUp {
            
            //Check for the height of the keyboard
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                let height = keyboardSize.height
                
                //Either way, slide up the keyboard (pass in estimated keyboard height if it doesn't have one
                slideUpSignUpBox(keyboardHeight: height)
                
            } else {
                
                slideUpSignUpBox(keyboardHeight: 250)
            }
            
        }
        
        
    }
    
    //Called when the keyboard has disappeared from the screen
    func keyboardDidDisappear() {
        
        if uiIsShiftedUp == true {
        
            slideDownSignUpBox()
            
        }
        
    }
    
    //MARK: UITextFieldDelegate
    
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        if textField.isEqual(nameTextField) {
            //If the name textfield was returned, highlight the email textfield
            emailTextField.becomeFirstResponder()
            
        } else if textField.isEqual(emailTextField)  {
            //If the email textfield was returned, highlight the password textfield
            passwordTextField.becomeFirstResponder()
            
        } else {
            //If the password textfield was returned, resign the keyboard
            textField.resignFirstResponder()
            
        }
        
        return true
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
