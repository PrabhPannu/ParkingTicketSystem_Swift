//
//  HomeViewController.swift
//  ParkingTicketSystem_w2018iOS
//
//  Created by moxDroid on 2018-02-27.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit
import MessageUI

class HomeViewController: UIViewController
{
    @IBOutlet weak var lblCount: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.lblCount.text = "\(ParkingTicket.dict.count)"
        let img = UIImage(named: "gmail")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: img?.withRenderingMode(.alwaysOriginal), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(HomeViewController.sendEmail))
        
        //let button = UIBarButtonItem(title: "Email", style: UIBarButtonItemStyle.plain, target: self, action: #selector(HomeViewController.sendEmail))
        //self.navigationItem.rightBarButtonItem = button
        
    }
    
    @objc func sendEmail()
    {
        if MFMailComposeViewController.canSendMail()
        {
            print("Email Configured")
            let emailVC = MFMailComposeViewController()
            emailVC.mailComposeDelegate = self
            emailVC.setToRecipients(["ask@parkingsystem.lm"])
            emailVC.setSubject("Need Help")
            emailVC.setMessageBody("Write your content here...", isHTML: true)
            
            //self.navigationController?.pushViewController(emailVC, animated: true)
            self.present(emailVC, animated: true, completion: nil)
        }
        else
        {
            print("No Email Configured")
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension HomeViewController: MFMailComposeViewControllerDelegate
{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        self.dismiss(animated: true, completion: nil)
    }
}
