//
//  RegisterTableViewController.swift
//  KartRush
//
//  Created by user148325 on 12/3/19.
//  Copyright © 2019 user148325. All rights reserved.
//

import UIKit

class RegisterTableViewController: UITableViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateRegisterButton()
        
    }
    
    func updateRegisterButton() {
        let emailText = emailTextField.text ?? ""
        let nicknameText = nicknameTextField.text ?? ""
        let passwordText = passwordTextField.text ?? ""
       
        registerButton.isEnabled = !emailText.isEmpty && !nicknameText.isEmpty && !passwordText.isEmpty && passwordText.count >= 6
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField){
        updateRegisterButton()
    }

}
