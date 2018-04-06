//
//  PembayaranViewController.swift
//  MiniProject
//
//  Created by MacMini-03 on 3/28/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

class PembayaranViewController: UIViewController, UITextFieldDelegate, selectitemdelegate, selectjenispengirimandelegate, selectorderdelegate {
    
    @IBOutlet var idorderTextField: UITextField!
    @IBOutlet var namapelangganTextField: UITextField!
    @IBOutlet var deskripsibarangTextField: UITextField!
    
    
    @IBOutlet var beratbarangTextField: UITextField!
    @IBOutlet var statusgaransiTextField: UITextField!
    @IBOutlet var statuspecahbelahTextField: UITextField!
    @IBOutlet var jenispengirimanTextField: UITextField!
    @IBOutlet var tarifjenispengirimanTextField: UITextField!
    
    @IBOutlet var totalpembayaranTextField: UITextField!
    
    var selecteditem: [String:String]?
    var selectedjenis: [String:String]?
    var selectedorder: [String:String]?
    
    @IBAction func HITUNGPEMBAYARAN(_ sender: UIButton) {
        var tarifgaransi = 0
        var tarifpecah = 0
        if self.statusgaransiTextField.text == "Aktif"{
            tarifgaransi = 20000
        }
        if self.statuspecahbelahTextField.text == "Aktif"{
            tarifpecah = 10000
        }
        var volume =    (Int(self.beratbarangTextField.text!)! *
            Int(tarifjenispengirimanTextField.text!)!) +
            tarifgaransi + tarifpecah
        
        
        
        self.totalpembayaranTextField.text = String(volume)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.idorderTextField.text = self.selectedorder?["idOrder"]
        self.namapelangganTextField.text = self.selectedorder?["NamaPelanggan"]
        self.deskripsibarangTextField.text = self.selecteditem?["Deskripsi"]
        self.beratbarangTextField.text = self.selecteditem?["BeratBarang"]
        self.statusgaransiTextField.text = self.selecteditem?["StatusGaransi"]
        self.statuspecahbelahTextField.text = self.selecteditem?["StatusPecah"]
        self.jenispengirimanTextField.text = self.selecteditem?["jenispengiriman"]
        self.tarifjenispengirimanTextField.text = self.selecteditem?["TarifJenisPengiriman"]
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerpembayaranButtonDidtapped(_ sender: Any){
        if self.idorderTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Nama Pelanggan Tidak Boleh Kosong")
            return
        }
        if self.namapelangganTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Nama Pelanggan Tidak Boleh Kosong")
            return
        }
        if self.deskripsibarangTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Deskripsi Barang Tidak Boleh Kosong")
            return
        }
        if self.beratbarangTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Berat Barang Tidak Boleh Kosong")
            return
        }
        if self.statusgaransiTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Status Garansi Tidak Boleh Kosong")
            return
        }
        if self.statuspecahbelahTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Status Pecah Belah Tidak Boleh Kosong")
            return
        }
        if self.jenispengirimanTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Jenis Pengiriman Tidak Boleh Kosong")
            return
        }
        if self.tarifjenispengirimanTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Jenis Pengiriman Tidak Boleh Kosong")
            return
        }
        let param: [String: String] = [
            "idOrder" : self.idorderTextField.text!,
            "NamaPelanggan" : self.namapelangganTextField.text!,
            "NamaJenisPengiriman" : self.jenispengirimanTextField.text!,
            "Deskripsi" : self.deskripsibarangTextField.text!,
            "BeratBarang" : self.beratbarangTextField.text!,
            "StatusGaransi" : self.statusgaransiTextField.text!,
            "StatusPecah" : self.statuspecahbelahTextField.text!,
            "TarifJenisPengiriman" : self.tarifjenispengirimanTextField.text!,
            "TotalPembayaran" : self.totalpembayaranTextField.text!
        ]
        if DBWrapper.sharedInstance.doInsertPembayaran(pembayaranData: param) == true {
            Utilities.sharedInstance.showAlert(obj: self, title: "SUCCESS", message: "Success inserting pembayaran")
            self.navigationController?.popViewController(animated: true)
        } else {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Failed to insert pembayaran")
        }
        
    
        // Validations
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "itemsegue" {
            let obj = segue.destination as! itemViewController
            obj.delegate = self
        }
        if segue.identifier == "jenispengirimansegue" {
            let obj = segue.destination as! JenisPengirimanViewController
            obj.delegate = self
        }
        if segue.identifier == "ordersegue" {
            let obj = segue.destination as! orderViewController
            obj.delegate = self
        }
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.deskripsibarangTextField {
            self.performSegue(withIdentifier: "itemsegue", sender: self)
        }
        if textField == self.jenispengirimanTextField {
            self.performSegue(withIdentifier: "jenispengirimansegue", sender: self)
        }
        if textField == self.idorderTextField {
            self.performSegue(withIdentifier: "ordersegue", sender: self)
        }
        return false
    }
    
    func selectorderwilldismiss(param: [String:String]) {
        self.idorderTextField.text = param["idOrder"]!
        self.selecteditem = param
        self.namapelangganTextField.text = param["NamaPelanggan"]!
        self.selecteditem = param
    }
    func selectitemwilldismiss(param: [String:String]) {
        self.deskripsibarangTextField.text = param["Deskripsi"]!
        self.selecteditem = param
        self.beratbarangTextField.text = param["BeratBarang"]!
        self.selecteditem = param
        self.statusgaransiTextField.text = param["StatusGaransi"]!
        self.selecteditem = param
        self.statuspecahbelahTextField.text = param["StatusPecah"]!
        self.selecteditem = param
    }
    
    func selectjenispengirimanwilldismiss(param: [String:String]) {
        self.jenispengirimanTextField.text = param["NamaJenisPengiriman"]!
        self.selectedjenis = param
        self.tarifjenispengirimanTextField.text = param["TarifJenisPengiriman"]!
        self.selectedjenis = param
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
