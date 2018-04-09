//
//  StatusPengirimanViewController.swift
//  MiniProject
//
//  Created by Mac Mini-06 on 4/4/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

protocol selectstatusdelegate {
    func selectstatuswilldismiss(param: [String:String])
}

class StatusPengirimanViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var status = [[String: String]]()
    var selectedstatus: [String:String]?
    var delegate: selectstatusdelegate?
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        if self.delegate != nil && self.selectedstatus != nil {
            self.delegate?.selectstatuswilldismiss(param: self.selectedstatus!)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let status1 = [
            "status": "Belum dikirim"
        ]
        let status2 = [
            "status": "Dalam proses kirim"
        ]
        let status3 = [
            "status": "Terkirim"
        ]
        self.status = [status1,status2,status3]
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.status.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier:"cell")
        let data = self.status[indexPath.row]
        cell.textLabel?.text = data["status"]
        
        if self.selectedstatus != nil && data["status"] == self.selectedstatus!["status"] {
            cell.accessoryType = .checkmark
            
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedstatus = self.status[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableView.reloadData()
        
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

