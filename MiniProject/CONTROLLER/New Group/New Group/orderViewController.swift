//
//  orderViewController.swift
//  MiniProject
//
//  Created by MacMini-04 on 4/5/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

protocol selectorderdelegate {
    func selectorderwilldismiss(param: [String:String])
}

class orderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var order = [[String:String]]()
    var selectedorder : [String : String]?
    var delegate: selectorderdelegate?
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "tambahordersegue", sender: self)
    }
    
    @IBAction func doneeorder(_ sender: UIBarButtonItem) {
        if self.delegate != nil && self.selectedorder != nil {
            self.delegate?.selectorderwilldismiss(param: self.selectedorder!)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let data = DBWrapper.sharedInstance.fetchOrder(){
            self.order = data
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.order.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ordertableviewcell", for: indexPath) as! ordercustomTableViewCell
        let data = self.order[indexPath.row]
        cell.tanggalpemesenananLabel?.text = data["TanggalPemesanan"]
        cell.namapelangganLabel?.text = data["NamaPelanggan"]
        cell.kotapengirimLabel?.text = data["KotaPengirim"]
        cell.namapenerimaLabel?.text = data["NamaPenerima"]
        cell.kotapenerimaLabel?.text = data["KotaPenerima"]
        cell.deskripsibarangLabel?.text = data["DeskripsiBarang"]
        cell.alamatpenerimaLabel?.text = data["AlamatPenerima"]
        cell.jenispengirimanLabel?.text = data["JenisPengiriman"]
        
        if self.selectedorder != nil && data["TanggalPemesanan"] == self.selectedorder!["TanggalPemesanan"] {
            cell.accessoryType = .checkmark
            
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedorder = self.order[indexPath.row]
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
