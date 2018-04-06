//
//  itemViewController.swift
//  MiniProject
//
//  Created by Kahlil Fauzan on 31/03/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

protocol selectitemdelegate {
    func selectitemwilldismiss(param: [String:String])
}

class itemViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView : UITableView!
    
    var item = [[String:String]]()
    var selecteditem : [String : String]?
    var delegate: selectitemdelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.hiddenedititem.isHidden = true
        self.hiddendeleteitem.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let data = DBWrapper.sharedInstance.fetchitem() {
            self.item = data
            self.tableView.reloadData()
        }
        
    }
    
    @IBAction func donee(_ sender: UIBarButtonItem) {
        if self.delegate != nil && self.selecteditem != nil {
            self.delegate?.selectitemwilldismiss(param: self.selecteditem!)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func additem(_ sender: Any){
        self.performSegue(withIdentifier: "tambahitemsegue", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier:"cell")
        let data = self.item[indexPath.row]
        cell.textLabel?.text = data["Deskripsi"]
        
        if self.selecteditem != nil && data["Deskripsi"] == self.selecteditem!["Deskripsi"] {
            cell.accessoryType = .checkmark
            
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edititemsegue" {
            let obj = segue.destination as! edititemViewController
            obj.selecteditem = self.selecteditem
        }
    }
    
    @IBOutlet weak var hiddenedititem: UIButton!
    @IBAction func edititem(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "edititemsegue", sender: self)
    }
    
    @IBOutlet weak var hiddendeleteitem: UIButton!
    @IBAction func deleteitem(_ sender: UIBarButtonItem) {
        let param: [String: String] = [
            "idItem": (self.selecteditem?["idItem"])!
        ]
        if DBWrapper.sharedInstance.dodeleteitem(itemData: param) == true {
            // Succes update kantor
            let alert = UIAlertController(title: "SUCCESS", message: "item Deleted!", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (action) in
                
                // dismiss alert
                alert.dismiss(animated: true, completion: nil)
                
                //reload controller
                if let data = DBWrapper.sharedInstance.fetchitem() {
                    self.item = data
                    self.tableView.reloadData()
                }
                
            })
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            self.tableView.reloadData()
            
        } else {
            // Failed update kantor
            Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Something wrong happened")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selecteditem = self.item[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableView.reloadData()
        
        self.hiddenedititem.isHidden = false
        self.hiddendeleteitem.isHidden = false
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
