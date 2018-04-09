//
//  editemployeeViewController.swift
//  MiniProject
//
//  Created by MacMini-03 on 4/4/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

class editemployeeViewController: UIViewController, UITextFieldDelegate, selectkantordelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var NamaEmployeeTextField: UITextField!
    @IBOutlet var AlamatEmployeeTextField: UITextField!
    @IBOutlet var JenisKelaminTextField: UITextField!
    @IBOutlet var UsernameTextField: UITextField!
    @IBOutlet var PasswordTextField: UITextField!
    @IBOutlet var ConfirmPasswordTextField: UITextField!
    @IBOutlet var LevelEmployeeTextField: UITextField!
    @IBOutlet var idKantorTextField: UITextField!
    
    var selectedemployee: [String: String]?
    var selectedkantor: [String:String]?
    var gender = ["Laki-laki", "Perempuan"]
    var posisi = ["Kurir", "Staff", "Manager"]
    var pickerviewGWpunya = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        pickUp(JenisKelaminTextField)
        pickUp(LevelEmployeeTextField)
        self.NamaEmployeeTextField.text = self.selectedemployee?["NamaEmployee"]
        self.AlamatEmployeeTextField.text = self.selectedemployee?["AlamatEmployee"]
        self.JenisKelaminTextField.text = self.selectedemployee?["JenisKelamin"]
        self.LevelEmployeeTextField.text = self.selectedemployee?["LevelEmployee"]
        self.idKantorTextField.text = self.selectedemployee?["idKantor"]
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
            self.LevelEmployeeTextField.text = posisi[row]
        } else {
            self.JenisKelaminTextField.text = gender[row]
        }
    }
    
    @objc func doneClick() {
        JenisKelaminTextField.resignFirstResponder()
        LevelEmployeeTextField.resignFirstResponder()
    }
    @objc func cancelClick() {
        JenisKelaminTextField.resignFirstResponder()
        LevelEmployeeTextField.resignFirstResponder()
    }
    
    @IBAction func updateButtonDidtapped(_ sender: UIButton){
        if self.NamaEmployeeTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Nama Lengkap Tidak Boleh Kosong")
            return
        }
        if self.AlamatEmployeeTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "alamat Tidak Boleh Kosong")
            return
        }
        if self.JenisKelaminTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "jenis kelamin Tidak Boleh Kosong")
            return
        }
        if self.UsernameTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Username Tidak Boleh Kosong")
            return
        }
        if self.PasswordTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Password Tidak Boleh Kosong")
            return
        }
        if self.ConfirmPasswordTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Confirm pasword Tidak Boleh Kosong")
            return
        }
        if self.LevelEmployeeTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Posisi / Jabatan Tidak Boleh Kosong")
            return
        }
        if self.idKantorTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Kantor Tidak Boleh Kosong")
            return
        }
            if self.PasswordTextField.text != self.ConfirmPasswordTextField.text {
                Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Password is not matched!")
                return
            }
        
        let param: [String: String] = [
            "idEmployee": (self.selectedemployee?["idEmployee"])!,
            "NamaEmployee": self.NamaEmployeeTextField.text!,
            "AlamatEmployee": self.AlamatEmployeeTextField.text!,
            "JenisKelamin": self.JenisKelaminTextField.text!,
            "UsernameEmployee": self.UsernameTextField.text!,
            "PasswordEmployee": self.PasswordTextField.text!,
            "LevelEmployee": self.LevelEmployeeTextField.text!,
            "NamaKantor": self.idKantorTextField.text!
        ]
        

        
        if DBWrapper.sharedInstance.doUpdateEmployee(dataEmployee: param) == true {
            let alert = UIAlertController(title: "SUCCESS", message: "Your data Updated!", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (action ) in
                
                alert.dismiss(animated: true, completion: nil)
                
                self.navigationController?.popViewController(animated: true)
                
            })
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
            //            Utilities.sharedInstance.showAlert(obj: self, title: "SUCCESS", message: "Movie Updated!")
        } else {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Something wrong!")
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
        if textField == self.idKantorTextField {
            self.performSegue(withIdentifier: "kantorsegue", sender: self)
        }
        return false
    }
    
    func selectkantorwilldismiss(param: [String : String]) {
        self.idKantorTextField.text = param["NamaKantor"]!
        self.selectedkantor = param
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
