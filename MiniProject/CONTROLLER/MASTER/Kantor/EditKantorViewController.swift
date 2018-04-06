//
//  EditKantorViewController.swift
//  MiniProject
//
//  Created by Kahlil Fauzan on 01/04/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

class EditKantorViewController: UIViewController {

    @IBOutlet var namakantorTextField: UITextField!
    @IBOutlet var levelTextField: UITextField!
    @IBOutlet var alamatkantorTextField: UITextField!
    
    var selectedKantor : [String: String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.namakantorTextField.text = self.selectedKantor?["NamaKantor"]
        self.levelTextField.text = self.selectedKantor?["TingkatanKantor"]
        self.alamatkantorTextField.text = self.selectedKantor?["AlamatKantor"]
    }
    
    @IBAction func updatebutton(_ sender: UIButton){
        if self.namakantorTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Nama Kantor Cannot Be Empty!")
            return
        }
        if self.levelTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Tingkatan Kantor Cannot Be Empty!")
            return
        }
        if self.alamatkantorTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Alamat Kantor Cannot Be Empty!")
            return
        }
        
        let param: [String: String] = [
            "idKantor": (self.selectedKantor?["idKantor"])!,
            "NamaKantor": self.namakantorTextField.text!,
            "TingkatanKantor": self.levelTextField.text!,
            "AlamatKantor": self.alamatkantorTextField.text!
        ]
        
        if DBWrapper.sharedInstance.doUpdatekantor(kantorData: param) == true {
            let alert = UIAlertController(title: "SUCCESS", message: "Kantor Updated!", preferredStyle: UIAlertControllerStyle.alert)
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
