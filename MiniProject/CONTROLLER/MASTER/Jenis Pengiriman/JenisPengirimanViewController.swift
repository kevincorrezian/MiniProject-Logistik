//
//  JenisPengirimanViewController.swift
//  MiniProj
//
//  Created by Mac Mini-06 on 3/29/18.
//  Copyright © 2018 Mac Mini-06. All rights reserved.
//

import UIKit

protocol selectjenispengirimandelegate {
    func selectjenispengirimanwilldismiss(param: [String:String])
}

class JenisPengirimanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var jenis = [[String: String]]()
    var selectedJenis: [String: String]?
    var delegate: selectjenispengirimandelegate?
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func addJenisPengirimanButton(_ sender: Any) {
        self.performSegue(withIdentifier: "TambahJenisPengirimanSegue", sender: self)
    }
    @IBAction func donee(_ sender: UIBarButtonItem) {
        if self.delegate != nil && self.selectedJenis != nil {
            self.delegate?.selectjenispengirimanwilldismiss(param: self.selectedJenis!)
        }
        self.navigationController?.popViewController(animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditJenisPengirimanSegue" {
            let obj = segue.destination as! EditJenisPengirimanViewController
            obj.selectedJenis = self.selectedJenis
        }
    }
    @IBOutlet weak var hiddenEditJenisPengiriman: UIButton!
    @IBAction func editJenisPengiriman(_ sender: UIButton) {
        self.performSegue(withIdentifier: "EditJenisPengirimanSegue", sender: self)
    }
    
    @IBOutlet weak var hiddenDeleteJenisPengiriman: UIButton!
    
    @IBAction func deleteJenisPengiriman(_ sender: UIButton) {
        let delete = UIAlertController(title: "Apakah anda yakin ingin menghapus?", message: self.selectedJenis?["NamaJenisPengiriman"], preferredStyle: UIAlertControllerStyle.alert)
        
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {(action) in
            //validasi
            
            
                let param: [String: String] = [
                    "idJenisPengiriman": (self.selectedJenis?["idJenisPengiriman"])!,
                ]
            
            
            if DBWrapper.sharedInstance.doDeleteJenisPengiriman(param: param) == true {
                //Success update movie
                let alert = UIAlertController(title: "SUCCESS", message: "Jenis pengiriman terhapus!", preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: {(action) in
                    alert.dismiss(animated: true, completion: nil)
                    
                })
                alert.addAction(ok)
                
                if let data = DBWrapper.sharedInstance.fetchJenisPengiriman(){
                    self.jenis = data
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let data = DBWrapper.sharedInstance.fetchJenisPengiriman(){
            self.jenis = data
            self.tableView.reloadData()
        }
        
        self.hiddenEditJenisPengiriman.isHidden = true
        self.hiddenDeleteJenisPengiriman.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let data = DBWrapper.sharedInstance.fetchJenisPengiriman(){
            self.jenis = data
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jenis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier:"cell")
        let data = self.jenis[indexPath.row]
        cell.textLabel?.text = data["NamaJenisPengiriman"]
        
        if self.selectedJenis != nil && data["NamaJenisPengiriman"] == self.selectedJenis!["NamaJenisPengiriman"] {
            cell.accessoryType = .checkmark
            
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedJenis = self.jenis[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableView.reloadData()
        self.hiddenDeleteJenisPengiriman.isHidden = false
        self.hiddenEditJenisPengiriman.isHidden = false
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

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let jenispengiriman = self.jenis[indexPath.row]
//        self.selectedJenis = jenispengiriman
//
//        let actionSheet = UIAlertController(title: "Actions", message: (self.selectedJenis?["nama"]), preferredStyle: UIAlertControllerStyle.actionSheet)
//        let editAction = UIAlertAction(title: "Edit", style: UIAlertActionStyle.default) { (action) in
//            self.performSegue(withIdentifier: "EditJenisPengirimanSegue", sender: self)
//        }
//        let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.default) { (action) in
//            actionSheet.dismiss(animated: true, completion: nil)
//
//            let delete = UIAlertController(title: "Apakah anda yakin ingin menghapus?", message: self.selectedJenis?["nama"], preferredStyle: UIAlertControllerStyle.alert)
//
//            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {(action) in
//                //validasi
//
//                let param: [String: String] = [
//                    "idJenisPengiriman": (self.selectedJenis?["idJenisPengiriman"])!,
//                    ]
//
//                if DBWrapper.sharedInstance.doDeleteJenisPengiriman(param: param) == true {
//                    //Success update movie
//                    let alert = UIAlertController(title: "SUCCESS", message: "Jenis pengiriman terhapus!", preferredStyle: UIAlertControllerStyle.alert)
//                    let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: {(action) in
//                        alert.dismiss(animated: true, completion: nil)
//
//                    })
//                    alert.addAction(ok)
//
//                    if let data = DBWrapper.sharedInstance.fetchJenisPengiriman(){
//                        self.jenis = data
//                        self.tableView.reloadData()
//                    }
//
//                } else {
//                    // fail
//                    Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Terjadi masalah!")
//                }
//            }
//            let cancel = UIAlertAction(title: "Cancel", style: .cancel) {(action) in
//
//            }
//            delete.addAction(ok)
//            delete.addAction(cancel)
//            self.present(delete, animated: true, completion: nil)
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) { (action) in actionSheet.dismiss(animated: true, completion: nil)
//
//        }
//
//        //add action sheet
//        actionSheet.addAction(editAction)
//        actionSheet.addAction(deleteAction)
//        actionSheet.addAction(cancelAction)
//
//        // show action sheet
//        self.present(actionSheet, animated: true, completion: nil)
//
//        //deselect row
//        tableView.deselectRow(at: indexPath, animated: true)
//    }




