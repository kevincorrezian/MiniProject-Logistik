//
//  RegisterViewController.swift
//  MiniProject
//
//  Created by MacMini-03 on 3/28/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate, selectkantordelegate {

    @IBOutlet var namaTextField: UITextField!
    @IBOutlet var alamatTextField: UITextField!
    @IBOutlet var jeniskelaminTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmpasswordTextField: UITextField!
    @IBOutlet var levelTextField: UITextField!
    @IBOutlet var idkantorTextField: UITextField!
    
    
    var selectedkantor: [String:String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonDidtapped(_ sender: UIButton){
        if self.namaTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Nama Lengkap Tidak Boleh Kosong")
            self.usernameTextField.layer.borderColor = UIColor.red.cgColor
            
            return
        }
        if self.alamatTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "alamat Tidak Boleh Kosong")
            self.usernameTextField.layer.borderColor = UIColor.red.cgColor
            
            return
        }
        if self.jeniskelaminTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "jenis kelamin Tidak Boleh Kosong")
            self.usernameTextField.layer.borderColor = UIColor.red.cgColor
            
            return
        }
        if self.usernameTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Username Tidak Boleh Kosong")
            self.usernameTextField.layer.borderColor = UIColor.red.cgColor
            
            return
        }
        if self.passwordTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Password Tidak Boleh Kosong")
            self.passwordTextField.layer.borderColor = UIColor.red.cgColor
            
            return
        }
        if self.confirmpasswordTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Confirm pasword Tidak Boleh Kosong")
            self.confirmpasswordTextField.layer.borderColor = UIColor.red.cgColor
            return
        }
        if self.levelTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Posisi / Jabatan Tidak Boleh Kosong")
            self.usernameTextField.layer.borderColor = UIColor.red.cgColor
            
            return
        }
        if self.idkantorTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Kantor Tidak Boleh Kosong")
            self.usernameTextField.layer.borderColor = UIColor.red.cgColor
            
            return
        }
        if self.passwordTextField.text != self.confirmpasswordTextField.text {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Password is not matched!")
            return
        }
        
        let nama = self.namaTextField.text!
        let alamat = self.alamatTextField.text!
        let jeniskelamin = self.jeniskelaminTextField.text!
        let username = self.usernameTextField.text!
        let password = self.passwordTextField.text!
        let level = self.levelTextField.text!
        let kantor = self.selectedkantor!["idKantor"]!
        
        if DBWrapper.sharedInstance.doRegister(nama: nama, alamat: alamat, jeniskelamin: jeniskelamin, username: username, password: password, level: level, kantor: kantor) == true {
            Utilities.sharedInstance.showAlert(obj: self, title: "SUCCESS", message: "Youre now registered!")
        } else {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Register Failed!")
        }
        // Validations
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "kantorsegue" {
            let obj = segue.destination as! KantorViewController
            obj.delegate = self
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.idkantorTextField {
            self.performSegue(withIdentifier: "kantorsegue", sender: self)
            
        }
        return false
    }
    
    func selectkantorwilldismiss(param: [String : String]) {
        self.idkantorTextField.text = param["idKantor"]!
        self.selectedkantor = param
    }
}

