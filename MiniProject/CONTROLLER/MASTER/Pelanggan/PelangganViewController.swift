//
//  PelangganViewController.swift
//  MiniProj
//
//  Created by Mac Mini-06 on 3/28/18.
//  Copyright © 2018 Mac Mini-06. All rights reserved.
//

import UIKit

protocol selectpelanggandelegate {
    func selectpelangganwilldismiss(param: [String:String])
}

class PelangganViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pelanggan = [[String: String]]()
    var selectedCustomer: [String: String]?
    var delegate: selectpelanggandelegate?
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "TambahPelangganSegue", sender: self)
    }
    
    @IBAction func donee(_ sender: UIBarButtonItem) {
        if self.delegate != nil && self.selectedCustomer != nil {
            self.delegate?.selectpelangganwilldismiss(param: self.selectedCustomer!)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = DBWrapper.sharedInstance.fetchPelanggan(){
            self.pelanggan = data
            self.tableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let data = DBWrapper.sharedInstance.fetchPelanggan(){
            self.pelanggan = data
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pelanggan.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PelangganTableViewCell", for: indexPath) as! PelangganTableViewCell
        
        // ambil data person
        
        let customer = self.pelanggan[indexPath.row]
        
        
        cell.namaLabel?.text = customer["NamaPelanggan"]
        cell.alamatLabel?.text = customer["AlamatPelanggan"]
        cell.teleponLabel?.text = customer["KontakPelanggan"]
        cell.kodeposLabel?.text = customer["KodePos"]
        
        return cell
        //cell.statusLabel?.text = "status: " + person["status"]!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let customer = self.pelanggan[indexPath.row]
        self.selectedCustomer = customer
        
        let actionSheet = UIAlertController(title: "Actions", message: (self.selectedCustomer?["nama"]), preferredStyle: UIAlertControllerStyle.actionSheet)
        let editAction = UIAlertAction(title: "Edit", style: UIAlertActionStyle.default) { (action) in
            self.performSegue(withIdentifier: "EditPelangganSegue", sender: self)
        }
        let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.default) { (action) in
            actionSheet.dismiss(animated: true, completion: nil)
            
            let delete = UIAlertController(title: "Apakah anda yakin ingin menghapus?", message: self.selectedCustomer?["nama"], preferredStyle: UIAlertControllerStyle.alert)
            
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {(action) in
                //validasi
                
                let param: [String: String] = [
                    "idPelanggan": (self.selectedCustomer?["idPelanggan"])!,
                    ]
                
                if DBWrapper.sharedInstance.doDeletePelanggan(dataPelanggan: param) == true {
                    //Success update movie
                     let alert = UIAlertController(title: "SUCCESS", message: "Pelanggan terhapus!", preferredStyle: UIAlertControllerStyle.alert)
                    let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: {(action) in
                        alert.dismiss(animated: true, completion: nil)
                        
                    })
                    alert.addAction(ok)
                    
                    if let data = DBWrapper.sharedInstance.fetchPelanggan(){
                        self.pelanggan = data
                        self.tableView.reloadData()
                    }
                    
                } else {
                    // fail
                    Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Terjadi masalah!")
                }
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) {(action) in
                
            }
            delete.addAction(ok)
            delete.addAction(cancel)
            self.present(delete, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) { (action) in actionSheet.dismiss(animated: true, completion: nil)
            
        }
        
        //add action sheet
        actionSheet.addAction(editAction)
        actionSheet.addAction(deleteAction)
        actionSheet.addAction(cancelAction)
        
        // show action sheet
        self.present(actionSheet, animated: true, completion: nil)
        
        //deselect row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "EditPelangganSegue"{
            let obj = segue.destination as! EditPelangganViewController
            obj.selectedCustomer = self.selectedCustomer
        }
    }
    
    
}

