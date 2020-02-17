//
//  ReportTableViewController.swift
//  ParkingTicketSystem_w2018iOS
//
//  Created by moxDroid on 2018-02-26.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit

class ReportTableViewController: UITableViewController {

    var ticketList: [ParkingTicket]!
    override func viewDidLoad() {
        super.viewDidLoad()

       self.ticketList = ParkingTicket.getAllParkingTicket()
        print("\(ticketList.count) Size")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ticketList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customTicketCell", for: indexPath) as! ReportTableViewCell

        let ticket = ticketList[indexPath.row]
        cell.cEmailId.text = ticket.cEmailId!
        cell.vehicleNumber.text = ticket.vehicleNumber!
        cell.cMake.image = UIImage(named: "\(ticket.vehicleMake!).png")
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor =
        UIColor.clear
        var whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 10, width: self.view.frame.size.width - 20, height: 190))
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 3.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.5
        whiteRoundedView.backgroundColor = Utils.uicolorFromHex(rgbValue: 0xD2B4DE)
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
    }
}
