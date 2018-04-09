//
//  PelangganTableViewCell.swift
//  MiniProj
//
//  Created by Mac Mini-06 on 3/28/18.
//  Copyright © 2018 Mac Mini-06. All rights reserved.
//

import UIKit

class PelangganTableViewCell: UITableViewCell {

    @IBOutlet var namaLabel: UILabel!
    @IBOutlet var alamatLabel: UILabel!
    @IBOutlet var teleponLabel: UILabel!
    @IBOutlet var kodeposLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
