//
//  kotaViewController.swift
//  MiniProject
//
//  Created by MacMini-04 on 4/2/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

protocol selectkotadelegate {
    func selectkotawilldismiss(param: [String:String] , flag: Int)
}

class kotaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var kota = [[String:String]]()
    var selectedkota : [String : String]?
    var delegate: selectkotadelegate?
    var flag = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hiddeneditkota.isHidden = true
        self.hiddendeletekota.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let data = DBWrapper.sharedInstance.fetchkota() {
            self.kota = data
            self.tableView.reloadData()
        }
        
    }
    
    @IBAction func addkota(_ sender: Any){
        self.performSegue(withIdentifier: "tambahkotasegue", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        if self.delegate != nil && self.selectedkota != nil {
            self.delegate?.selectkotawilldismiss(param: self.selectedkota!, flag: self.flag)
        }
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.kota.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier:"cell")
        let data = self.kota[indexPath.row]
        cell.textLabel?.text = data["NamaKota"]
        
        if self.selectedkota != nil && data["NamaKota"] == self.selectedkota!["NamaKota"] {
            cell.accessoryType = .checkmark
            
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editkotasegue" {
            let obj = segue.destination as! EditkotaViewController
            obj.selectedkota = self.selectedkota
        }
    }
    
    @IBOutlet var hiddeneditkota: UIButton!
    @IBAction func editkota(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "editkotasegue", sender: self)
    }
    
    @IBOutlet var hiddendeletekota: UIButton!
    @IBAction func deletekota(_ sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: "Are you sure to delete", message: self.selectedkota?["title"], preferredStyle: UIAlertControllerStyle.alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
            (action) in
            actionSheet.dismiss(animated: true, completion: nil)
            
            let param: [String: String] = [
                "idKota": (self.selectedkota?["idKota"])!
            ]
            if DBWrapper.sharedInstance.dodeletekota(kotaData: param) == true {
                // Succes update movie
                let alert = UIAlertController(title: "SUCCESS", message: "Kota Deleted!", preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (action) in
                    
                    // dismiss alert
                    alert.dismiss(animated: true, completion: nil)
                    
                    //reload controller
                    if let data = DBWrapper.sharedInstance.fetchkota() {
                        self.kota = data
                        self.tableView.reloadData()
                    }
                    
                })
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                
                
            } else {
                // Failed update movie
                Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Something wrong happened")
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            (action) in
            actionSheet.dismiss(animated: true, completion: nil)
        }
        actionSheet.addAction(yesAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedkota = self.kota[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableView.reloadData()
        self.hiddeneditkota.isHidden = false
        self.hiddendeletekota.isHidden = false
    }

}
