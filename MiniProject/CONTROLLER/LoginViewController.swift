//
//  LoginViewController.swift
//  MiniProject
//
//  Created by MacMini-03 on 3/28/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LoginButton(_ sender: UIButton){
        // Validation
        if self.usernameTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Username cannot be empty")
            return
        }
        if self.passwordTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Password cannot be empty")
            return
        }
        let username = self.usernameTextField.text!
        let password = self.passwordTextField.text!
        if let userdata = DBWrapper.sharedInstance.doLogin(username: username, password: password) {
            
            
            let def = UserDefaults.standard
            def .synchronize()
            
            self.performSegue(withIdentifier: "homepagesegue", sender: self)
            
            
        } else {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "User not Found")
        }
    }
    @IBAction func registerButtonDidPushed(_ sender: UIButton){
        self.performSegue(withIdentifier: "registersegue", sender: self)
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
