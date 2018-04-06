//
//  tambahemployeeViewController.swift
//  MiniProject
//
//  Created by MacMini-03 on 4/4/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

class tambahemployeeViewController: UIViewController {

    @IBOutlet var NamaEmployeeTextField: UITextField!
    @IBOutlet var AlamatEmployeeTextField: UITextField!
    @IBOutlet var JenisKelaminTextField: UITextField!
    @IBOutlet var LevelEmployeeTextField: UITextField!
    @IBOutlet var idKantorTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func savebutton(_ sender: UIButton){
        // VALIDATION
        if self.NamaEmployeeTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "nama Kota Cannot Be Empty!")
            return
        }
        if self.AlamatEmployeeTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "region Kota Cannot Be Empty!")
            return
        }
        if self.JenisKelaminTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "nama Kota Cannot Be Empty!")
            return
        }
        if self.LevelEmployeeTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "region Kota Cannot Be Empty!")
            return
        }
        if self.idKantorTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Kantor Kota Cannot Be Empty!")
            return
        }
        let param: [String: String] = [
            "NamaEmployee": self.NamaEmployeeTextField.text!,
            "AlamatEmployee": self.AlamatEmployeeTextField.text!,
            "JenisKelamin": self.JenisKelaminTextField.text!,
            "LevelEmployee": self.LevelEmployeeTextField.text!,
            "idKantor": self.idKantorTextField.text!
            ]
        if DBWrapper.sharedInstance.doInsertEmployee(dataEmployee: param) == true {
            Utilities.sharedInstance.showAlert(obj: self, title: "SUCCESS", message: "Success inserting Employee")
            self.navigationController?.popViewController(animated: true)
        } else {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Failed to insert Employee")
        }
        
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
