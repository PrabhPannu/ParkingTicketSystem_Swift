//
//  LocationStepsViewController.swift
//  ParkingTicketSystem_w2018iOS
//
//  Created by moxDroid on 2018-03-08.
//  Copyright © 2018 Pritesh Patel. All rights reserved.
//

import UIKit
import MapKit

class LocationStepsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var btnTime: UIBarButtonItem!
    @IBOutlet weak var btnDistance: UIBarButtonItem!
    @IBOutlet weak var tblLocationSteps: UITableView!
    
    var steps:[MKRouteStep] = []
    var totalDistanceString: String = "Distance"
    var totalTimeString: String = "Time"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblLocationSteps.delegate = self
        self.tblLocationSteps.dataSource = self
        
        self.btnDistance.title = totalDistanceString
        self.btnTime.title = totalTimeString

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationStepsCell", for: indexPath)
        let step = steps[indexPath.row]
        cell.textLabel?.textColor = UIColor.purple
        cell.textLabel?.text = step.instructions
        cell.detailTextLabel?.textColor = UIColor.blue
        cell.detailTextLabel?.text = "Distance : \(step.distance/1000) km \n \(step.notice ?? "")"
        
        return cell
    }
    
/*
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
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
 */
}
