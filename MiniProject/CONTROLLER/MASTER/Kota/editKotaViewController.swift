//
//  EditkotaViewController.swift
//  MiniProject
//
//  Created by Kahlil Fauzan on 01/04/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

class EditkotaViewController: UIViewController {
    
    @IBOutlet var namakotaTextField: UITextField!
    @IBOutlet var regionkotaTextField: UITextField!
    
    var selectedkota : [String: String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.namakotaTextField.text = self.selectedkota?["NamaKota"]
        self.regionkotaTextField.text = self.selectedkota?["RegionKota"]
    }
    
    @IBAction func updatebutton(_ sender: UIButton){
        if self.namakotaTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Nama Kota Cannot Be Empty!")
            return
        }
        if self.regionkotaTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Region Kota Cannot Be Empty!")
            return
        }
        
        let param: [String: String] = [
            "idKota": (self.selectedkota?["idKota"])!,
            "NamaKota": self.namakotaTextField.text!,
            "RegionKota": self.regionkotaTextField.text!
        ]
        
        if DBWrapper.sharedInstance.doUpdateKota(kotaData: param) == true {
            let alert = UIAlertController(title: "SUCCESS", message: "Kota Updated!", preferredStyle: UIAlertControllerStyle.alert)
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

