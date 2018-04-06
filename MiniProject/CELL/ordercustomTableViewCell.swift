//
//  ordercustomerTableViewCell.swift
//  MiniProject
//
//  Created by MacMini-04 on 4/5/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

class ordercustomTableViewCell: UITableViewCell {
    
    @IBOutlet var tanggalpemesenananLabel: UILabel!
    @IBOutlet var namapelangganLabel: UILabel!
    @IBOutlet var kotapengirimLabel: UILabel!
    @IBOutlet var namapenerimaLabel: UILabel!
    @IBOutlet var kotapenerimaLabel: UILabel!
    @IBOutlet var deskripsibarangLabel: UILabel!
    @IBOutlet var alamatpenerimaLabel: UILabel!
    @IBOutlet var jenispengirimanLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
