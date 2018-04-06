//
//  EditJenisPengirimanViewController.swift
//  MiniProj
//
//  Created by Mac Mini-06 on 3/29/18.
//  Copyright © 2018 Mac Mini-06. All rights reserved.
//

import UIKit

class EditJenisPengirimanViewController: UIViewController {

    @IBOutlet var namaJenisPengirimanTextField: UITextField!
    @IBOutlet var deskripsiJenisPengirimanTextView: UITextView!
    @IBOutlet var tarifJenisPengirimanTextField: UITextField!
    
    var selectedJenis: [String: String]?
    
    @IBAction func updateJenisPengirimanButton(_ sender: Any) {
        if self.namaJenisPengirimanTextField.text == ""{
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Nama tidak boleh kosong")
            return
        }
        if self.deskripsiJenisPengirimanTextView.text == ""{
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Deskripsi tidak boleh kosong")
            return
        }
        if self.tarifJenisPengirimanTextField.text == ""{
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Tarif tidak boleh kosong")
            return
        }
        
        let param: [String: String] = [
            "idJenisPengiriman": (self.selectedJenis?["idJenisPengiriman"])!,
            "NamaJenisPengiriman": self.namaJenisPengirimanTextField.text!,
            "DeskripsiJenisPengiriman": self.deskripsiJenisPengirimanTextView.text!,
            "TarifJenisPengiriman": self.tarifJenisPengirimanTextField.text!
        ]
        
        if DBWrapper.sharedInstance.doUpdateJenisPengiriman(param: param) == true {
            //Success update movie
            let alert = UIAlertController(title: "BERHASIL", message: "Pelanggan terupdate!", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: {(action) in
                alert.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            })
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        } else {
            // fail
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Ada sesuatu yang salah!")
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.namaJenisPengirimanTextField.text = self.selectedJenis?["NamaJenisPengiriman"]
        self.deskripsiJenisPengirimanTextView.text = self.selectedJenis?["DeskripsiJenisPengiriman"]
        self.tarifJenisPengirimanTextField.text = self.selectedJenis?["TarifJenisPengiriman"]
        // Do any additional setup after loading the view.
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
