//
//  pembayaranTableViewCell.swift
//  MiniProject
//
//  Created by MacMini-03 on 4/6/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

class pembayaranTableViewCell: UITableViewCell {

    @IBOutlet var idorderLabel: UILabel!
    @IBOutlet var namapengirimLabel: UILabel!
    @IBOutlet var jenispengirimanLabel: UILabel!
    @IBOutlet var deskripsibarangLabel: UILabel!
    @IBOutlet var totalpembayaranLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
