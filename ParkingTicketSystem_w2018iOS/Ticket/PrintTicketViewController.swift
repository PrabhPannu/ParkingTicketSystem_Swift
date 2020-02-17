//
//  PrintTicketViewController.swift
//  ParkingTicketSystem_w2018iOS
//
//  Created by moxDroid on 2018-02-28.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit

class PrintTicketViewController: UIViewController {

    var parkingTicker: ParkingTicket?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.hideBack()
        
    }
    
    func hideBack()
    {
        self.navigationItem.hidesBackButton = true
        let buttonHome = UIBarButtonItem(title: "Main", style: UIBarButtonItemStyle.plain, target: self, action: #selector(PrintTicketViewController.goToHome))
        
        self.navigationItem.leftBarButtonItem = buttonHome
    }
    
    @objc func goToHome() {
        self.navigationController?.popToViewController((navigationController?.viewControllers[1])!, animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
