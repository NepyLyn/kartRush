//
//  ViewController.swift
//  KartRush
//
//  Created by user148325 on 12/1/19.
//  Copyright © 2019 user148325. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class LoginViewController: UIViewController {
    
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var alertLabel: UILabel!
    
    var player: Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func Login(_ sender: UIButton) {
        let db = Firestore.firestore()
        let email = mailTextField.text ?? ""
        let pass = passwordTextField.text ?? ""
        
        if(email == "" && pass == ""){
            self.alertLabel.textColor = UIColor.red
            self.alertLabel.text = "Please fill the blanks"
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: pass){(user, error) in
            if let error = error{
                print(error.localizedDescription)
                self.alertLabel.textColor = UIColor.red
                self.alertLabel.text = "Incorrect pass or email"
                return
            }
            
            //If successful login
            PlayerManager.shared.getPlayer(email: email){
                player in
                print(player.nickname)
                self.player = player
                self.performSegue(withIdentifier: "successfulLogin", sender: nil)
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is KartRushViewController
        {
            let vc = segue.destination as? KartRushViewController
            vc?.player = self.player
        }
    }
    
    @IBAction func unwindToLoginView(_ unwindSegue: UIStoryboardSegue) {
        //Get info from the previous view (email, pass, nickname)
        guard unwindSegue.identifier == "registerUser", let sourceViewController = unwindSegue.source as? RegisterTableViewController else { return }
        let email = sourceViewController.emailTextField.text!
        let pass = sourceViewController.passwordTextField.text!
        let nickname = sourceViewController.nicknameTextField.text!
        
        //Register in Firebase.Auth
        Auth.auth().createUser(withEmail: email, password: pass){(user, error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            //If successful register...
            // Create new Player
            let newPlayer = Player(email: email, nickname: nickname)
            PlayerManager.shared.savePlayerInFirebase(newPlayer: newPlayer)
            self.alertLabel.textColor = UIColor.black
            self.alertLabel.text = "User created successfully, try login"
        }
    }
}

