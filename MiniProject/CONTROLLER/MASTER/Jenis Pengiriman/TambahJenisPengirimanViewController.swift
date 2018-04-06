//
//  TambahJenisPengirimanViewController.swift
//  MiniProj
//
//  Created by Mac Mini-06 on 3/29/18.
//  Copyright © 2018 Mac Mini-06. All rights reserved.
//

import UIKit

class TambahJenisPengirimanViewController: UIViewController {

    @IBOutlet var editNamaJenisPengirimanTextField: UITextField!
    @IBOutlet var editDeskripsiJenisPengirimanTextView: UITextView!
    @IBOutlet var tarifJenisPengirimanTextField: UITextField!
    
    @IBAction func tambahJenisPengirimanButton(_ sender: Any) {
        if self.editNamaJenisPengirimanTextField.text == ""{
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Nama jenis pengiriman tidak boleh kosong!")
            return
        }
        if self.editDeskripsiJenisPengirimanTextView.text == ""{
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Deskripsi jenis pengiriman tidak boleh kosong")
            return
        }
        if self.tarifJenisPengirimanTextField.text == ""{
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Deskripsi jenis pengiriman tidak boleh kosong")
            return
        }
        
        let param: [String: String] = [
            "NamaJenisPengiriman": self.editNamaJenisPengirimanTextField.text!,
            "DeskripsiJenisPengiriman": self.editDeskripsiJenisPengirimanTextView.text!,
            "TarifJenisPengiriman": self.tarifJenisPengirimanTextField.text!
        ]
        
        if DBWrapper.sharedInstance.doInsertJenisPengiriman(param: param) == true {
            // success insert movie
            Utilities.sharedInstance.showAlert(obj: self, title: "BERHASIL", message: "Berhasil menambah jenis pengiriman")
        } else {
            // failed insert movie
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Gagal menambah jenis pengiriman")
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
