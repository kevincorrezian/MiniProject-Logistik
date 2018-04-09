//
//  TambahKantorViewController.swift
//  MiniProject
//
//  Created by MacMini-03 on 3/29/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

class tambahkotaViewController: UIViewController {
    
    @IBOutlet var namakotaTextField: UITextField!
    @IBOutlet var regionkotaTextField: UITextField!
    
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
        if self.namakotaTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "nama Kota Cannot Be Empty!")
            return
        }
        if self.regionkotaTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "region Kota Cannot Be Empty!")
            return
        }
        let param: [String: String] = [
            "NamaKota": self.namakotaTextField.text!,
            "RegionKota": self.regionkotaTextField.text!,
        ]
        if DBWrapper.sharedInstance.doInsertKota(kotaData: param) == true {
            Utilities.sharedInstance.showAlert(obj: self, title: "SUCCESS", message: "Success inserting Kota")
            self.navigationController?.popViewController(animated: true)
        } else {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Failed to insert Kota")
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

