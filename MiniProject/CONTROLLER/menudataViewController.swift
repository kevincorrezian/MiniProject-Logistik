//
//  menudataViewController.swift
//  MiniProject
//
//  Created by MacMini-03 on 4/3/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

class menudataViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dataorder(_ sender: UIButton){
        self.performSegue(withIdentifier: "dataordersegue", sender: self)
    }
    @IBAction func datapengiriman(_ sender: UIButton){
        self.performSegue(withIdentifier: "datapengirimansegue", sender: self)
    }
    @IBAction func datapembayaran(_ sender: UIButton){
        self.performSegue(withIdentifier: "datapembayaransegue", sender: self)
    }
    @IBAction func datapelangganButton(_ sender: UIButton){
        self.performSegue(withIdentifier: "datapelanggansegue", sender: self)
    }
    @IBAction func databarang(_ sender: UIButton){
        self.performSegue(withIdentifier: "databarangsegue", sender: self)
    }
    @IBAction func datakantor(_ sender: UIButton){
        self.performSegue(withIdentifier: "datakantorsegue", sender: self)
    }
    @IBAction func datajenispengiriman(_ sender: UIButton){
        self.performSegue(withIdentifier: "datajenispengirimansegue", sender: self)
    }
    @IBAction func datakota(_ sender: UIButton){
        self.performSegue(withIdentifier: "datakotasegue", sender: self)
    }
    @IBAction func dataemployeebuton(_ sender: UIButton){
        self.performSegue(withIdentifier: "dataemployeesegue", sender: self)
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
