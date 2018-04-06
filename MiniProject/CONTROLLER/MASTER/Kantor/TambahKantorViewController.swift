//
//  TambahKantorViewController.swift
//  MiniProject
//
//  Created by MacMini-03 on 3/29/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

class TambahKantorViewController: UIViewController {

    @IBOutlet var namakantorTextField: UITextField!
    @IBOutlet var TingkatanKantorTextField: UITextField!
    @IBOutlet var alamatkantorTextField: UITextField!
    
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
        if self.namakantorTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "nama kantor Cannot Be Empty!")
            return
        }
        if self.TingkatanKantorTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "nama kantor Cannot Be Empty!")
            return
        }
        if self.alamatkantorTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "nama kantor Cannot Be Empty!")
            return
        }
        let param: [String: String] = [
            "NamaKantor": self.namakantorTextField.text!,
            "TingkatanKantor": self.TingkatanKantorTextField.text!,
            "AlamatKantor": self.alamatkantorTextField.text!
        ]
        if DBWrapper.sharedInstance.doInsertkantor(kantorData: param) == true {
            Utilities.sharedInstance.showAlert(obj: self, title: "SUCCESS", message: "Success inserting kantor")
            self.navigationController?.popViewController(animated: true)
        } else {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Failed to insert kantor")
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
