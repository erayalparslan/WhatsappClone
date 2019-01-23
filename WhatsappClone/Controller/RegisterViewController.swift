//
//  RegisterViewController.swift
//  WhatsappClone
//
//  Created by Eray on 23.01.2019.
//  Copyright © 2019 Eray Alparslan. All rights reserved.
//

import UIKit
import ProgressHUD

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var mail         = String()
    var pass         = String()
    var avatarImage  : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        print("mail: \(mail)\npassword: \(pass)")
    }
    
    
    //MARK: IBActions
    //===========================================================================
    //===========================================================================
    @IBAction func cancelButtonDidTap(_ sender: UIButton) {
        print("cancelButton tapped")
        clearTextFields(textFields: [nameTextField, surnameTextField, countryTextField, cityTextField, phoneTextField])
    }
    
    @IBAction func doneButtonDidTap(_ sender: UIButton) {
        print("doneButton tapped")
        ProgressHUD.show("Registering...")
        
        if !nameTextField.text!.isEmpty && !surnameTextField.text!.isEmpty && !countryTextField.text!.isEmpty && !cityTextField.text!.isEmpty && !phoneTextField.text!.isEmpty {
            
            FUser.registerUserWith(email: mail, password: pass, firstName: nameTextField.text!, lastName: surnameTextField.text!) { (error) in
                if error != nil {
                    
                    ProgressHUD.showError(error!.localizedDescription)
                }
                else{
                    self.registerUser()
                }
            }
            
        }
        else {
            ProgressHUD.showError("Missing information")
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: Methods
    //===========================================================================
    //===========================================================================
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func registerUser() {
        let fullName = "\(nameTextField.text!) \(surnameTextField.text!)"
        var tmpDictionary =
            [
                kFIRSTNAME : nameTextField.text!,
                kLASTNAME  : surnameTextField.text!,
                kFULLNAME  : fullName,
                kCOUNTRY   : countryTextField.text!,
                kCITY      : cityTextField.text!,
                kPHONE     : phoneTextField.text!
        ] as [String:Any]
        
        if avatarImage == nil {
            imageFromInitials(firstName: nameTextField.text!, lastName: surnameTextField.text!) { (avatarInitials) in
                let avatarIMG = avatarInitials.jpegData(compressionQuality: 0.7)
                let avatar = avatarIMG!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                
                tmpDictionary[kAVATAR] = avatar
            }
        }
        else {
            let avatarData = avatarImage?.jpegData(compressionQuality: 0.5)
            let avatar = avatarData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            
            tmpDictionary[kAVATAR] = avatar
        }
        
        //finish registering
        finishRegistration(withValues: tmpDictionary)
    }
    
    
    func finishRegistration(withValues dict: [String : Any]) {
        
        updateCurrentUserInFirestore(withValues: dict) { (error) in
            
            if error != nil {
                DispatchQueue.main.async {
                    ProgressHUD.showError(error!.localizedDescription)
                    print(error!.localizedDescription)
                }
                return
            }
            else {
                print("did register")
                ProgressHUD.dismiss()
                self.goToApp()
            }
            
        }
        
    }
    
    func goToApp() {
        clearTextFields(textFields: [nameTextField, surnameTextField, countryTextField, cityTextField, phoneTextField])
        closeKeyboard()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: USER_DID_LOGIN_NOTIFICATION), object: nil, userInfo: [kUSERID : FUser.currentId()])
        
        
        let mainView = UIStoryboard.init(name: "MainTabbarViewController", bundle: nil).instantiateViewController(withIdentifier: "MainTabbarViewController") as! UITabBarController
        
        self.present(mainView, animated: true, completion: nil)
    }
    
    
    
}










//MARK: Extension: UITextFieldDelegate
//===========================================================================
//===========================================================================

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









//MARK: Extension: BaseFunctions
//===========================================================================
//===========================================================================

extension RegisterViewController: BaseFunctions {
    func setDelegates() {
        nameTextField.delegate = self
        surnameTextField.delegate = self
        countryTextField.delegate = self
        cityTextField.delegate = self
        phoneTextField.delegate = self
    }
}
