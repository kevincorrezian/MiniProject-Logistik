//
//  TambahPelangganViewController.swift
//  MiniProj
//
//  Created by Mac Mini-06 on 3/28/18.
//  Copyright © 2018 Mac Mini-06. All rights reserved.
//

import UIKit

class TambahPelangganViewController: UIViewController {

    @IBOutlet weak var namaTextField: UITextField!
    @IBOutlet weak var alamatTextView: UITextView!
    @IBOutlet weak var teleponTextField: UITextField!
    @IBOutlet weak var kodeposTextField: UITextField!
    @IBAction func simpanButton(_ sender: UIButton) {
        if self.namaTextField.text == ""{
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Nama pelanggan tidak boleh kosong!")
            return
        }
        if self.alamatTextView.text == ""{
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Alamat tidak boleh kosong")
            return
        }
        if self.teleponTextField.text == ""{
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Telepon tidak boleh kosong")
            return
        }
        if self.kodeposTextField.text == ""{
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Kode Pos tidak boleh kosong")
            return
        }
        
        let param: [String: String] = [
            "NamaPelanggan": self.namaTextField.text!,
            "AlamatPelanggan": self.alamatTextView.text!,
            "KontakPelanggan": self.teleponTextField.text!,
            "KodePos": self.kodeposTextField.text!
        ]
        
        if DBWrapper.sharedInstance.doInsertPelanggan(dataPelanggan: param) == true {
            // success insert movie
            Utilities.sharedInstance.showAlert(obj: self, title: "BERHASIL", message: "Berhasil memasukkan data pelanggan")
        } else {
            // failed insert movie
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Maaf, Ada Kesalahan Input Pelanggan")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
