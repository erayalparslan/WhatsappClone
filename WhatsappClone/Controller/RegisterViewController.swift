//
//  RegisterViewController.swift
//  WhatsappClone
//
//  Created by Eray on 23.01.2019.
//  Copyright © 2019 Eray Alparslan. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }
    
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}


extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            case nameTextField:
                surnameTextField.becomeFirstResponder()
            case surnameTextField:
                countryTextField.becomeFirstResponder()
            case countryTextField:
                cityTextField.becomeFirstResponder()
            case cityTextField:
                phoneTextField.becomeFirstResponder()
            default:
                resignFirstResponder()
            }
        return false
    }
}



extension RegisterViewController: BaseFunctions {
    func setDelegates() {
        nameTextField.delegate = self
        surnameTextField.delegate = self
        countryTextField.delegate = self
        cityTextField.delegate = self
        phoneTextField.delegate = self
    }
}
