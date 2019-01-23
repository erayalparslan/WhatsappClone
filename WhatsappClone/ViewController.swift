//
//  ViewController.swift
//  WhatsappClone
//
//  Created by Eray on 21.01.2019.
//  Copyright © 2019 Eray Alparslan. All rights reserved.
//

import UIKit
import ProgressHUD


class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setDelegates()
        
        
    }
    
    
    
    
    
    
    
    
    //MARK: Actions
    //===========================================================================
    //===========================================================================
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        closeKeyboard()
        
        if !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty && !repasswordTextField.text!.isEmpty{
            registerUser()
        }
        else {
            ProgressHUD.showError("Missing information")
        }
        
        clearTextFields()
        print("register pressed")
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        closeKeyboard()
        
        if !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty {
            loginUser()
        }
        else {
            ProgressHUD.showError("Missing information")
        }
        
        clearTextFields()
        print("login pressed")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: Methods
    //===========================================================================
    //===========================================================================
    
    func loginUser(){
        
    }
    
    func registerUser() {
        
    }
    
    func setDelegates() {
        emailTextField.delegate      = self
        passwordTextField.delegate   = self
        repasswordTextField.delegate = self
    }
    
    func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    func clearTextFields() {
        emailTextField.text         = ""
        passwordTextField.text      = ""
        repasswordTextField.text    = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    
    

}

