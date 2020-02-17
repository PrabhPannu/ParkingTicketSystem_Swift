//
//  InstructionViewController.swift
//  ParkingTicketSystem_w2018iOS
//
//  Created by moxDroid on 2018-02-26.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit

class InstructionViewController: UIViewController
{
    @IBOutlet weak var webViewInstruction: UIWebView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        loadFile()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadFile()
    {
        //instruction.html
        let localfilePath = Bundle.main.url(forResource: "instruction", withExtension: "html");
        let myRequest = NSURLRequest(url: localfilePath!);
        self.webViewInstruction.loadRequest(myRequest as URLRequest);
        
    }
}
