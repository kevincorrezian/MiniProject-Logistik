//
//  pengirimanTableViewCell.swift
//  MiniProject
//
//  Created by MacMini-03 on 4/9/18.
//  Copyright © 2018 Bootcamp141. All rights reserved.
//

import UIKit

class pengirimanTableViewCell: UITableViewCell {

    @IBOutlet var nomorPemesananLabel: UILabel!
    @IBOutlet var tanggalPenerimaanLabel: UILabel!
    @IBOutlet var TanggalPengirimanLabel: UILabel!
    @IBOutlet var jenisPengirimanLabel: UILabel!
    @IBOutlet var namaKurirLabel: UILabel!
    @IBOutlet var namaKantorLabel: UILabel!
    @IBOutlet var statusPengirimanLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
