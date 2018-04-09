//
//  EditPelangganViewController.swift
//  MiniProj
//
//  Created by Mac Mini-06 on 3/29/18.
//  Copyright © 2018 Mac Mini-06. All rights reserved.
//

import UIKit

class EditPelangganViewController: UIViewController {
    
    @IBOutlet weak var namaTextField: UITextField!
    @IBOutlet weak var alamatTextView: UITextView!
    @IBOutlet weak var teleponTextField: UITextField!
    @IBOutlet weak var kodeposTextField: UITextField!
    
    var selectedCustomer: [String: String]?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.namaTextField.text = self.selectedCustomer?["NamaPelanggan"]
        self.alamatTextView.text = self.selectedCustomer?["AlamatPelanggan"]
        self.teleponTextField.text = self.selectedCustomer?["KontakPelanggan"]
        self.kodeposTextField.text = self.selectedCustomer?["KodePos"]
    }
    
    
    
    
    @IBAction func updateButton(_ sender: UIButton) {
        if self.namaTextField.text == ""{
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Nama pelanggan tidak boleh kosong")
            return
        }
        if self.alamatTextView.text == ""{
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Alamat tidak boleh kosong")
            return
        }
        if self.teleponTextField.text == ""{
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Nomor telepon tidak boleh kosong")
            return
        }
        if self.kodeposTextField.text == ""{
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Kode pos tidak boleh kosong")
            return
        }
        
        let param: [String: String] = [
            "idPelanggan": (self.selectedCustomer?["idPelanggan"])!,
            "NamaPelanggan": self.namaTextField.text!,
            "AlamatPelanggan": self.alamatTextView.text!,
            "KontakPelanggan": self.teleponTextField.text!,
            "KodePos": self.kodeposTextField.text!
        ]
        
        if DBWrapper.sharedInstance.doUpdatePelanggan(dataPelanggan: param) == true {
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
