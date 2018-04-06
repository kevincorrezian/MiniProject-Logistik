//
//  EditItemViewController.swift
//  MiniProject
//
//  Created by Kahlil Fauzan on 01/04/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

class edititemViewController: UIViewController {
    
    @IBOutlet var deskripsiTextField: UITextField!
    @IBOutlet var beratbarangTextField: UITextField!
    @IBOutlet var statuspecahTextField: UITextField!
    @IBOutlet var statusgaransiTextField: UITextField!
    
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
    
    var selecteditem : [String: String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.deskripsiTextField.text = self.selecteditem?["Deskripsi"]
        self.beratbarangTextField.text = self.selecteditem?["BeratBarang"]
    }
    
    @IBAction func editbutton(_ sender: UIButton){
        if self.deskripsiTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Deskripsi Barang Cannot Be Empty!")
            return
        }
        if self.beratbarangTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Berat Barang Cannot Be Empty!")
            return
        }
        if self.statuspecahTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Status Pecah Cannot Be Empty!")
            return
        }
        if self.statusgaransiTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Status Garansi Cannot Be Empty!")
            return
        }
        
        let param: [String: String] = [
            "idItem": (self.selecteditem?["idItem"])!,
            "Deskripsi": self.deskripsiTextField.text!,
            "BeratBarang": self.beratbarangTextField.text!,
            "StatusPecah": self.statuspecahTextField.text!,
            "StatusGaransi": self.statusgaransiTextField.text!
        ]
        
        if DBWrapper.sharedInstance.doUpdateItem(itemData: param) == true {
            let alert = UIAlertController(title: "SUCCESS", message: "Item Updated!", preferredStyle: UIAlertControllerStyle.alert)
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

