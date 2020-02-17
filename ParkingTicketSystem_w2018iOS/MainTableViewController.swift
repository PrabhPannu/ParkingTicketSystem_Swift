//
//  MainTableViewController.swift
//  ParkingTicketSystem_w2018iOS
//
//  Created by moxDroid on 2018-02-26.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit
import MessageUI

class MainTableViewController: UITableViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.hideBack()
    
    }
    
    func hideBack()
    {
        self.navigationItem.hidesBackButton = true
        let buttonLogout = UIBarButtonItem(title: NSLocalizedString("STR_LOGOUT", comment: ""), style: UIBarButtonItemStyle.plain, target: self, action: #selector(MainTableViewController.logout))
        
        self.navigationItem.rightBarButtonItem = buttonLogout
    }
    
    @objc func logout()
    {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //self.tableView.cellForRow(at: indexPath)?.contentView.backgroundColor = UIColor.gray
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //self.tableView.cellForRow(at: indexPath)?.contentView.backgroundColor = UIColor.purple
        if  indexPath.section == 0
        {
            if indexPath.row == 0
            {
                let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nextVC = storyBoard.instantiateViewController(withIdentifier: "homeVC") as! HomeViewController
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            if indexPath.row == 1
            {
                let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nextVC = storyBoard.instantiateViewController(withIdentifier: "addTicketVC") as! AddTicketViewController
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            
            if indexPath.row == 2
            {
                let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nextVC = storyBoard.instantiateViewController(withIdentifier: "reportVC") as! ReportTableViewController
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            
            if indexPath.row == 3
            {
                let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nextVC = storyBoard.instantiateViewController(withIdentifier: "locationVC") as! LocationViewController
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
        if  indexPath.section == 1
        {
            if indexPath.row == 0
            {
                
                let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nextVC = storyBoard.instantiateViewController(withIdentifier: "updateProfileVC") as! UpdateUserDetailsViewController
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            if indexPath.row == 1
            {
                
                let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nextVC = storyBoard.instantiateViewController(withIdentifier: "instructionVC") as! InstructionViewController
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            if indexPath.row == 2
            {
                let alert = UIAlertController(title: NSLocalizedString("STR_CONTACT", comment: ""),
                                              message: "\(NSLocalizedString("STR_NEED_HELP", comment: "")) \n Email: Test@test.com\n +0912345678",
                                              preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction = UIAlertAction(title: NSLocalizedString("STR_CANCEL", comment: ""),
                                                 style: .cancel, handler: nil)
                
                alert.addAction(okAction)
                
                let callAction = UIAlertAction(title: NSLocalizedString("STR_CALL", comment: ""),
                                             style: .default, handler: {
                _ in
                                                self.makeCall()
                })
                alert.addAction(callAction)
                
                let smsAction = UIAlertAction(title: NSLocalizedString("STR_SMS", comment: ""),
                                               style: .default, handler: {
                                                _ in
                                                self.sendSMS()
                })
                alert.addAction(smsAction)
                //Change Background of AlertView
                let subView = alert.view.subviews.first!
                let alertContentView = subView.subviews.first!
                let mainView = alertContentView.subviews.first!
                mainView.backgroundColor = Utils.uicolorFromHex(rgbValue: 0xC39BD3)
                //mainView.tintColor = UIColor.white
                //mainView.cornerRadius = 15
                self.present(alert, animated: true, completion: nil)
            }
            
            if indexPath.row == 3
            {
                self.navigationController?.popToRootViewController(animated: true)
                //self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func pushNextScreen(identifierName: String)
    {
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: identifierName)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func makeCall()
    {
        if let url = URL(string: "tel://+1123777777)"), UIApplication.shared.canOpenURL(url){
            if #available(iOS 10, *)
            {
                UIApplication.shared.open(url)
            }
            else
            {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    private func sendSMS()
    {
        if MFMessageComposeViewController.canSendText()
        {
            let messageVC = MFMessageComposeViewController()
            
            messageVC.body = "Hello, How are you?"
            messageVC.recipients = ["+11234567890"]
            messageVC.messageComposeDelegate = self
            
            self.present(messageVC, animated: false, completion: nil)
        }
        else
        {
            print("NO SIM available")
        }
    }

}

extension MainTableViewController: MFMessageComposeViewControllerDelegate
{
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
        case .cancelled:
            print("Message was cancelled")
            self.dismiss(animated: true, completion: nil)
        case .failed:
            print("Message failed")
            self.dismiss(animated: true, completion: nil)
        case .sent:
            print("Message was sent")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
