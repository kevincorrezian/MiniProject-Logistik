//
//  TambahPengirimanViewController.swift
//  MiniProject
//
//  Created by Mac Mini-06 on 4/4/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

class TambahPengirimanViewController: UIViewController, UITextFieldDelegate, selectkantordelegate, selectstatusdelegate, selectorderdelegate, selectemployeedelegate, selectjenispengirimandelegate{
    
    @IBOutlet var nomorPemesananTextField: UITextField!
    @IBOutlet var tanggalPenerimaanTextField: UITextField!
    @IBOutlet var TanggalPengirimanTextField: UITextField!
    @IBOutlet var jenisPengirimanTextField: UITextField!
    @IBOutlet var namaKurirTextField: UITextField!
    @IBOutlet var namaKantorTextField: UITextField!
    @IBOutlet var statusPengirimanTextField: UITextField!
    
    
    var selectedkantor: [String: String]?
    var selectedstatus: [String: String]?
    var selectedorder: [String: String]?
    var selectedemployee: [String: String]?
    var selecteddate: [String: String]?
    var selectedjenispengiriman: [String: String]?
    
    var dateFormatter = DateFormatter()
    var datePicker: UIDatePicker?
    var datePicker2: UIDatePicker?
    
    @IBAction func addButton(_ sender: Any) {
        
        if self.nomorPemesananTextField.text == ""{
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Nomor pemesanan tidak boleh kosong!")
            return
        }
        if self.tanggalPenerimaanTextField.text == ""{
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Tanggal penerimaan tidak boleh kosong")
            return
        }
        if self.TanggalPengirimanTextField.text == ""{
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Tanggal pengiriman tidak boleh kosong")
            return
        }
        if self.jenisPengirimanTextField.text == ""{
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Jenis pengiriman tidak boleh kosong")
            return
        }
        if self.namaKurirTextField.text == ""{
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Nama kurir tidak boleh kosong")
            return
        }
        if self.namaKantorTextField.text == ""{
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Nama kantor tidak boleh kosong")
            return
        }
        if self.statusPengirimanTextField.text == ""{
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Status pengiriman tidak boleh kosong")
            return
        }
        
        let param: [String: String] = [
            "NomorPemesanan": self.nomorPemesananTextField.text!,
            "TanggalPengiriman": self.tanggalPenerimaanTextField.text!,
            "TanggalPenerimaan": self.TanggalPengirimanTextField.text!,
            "JenisPengiriman": self.jenisPengirimanTextField.text!,
            "NamaKurir": self.namaKurirTextField.text!,
            "NamaKantor": self.namaKantorTextField.text!,
            "StatusPengiriman": self.statusPengirimanTextField.text!
        ]
        
        if DBWrapper.sharedInstance.doInsertPengiriman(PengirimanData: param) == true {
            // success insert movie
            Utilities.sharedInstance.showAlert(obj: self, title: "BERHASIL", message: "Berhasil memasukkan data pengiriman")
        } else {
            // failed insert movie
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Gagal memasukkan data pengiriman")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.dateFormatter.dateFormat = "yyyy-MM-dd"
        
        setUpDatePicker()
        setUpDatePicker2()
    }
    
    func setUpDatePicker(){
        let frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200)
        self.datePicker = UIDatePicker(frame: frame)
        self.datePicker?.datePickerMode = .date
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "done", style: .done, target: self, action: #selector(datePickerDoneButton))
        toolbar.setItems([doneButton], animated: false)
        
        self.tanggalPenerimaanTextField.inputAccessoryView = toolbar
        self.tanggalPenerimaanTextField.inputView = self.datePicker
    }
    
    func setUpDatePicker2(){
        let frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200)
        self.datePicker2 = UIDatePicker(frame: frame)
        self.datePicker2?.datePickerMode = .date
        
        let toolbar2 = UIToolbar()
        toolbar2.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "done", style: .done, target: self, action: #selector(datePickerDoneButton2))
        toolbar2.setItems([doneButton], animated: false)
        
        self.TanggalPengirimanTextField.inputAccessoryView = toolbar2
        self.TanggalPengirimanTextField.inputView = self.datePicker2
    }
    
    @objc func datePickerDoneButton() {
        let selectedDate = self.datePicker?.date
        self.tanggalPenerimaanTextField.text = self.dateFormatter.string(from: selectedDate!)
        self.tanggalPenerimaanTextField.resignFirstResponder()
    }
    
    @objc func datePickerDoneButton2() {
        let selectedDate = self.datePicker2?.date
        self.TanggalPengirimanTextField.text = self.dateFormatter.string(from: selectedDate!)
        self.TanggalPengirimanTextField.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "pengirimankantorsegue" {
            let obj = segue.destination as! KantorViewController
            obj.delegate = self
            obj.showButtons = false
        }
        if segue.identifier == "statuspengirimansegue" {
            let obj = segue.destination as! StatusPengirimanViewController
            obj.delegate = self
        }
        if segue.identifier == "selectordersegue" {
            let obj = segue.destination as! orderViewController
            obj.delegate = self
        }
        if segue.identifier == "pengirimanemployeesegue" {
            let obj = segue.destination as! employeeViewController
            obj.delegate = self
            obj.showButtons = false
        }
        if segue.identifier == "jenispengirimansegue" {
            let obj = segue.destination as! JenisPengirimanViewController
            obj.delegate = self
            obj.showButtons = false
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.namaKantorTextField {
            self.performSegue(withIdentifier: "pengirimankantorsegue", sender: self)
        }
        if textField == self.statusPengirimanTextField {
            self.performSegue(withIdentifier: "statuspengirimansegue", sender: self)
        }
        if textField == self.nomorPemesananTextField {
            self.performSegue(withIdentifier: "selectordersegue", sender: self)
        }
        if textField == self.namaKurirTextField {
            self.performSegue(withIdentifier: "pengirimanemployeesegue", sender: self)
        }
        if textField == self.jenisPengirimanTextField {
            self.performSegue(withIdentifier: "jenispengirimansegue", sender: self)
        }
        return false
    }
    
    func selectkantorwilldismiss(param: [String : String]) {
        self.namaKantorTextField.text = param["NamaKantor"]!
        self.selectedkantor = param
    }
    
    func selectstatuswilldismiss(param: [String : String]) {
        self.statusPengirimanTextField.text = param["status"]!
        self.selectedstatus = param
    }
    
    func selectorderwilldismiss(param: [String : String]) {
        self.nomorPemesananTextField.text = param["idOrder"]!
        self.jenisPengirimanTextField.text = param["JenisPengiriman"]!
        
        self.selectedorder = param
        
    }
    
    func selectemployeewilldismiss(param: [String:String]) {
        self.namaKurirTextField.text = param["NamaEmployee"]!
        self.selectedemployee = param
    }
    
    func selectjenispengirimanwilldismiss(param: [String : String]) {
        self.jenisPengirimanTextField.text = param["NamaJenisPengiriman"]!
        self.selectedjenispengiriman = param
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


