//
//  employeeViewController.swift
//  MiniProject
//
//  Created by MacMini-03 on 4/4/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

protocol selectemployeedelegate {
    func selectemployeewilldismiss(param: [String:String])
}

class employeeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet var tableView: UITableView!
    
    var kurir = employeeViewController.self
    var employee = [[String:String]]()
    var selectedemployee : [String : String]?
    var delegate: selectemployeedelegate?
    
    var showButtons: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setUpButtons()
    }
    
    func setUpButtons() {
        if self.showButtons == true {
            self.hiddeneditemployee.isHidden = true
            self.hiddendeleteemployee.isHidden = true
            self.hiddenadd.isHidden = false
            self.hiddendone.isEnabled = false
        } else {
            self.hiddeneditemployee.isHidden = true
            self.hiddendeleteemployee.isHidden = true
            self.hiddenadd.isHidden = true
            self.hiddendone.isEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let data = DBWrapper.sharedInstance.fetchEmployee() {
            self.employee = data
            self.tableView.reloadData()
        }
        
    }
    
    @IBAction func filterButton(_ sender: UIBarButtonItem) {
        
        let actionSheet = UIAlertController(title: "Pilter By", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        // create edit action
        let kurirAction = UIAlertAction(title: "Kurir", style: UIAlertActionStyle.default) {
            (action) in
            // TODO: Go to editemployeeViewController
            if let data = DBWrapper.sharedInstance.fetchEmployeeFilterKurir() {
                self.employee = data
                self.tableView.reloadData()
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            (action) in
            actionSheet.dismiss(animated: true, completion: nil)
        }
        
        actionSheet.addAction(kurirAction)
        actionSheet.addAction(cancelAction)
        
        // show action sheet
        self.present(actionSheet, animated: true, completion: nil)
        
        // deselect row
        
    }
    
    @IBOutlet var hiddenadd: UIButton!
    @IBAction func addemployee(_ sender: Any){
        self.performSegue(withIdentifier: "tambahemployeesegue", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var hiddendone: UIBarButtonItem!
    @IBAction func doneee(_ sender: UIBarButtonItem) {
        if self.delegate != nil && self.selectedemployee != nil {
            self.delegate?.selectemployeewilldismiss(param: self.selectedemployee!)
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
        return self.employee.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier:"cell")
        let data = self.employee[indexPath.row]
        cell.textLabel?.text = data["NamaEmployee"]
        
        if self.selectedemployee != nil && data["NamaEmployee"] == self.selectedemployee!["NamaEmployee"] {
            cell.accessoryType = .checkmark
            self.hiddendone.isEnabled = true
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editemployeesegue" {
            let obj = segue.destination as! editemployeeViewController
            obj.selectedemployee = self.selectedemployee
        }
    }
    
    @IBOutlet var hiddeneditemployee: UIButton!
    @IBAction func editemployee(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "editemployeesegue", sender: self)
    }
    
    @IBOutlet var hiddendeleteemployee: UIButton!
    @IBAction func deleteemployee(_ sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: "Are you sure to delete", message: self.selectedemployee?["title"], preferredStyle: UIAlertControllerStyle.alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
            (action) in
            actionSheet.dismiss(animated: true, completion: nil)
            
            let param: [String: String] = [
                "idEmployee": (self.selectedemployee?["idEmployee"])!
            ]
            if DBWrapper.sharedInstance.doDeleteEmployee(dataEmployee: param) == true {
                // Succes update movie
                let alert = UIAlertController(title: "SUCCESS", message: "Employee Deleted!", preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (action) in
                    // dismiss alert
                    alert.dismiss(animated: true, completion: nil)
                    
                    //reload controller
                    if let data = DBWrapper.sharedInstance.fetchEmployee() {
                        self.employee = data
                        self.tableView.reloadData()
                        self.hiddendone.isEnabled = false
                        self.hiddeneditemployee.isHidden = true
                        self.hiddendeleteemployee.isHidden = true
                    }
                    
                })
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                
                
            } else {
                // Failed update movie
                Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Something wrong happened")
            }
            self.selectedemployee = nil
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
        self.selectedemployee = self.employee[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableView.reloadData()
        if self.showButtons == true {
            self.hiddeneditemployee.isHidden = false
            self.hiddendeleteemployee.isHidden = false
            self.hiddenadd.isHidden = false
            self.hiddendone.isEnabled = false
        }
    }
    
}
