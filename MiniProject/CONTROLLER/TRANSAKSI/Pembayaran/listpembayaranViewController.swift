//
//  listpembayaranViewController.swift
//  MiniProject
//
//  Created by MacMini-03 on 4/6/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

class listpembayaranViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var pembayaran = [[String: String]]()
    var selectedpembayaran: [String: String]?
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "pembayaransegue", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let data = DBWrapper.sharedInstance.fetchpembayaran(){
            self.pembayaran = data
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pembayaran.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pembayaranTableViewCell", for: indexPath) as! pembayaranTableViewCell
        let data = self.pembayaran[indexPath.row]
        cell.idorderLabel?.text = data["idOrder"]
        cell.namapengirimLabel?.text = data["NamaPelanggan"]
        cell.jenispengirimanLabel?.text = data["NamaJenisPengiriman"]
        cell.deskripsibarangLabel?.text = data["Deskripsi"]
        cell.totalpembayaranLabel?.text = data["TotalPembayaran"]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedpembayaran = self.pembayaran[indexPath.row]
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
