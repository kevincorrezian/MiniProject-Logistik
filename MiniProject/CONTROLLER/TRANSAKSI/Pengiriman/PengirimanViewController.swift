//
//  PengirimanViewController.swift
//  MiniProject
//
//  Created by MacMini-03 on 3/28/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

class PengirimanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pengiriman = [[String: String]]()
    var selectedPengiriman: [String: String]?

    @IBOutlet weak var tableView: UITableView!
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "tambahpengirimansegue", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let data = DBWrapper.sharedInstance.fetchpengiriman(){
            self.pengiriman = data
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let data = DBWrapper.sharedInstance.fetchpengiriman(){
            self.pengiriman = data
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pengiriman.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 305.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pengirimanTableViewCell", for: indexPath) as! pengirimanTableViewCell
        let data = self.pengiriman[indexPath.row]
        cell.nomorPemesananLabel?.text = data["OrderID"]
        cell.tanggalPenerimaanLabel?.text = data["TanggalPengiriman"]
        cell.TanggalPengirimanLabel?.text = data["TanggalPenerimaan"]
        cell.jenisPengirimanLabel?.text = data["JenisPengiriman"]
        cell.namaKurirLabel?.text = data["NamaKurir"]
        cell.namaKantorLabel?.text = data["NamaKantor"]
        cell.statusPengirimanLabel?.text = data["StatusPengiriman"]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedPengiriman = self.pengiriman[indexPath.row]
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
