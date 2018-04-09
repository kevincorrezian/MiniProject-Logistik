//
//  EditKantorViewController.swift
//  MiniProject
//
//  Created by Kahlil Fauzan on 01/04/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

class EditKantorViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var namakantorTextField: UITextField!
    @IBOutlet var levelTextField: UITextField!
    @IBOutlet var alamatkantorTextField: UITextField!
    
    var selectedKantor : [String: String]?
    var cabang = ["Cabang", "Pusat"]
    var myPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        pickUp(levelTextField)
        self.namakantorTextField.text = self.selectedKantor?["NamaKantor"]
        self.levelTextField.text = self.selectedKantor?["TingkatanKantor"]
        self.alamatkantorTextField.text = self.selectedKantor?["AlamatKantor"]
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
        self.levelTextField.text = cabang[row]
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickUp(levelTextField)
    }
    @objc func doneClick() {
        levelTextField.resignFirstResponder()
    }
    @objc func cancelClick() {
        levelTextField.resignFirstResponder()
    }
    @IBAction func updatebutton(_ sender: UIButton){
        if self.namakantorTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Nama Kantor Tidak Boleh Kosong!")
            return
        }
        if self.levelTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Tingkatan Kantor Tidak Boleh Kosong!")
            return
        }
        if self.alamatkantorTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Alamat Kantor Tidak Boleh Kosong!")
            return
        }
        
        let param: [String: String] = [
            "idKantor": (self.selectedKantor?["idKantor"])!,
            "NamaKantor": self.namakantorTextField.text!,
            "TingkatanKantor": self.levelTextField.text!,
            "AlamatKantor": self.alamatkantorTextField.text!
        ]
        
        if DBWrapper.sharedInstance.doUpdatekantor(kantorData: param) == true {
            let alert = UIAlertController(title: "SUCCESS", message: "Kantor Berhasil Diedit!", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (action ) in
                
                alert.dismiss(animated: true, completion: nil)
                
                self.navigationController?.popViewController(animated: true)
                
            })
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        } else {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Maaf, Ada Kesalahan")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
