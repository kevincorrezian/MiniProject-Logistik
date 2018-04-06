//
//  JenisPengirimanTableViewCell.swift
//  MiniProj
//
//  Created by Mac Mini-06 on 3/29/18.
//  Copyright © 2018 Mac Mini-06. All rights reserved.
//

import UIKit

class JenisPengirimanTableViewCell: UITableViewCell {

    @IBOutlet var namaJenisPengirimanLabel: UILabel!
    @IBOutlet var deskripsiJenisPengirimanLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
