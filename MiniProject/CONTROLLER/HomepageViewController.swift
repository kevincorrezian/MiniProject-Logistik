//
//  HomepageViewController.swift
//  MiniProject
//
//  Created by MacMini-03 on 3/28/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

class HomepageViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tmp = UIBarButtonItem()
        self.navigationItem.leftBarButtonItem = tmp
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pelangganimg(_ sender: Any){
        self.performSegue(withIdentifier: "datasegue", sender: self)
    }
 @IBAction func pelangganButton(_ sender: UIButton){
    self.performSegue(withIdentifier: "datasegue", sender: self)
    }
    @IBAction func orderimg(_ sender: Any){
        self.performSegue(withIdentifier: "datasegue", sender: self)
    }
 @IBAction func orderButton(_ sender: UIButton){
    self.performSegue(withIdentifier: "ordersegue", sender: self)
    }
    @IBAction func pembayaranimg(_ sender: Any){
        self.performSegue(withIdentifier: "datasegue", sender: self)
    }
 @IBAction func pembayaranButton(_ sender: UIButton){
    self.performSegue(withIdentifier: "listpembayaransegue", sender: self)
    }
    @IBAction func pengirimanimg(_ sender: Any){
        self.performSegue(withIdentifier: "datasegue", sender: self)
    }
 @IBAction func pengirimanButton(_ sender: UIButton){
    self.performSegue(withIdentifier: "pengirimansegue", sender: self)
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
