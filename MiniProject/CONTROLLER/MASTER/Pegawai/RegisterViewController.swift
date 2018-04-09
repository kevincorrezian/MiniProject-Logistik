//
//  RegisterViewController.swift
//  MiniProject
//
//  Created by MacMini-03 on 3/28/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate, selectkantordelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var namaTextField: UITextField!
    @IBOutlet var alamatTextField: UITextField!
    @IBOutlet var jeniskelaminTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmpasswordTextField: UITextField!
    @IBOutlet var levelTextField: UITextField!
    @IBOutlet var namakantorTextField: UITextField!
    
    var selectedkantor: [String:String]?
    
    var gender = ["Laki-laki", "Perempuan"]
    var posisi = ["Kurir", "Staff", "Manager"]
    var pickerviewGWpunya = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickUp(jeniskelaminTextField)
        pickUp(levelTextField)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func pickUp(_ textField : UITextField){
        
        // UIPickerView
        self.pickerviewGWpunya = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.pickerviewGWpunya.delegate = self
        self.pickerviewGWpunya.dataSource = self
        self.pickerviewGWpunya.backgroundColor = UIColor.white
        textField.inputView = self.pickerviewGWpunya
        
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerviewGWpunya {
            return posisi.count
        } else  {
            return gender.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerviewGWpunya  {
            return posisi[row]
        } else {
            return gender[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerviewGWpunya  {
            self.levelTextField.text = posisi[row]
        } else {
            self.jeniskelaminTextField.text = gender[row]
        }
    }
    
    @objc func doneClick() {
        jeniskelaminTextField.resignFirstResponder()
        levelTextField.resignFirstResponder()
    }
    @objc func cancelClick() {
        jeniskelaminTextField.resignFirstResponder()
        levelTextField.resignFirstResponder()
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
        if self.namakantorTextField.text == "" {
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
        let kantor = self.selectedkantor!["NamaKantor"]!
        
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
        if textField == self.namakantorTextField {
            self.performSegue(withIdentifier: "kantorsegue", sender: self)
            
        }
        return false
    }
    
    func selectkantorwilldismiss(param: [String : String]) {
        self.namakantorTextField.text = param["NamaKantor"]!
        self.selectedkantor = param
    }
}

