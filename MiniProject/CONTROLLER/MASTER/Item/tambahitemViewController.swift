//
//  tambahitemViewController.swift
//  MiniProject
//
//  Created by Kahlil Fauzan on 01/04/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

class tambahitemViewController: UIViewController {
    
    @IBOutlet var deskripsiTextView: UITextView!
    @IBOutlet var beratbarangTextField: UITextField!
    @IBOutlet var statuspecahTextField: UITextField!
    @IBOutlet var statusgaransiTextField: UITextField!
    
    
    
    @IBAction func kurangi_berat(_ sender: UIButton) {
        var beratsaatini = Int(self.beratbarangTextField.text!)
        
        if beratsaatini! - 1 > 0 {
            self.beratbarangTextField.text = String(Int(beratbarangTextField.text!)! - 1)
        }
    }
    @IBAction func tambah_berat(_ sender: UIButton) {
    var beratsaatini = Int(self.beratbarangTextField.text!)
        
        if beratsaatini! + 1 <= 10 {
             self.beratbarangTextField.text = String(Int(beratbarangTextField.text!)! + 1)
        }
      
    }
    
    @IBAction func statusgaransiswitch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            statusgaransiTextField.text = "Aktif"
        } else {
            statusgaransiTextField.text = "Pasif"
        }
    }
    @IBAction func statuspecahswitch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            statuspecahTextField.text = "Aktif"
        } else {
            statuspecahTextField.text = "Pasif"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.beratbarangTextField.text = "1"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func savebutton(_ sender: UIButton){
        // VALIDATION
        if self.deskripsiTextView.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Deskripsi Barang Harus Diisi!")
            return
        }
        if self.beratbarangTextField.text == ""  {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Berat Barang Harus Diisi!")
            return
        }
        if self.statuspecahTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Status pecah Harus Diisi")
            return
        }
        if self.statusgaransiTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Status Garansi Harus Diisi")
            return
        }
        let param: [String: String] = [
            "Deskripsi": self.deskripsiTextView.text!,
            "BeratBarang": self.beratbarangTextField.text!,
            "StatusPecah": self.statuspecahTextField.text!,
            "StatusGaransi": self.statusgaransiTextField.text!
        ]
        if DBWrapper.sharedInstance.doInsertItem(itemData: param) == true {
            Utilities.sharedInstance.showAlert(obj: self, title: "SUCCESS", message: "Sukses Input Barang")
            self.navigationController?.popViewController(animated: true)
        } else {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Maaf, Ada Kesalahan Input")
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
