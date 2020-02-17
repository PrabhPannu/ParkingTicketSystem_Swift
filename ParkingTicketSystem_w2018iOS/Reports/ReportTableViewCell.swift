//
//  ReportTableViewCell.swift
//  ParkingTicketSystem_w2018iOS
//
//  Created by moxDroid on 2018-02-26.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit

class ReportTableViewCell: UITableViewCell {

    @IBOutlet weak var cEmailId:UILabel!
    @IBOutlet weak var cMake:UIImageView!
    @IBOutlet weak var vehicleNumber:UILabel!
    @IBOutlet weak var vehicleMake:UILabel!
    @IBOutlet weak var vehicleColor:UILabel!
    @IBOutlet weak var parkingTiming:UILabel!
    @IBOutlet weak var parkingDateAndTime: UILabel!
    @IBOutlet weak var parkingLane:UILabel!
    @IBOutlet weak var parkingSpot:UILabel!
    @IBOutlet weak var paymentMethod: UILabel!
    @IBOutlet weak var payment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /*
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(10, 10, 10, 10))
    }
 */

}
