//
//  WelcomeViewController.swift
//  MiniProject
//
//  Created by MacMini-03 on 3/28/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet var DaftarKantorTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func MasukHomepage(_ sender: UIButton){
        self.performSegue(withIdentifier: "homepagesegue", sender: self)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.DaftarKantorTextField {
            self.performSegue(withIdentifier: "kantorsegue", sender: self)
            
        }
        return false
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
