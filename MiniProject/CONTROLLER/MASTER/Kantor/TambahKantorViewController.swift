//
//  TambahKantorViewController.swift
//  MiniProject
//
//  Created by MacMini-03 on 3/29/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

class TambahKantorViewController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet var namakantorTextField: UITextField!
    @IBOutlet var TingkatanKantorTextField: UITextField!
    @IBOutlet var alamatkantorTextField: UITextField!
    var cabang = ["Cabang", "Pusat"]
    var myPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickUp(TingkatanKantorTextField)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func pickUp(_ textField : UITextField){
        
        // UIPickerView
        self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.myPickerView.delegate = self
        self.myPickerView.dataSource = self
        self.myPickerView.backgroundColor = UIColor.white
        textField.inputView = self.myPickerView
        
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
        return cabang.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cabang[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.TingkatanKantorTextField.text = cabang[row]
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickUp(TingkatanKantorTextField)
    }
    @objc func doneClick() {
        TingkatanKantorTextField.resignFirstResponder()
    }
    @objc func cancelClick() {
        TingkatanKantorTextField.resignFirstResponder()
    }
    @IBAction func savebutton(_ sender: UIButton){
        // VALIDATION
        if self.namakantorTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Nama Kantor Tidak Boleh Kosong!")
            return
        }
        if self.TingkatanKantorTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Tingkatan Kantor Tidak Boleh Kosong!")
            return
        }
        if self.alamatkantorTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Alamat Kantor Tidak Boleh Kosong!")
            return
        }
        let param: [String: String] = [
            "NamaKantor": self.namakantorTextField.text!,
            "TingkatanKantor": self.TingkatanKantorTextField.text!,
            "AlamatKantor": self.alamatkantorTextField.text!
        ]
        if DBWrapper.sharedInstance.doInsertkantor(kantorData: param) == true {
            Utilities.sharedInstance.showAlert(obj: self, title: "SUCCESS", message: "Berhasil memasukkan kantor")
            self.navigationController?.popViewController(animated: true)
        } else {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "maaf, ada kesalahan input")
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
