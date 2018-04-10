//
//  OrderViewController.swift
//  MiniProject
//
//  Created by MacMini-03 on 3/28/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

class tambahOrderViewController: UIViewController, UITextFieldDelegate, selectkotadelegate, selectitemdelegate, selectjenispengirimandelegate, selectpelanggandelegate {
    
    
    
    @IBOutlet var tanggalpemesenananTextField: UITextField!
    @IBOutlet var namapelangganTextField: UITextField!
    @IBOutlet var kotapengirimTextField: UITextField!
    @IBOutlet var namapenerimaTextField: UITextField!
    @IBOutlet var kotapenerimaTextField: UITextField!
    @IBOutlet var deskripsibarangTextField: UITextField!
    @IBOutlet var alamatpenerimaTextField: UITextField!
    @IBOutlet var jenispengirimanTextField: UITextField!
    
    var selectedkotapengirim: [String:String]?
    var selectedkotapenerima: [String:String]?
    var selecteditem: [String:String]?
    var selectedjenispengiriman: [String:String]?
    var selectedpelanggan: [String:String]?
    var datePicker: UIDatePicker?
    var dateformatter = DateFormatter()
    var selectedtextfieldflag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dateformatter.dateFormat = "dd-MM-yyyy"
        self.setupdatepicker()
    }
    
    func setupdatepicker() {
        let frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 225
        )
        self.datePicker = UIDatePicker(frame: frame)
        self.datePicker?.datePickerMode = .date
        self.datePicker?.minimumDate = Date()
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let donebutton = UIBarButtonItem(title: "DONE", style: .done, target: self, action: #selector(datePickerdonebuttonpushed))
        toolbar.setItems([donebutton], animated: false)
        
        self.tanggalpemesenananTextField.inputAccessoryView = toolbar
        self.tanggalpemesenananTextField.inputView = self.datePicker
    }
    
    @objc func datePickerdonebuttonpushed() {
        let selecteddate = self.datePicker?.date
        self.tanggalpemesenananTextField.text = self.dateformatter.string(from: selecteddate!)
        self.tanggalpemesenananTextField.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func inputOrderButtonDidtapped(_ sender: Any){
        if self.tanggalpemesenananTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Tanggal Pemesanan Tidak Boleh Kosong")
            self.tanggalpemesenananTextField.layer.borderColor = UIColor.red.cgColor
            
            return
        }
        if self.namapelangganTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Nama Pelanggan Tidak Boleh Kosong")
            self.namapelangganTextField.layer.borderColor = UIColor.red.cgColor
            
            return
        }
        if self.kotapengirimTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Kota Pengirim Tidak Boleh Kosong")
            self.kotapengirimTextField.layer.borderColor = UIColor.red.cgColor
            
            return
        }
        if self.namapenerimaTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Nama Penerima Tidak Boleh Kosong")
            self.namapenerimaTextField.layer.borderColor = UIColor.red.cgColor
            
            return
        }
        if self.kotapenerimaTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Kota Penerima Tidak Boleh Kosong")
            self.kotapenerimaTextField.layer.borderColor = UIColor.red.cgColor
            
            return
        }
        if self.deskripsibarangTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Deskripsi Barang Tidak Boleh Kosong")
            self.deskripsibarangTextField.layer.borderColor = UIColor.red.cgColor
            return
        }
        if self.alamatpenerimaTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Alamat Penerima Tidak Boleh Kosong")
            self.alamatpenerimaTextField.layer.borderColor = UIColor.red.cgColor
            return
        }
        if self.jenispengirimanTextField.text == "" {
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Jenis Pengiriman Tidak Boleh Kosong")
            self.jenispengirimanTextField.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        let param: [String: String] = [
            "TanggalPemesanan" : self.tanggalpemesenananTextField.text!,
            "NamaPelanggan" : self.namapelangganTextField.text!,
            "KotaPengirim" : self.kotapengirimTextField.text!,
            "NamaPenerima" : self.namapenerimaTextField.text!,
            "KotaPenerima" : self.kotapenerimaTextField.text!,
            "DeskripsiBarang" : self.deskripsibarangTextField.text!,
            "AlamatPenerima" : self.alamatpenerimaTextField.text!,
            "JenisPengiriman" : self.jenispengirimanTextField.text!
        ]
        if DBWrapper.sharedInstance.doInsertOrder(orderData: param) == true {
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
        if segue.identifier == "kotasegue" {
            let obj = segue.destination as! kotaViewController
            obj.delegate = self
            obj.flag = self.selectedtextfieldflag
            obj.showButtons = false
        }
        if segue.identifier == "itemsegue" {
            let obj = segue.destination as! itemViewController
            obj.delegate = self
            obj.showButtons = false
        }
        if segue.identifier == "jenispengirimansegue" {
            let obj = segue.destination as! JenisPengirimanViewController
            obj.delegate = self
            obj.showButtons = false
        }
        if segue.identifier == "pelanggansegue" {
            let obj = segue.destination as! PelangganViewController
            obj.delegate = self
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.kotapengirimTextField {
            self.selectedtextfieldflag = 0
            self.performSegue(withIdentifier: "kotasegue", sender: self)
            return false
        } else if textField == self.kotapenerimaTextField {
            self.selectedtextfieldflag = 1
            self.performSegue(withIdentifier: "kotasegue", sender: self)
            return false
        } else if textField == self.deskripsibarangTextField {
            self.performSegue(withIdentifier: "itemsegue", sender: self)
            return false
        } else if textField == self.jenispengirimanTextField {
            self.performSegue(withIdentifier: "jenispengirimansegue", sender: self)
            return false
        } else if textField == self.namapelangganTextField {
            self.performSegue(withIdentifier: "pelanggansegue", sender: self)
            return false
        }
        return true
    }
    
    func selectkotawilldismiss(param: [String : String] , flag: Int) {
        if flag == 0 {
            self.kotapengirimTextField.text = param["NamaKota"]!
                self.selectedkotapengirim = param
            
        } else {
                self.kotapenerimaTextField.text = param["NamaKota"]!
                self.selectedkotapenerima = param
        }
    }
    
    func selectjenispengirimanwilldismiss(param: [String : String]) {
       
        self.jenispengirimanTextField.text = param["NamaJenisPengiriman"]!
        self.selectedjenispengiriman = param
    }
    
    func selectitemwilldismiss(param: [String : String]) {
        self.deskripsibarangTextField.text = param["Deskripsi"]!
        self.selecteditem = param
    }
    
    func selectpelangganwilldismiss(param: [String:String]) {
        self.namapelangganTextField.text = param["NamaPelanggan"]!
        self.selectedpelanggan = param
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
