//
//  KantorViewController.swift
//  MiniProject
//
//  Created by MacMini-03 on 3/29/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

protocol selectkantordelegate {
    func selectkantorwilldismiss(param: [String:String])
}

class KantorViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var kantor = [[String:String]]()
    var selectedkantor : [String : String]?
    var delegate: selectkantordelegate?
    
     var showButtons: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.setUpButtons()
        // Do any additional setup after loading the view.
    }
    
    func setUpButtons() {
        if self.showButtons == true {
            self.hiddeneditkantor.isHidden = true
            self.hiddendeletekantor.isHidden = true
            self.hiddenaddkantor.isHidden = false
            self.hiddendone.isEnabled = false
        } else {
            self.hiddeneditkantor.isHidden = true
            self.hiddendeletekantor.isHidden = true
            self.hiddenaddkantor.isHidden = true
            self.hiddendone.isEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let data = DBWrapper.sharedInstance.fetchkantor() {
            self.kantor = data
            self.tableView.reloadData()
        }
        
    }
    @IBOutlet weak var hiddenaddkantor: UIButton!
    @IBAction func addkantor(_ sender: Any){
        self.performSegue(withIdentifier: "tambahkantorsegue", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var hiddendone: UIBarButtonItem!
    @IBAction func donee(_ sender: UIBarButtonItem) {
        if self.delegate != nil && self.selectedkantor != nil {
            self.delegate?.selectkantorwilldismiss(param: self.selectedkantor!)
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
        return self.kantor.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier:"cell")
        let data = self.kantor[indexPath.row]
        cell.textLabel?.text = data["NamaKantor"]
        
        if self.selectedkantor != nil && data["NamaKantor"] == self.selectedkantor!["NamaKantor"] {
            cell.accessoryType = .checkmark
            self.hiddendone.isEnabled = true
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editkantorsegue" {
            let obj = segue.destination as! EditKantorViewController
            obj.selectedKantor = self.selectedkantor
        }
    }
    
    @IBOutlet weak var hiddeneditkantor: UIButton!
    @IBAction func editkantor(_ sender: UIBarButtonItem) {
            self.performSegue(withIdentifier: "editkantorsegue", sender: self)
    }
    
    @IBOutlet weak var hiddendeletekantor: UIButton!
    @IBAction func deletekantor(_ sender: UIBarButtonItem) {
        let param: [String: String] = [
            "idKantor": (self.selectedkantor?["idKantor"])!
        ]
            if DBWrapper.sharedInstance.dodeletekantor(kantorData: param) == true {
                // Succes update kantor
                let alert = UIAlertController(title: "SUCCESS", message: "kantor Deleted!", preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (action) in
                    
                    // dismiss alert
                    alert.dismiss(animated: true, completion: nil)
                    
                    //reload controller
                    if let data = DBWrapper.sharedInstance .fetchkantor() {
                        self.kantor = data
                        self.tableView.reloadData()
                        self.hiddendone.isEnabled = false
                    }
                    
                })
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                
                
            } else {
                // Failed update kantor
                Utilities.sharedInstance.showAlert(obj: self, title: "ERROR", message: "Something wrong happened")
            }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedkantor = self.kantor[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableView.reloadData()
        
        if self.showButtons == true {
            self.hiddeneditkantor.isHidden = false
            self.hiddendeletekantor.isHidden = false
            self.hiddenaddkantor.isHidden = false
            self.hiddendone.isEnabled = false
        }
    }
    
}

