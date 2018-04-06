//
//  Utilities.swift
//  SQLiteLearn
//
//  Created by MacMini-03 on 3/19/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

class Utilities {
    static let sharedInstance = Utilities()
    
    let logindatakey = "MiniProjectlogindata"
    
    func showAlert(obj: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "OK", style: .cancel)
        { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        obj.present(alert, animated: true, completion: nil)
    }
}
