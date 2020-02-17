//
//  LoginViewController.swift
//  Demo
//
//  Created by MacStudent on 2018-02-26.
//  Copyright © 2018 Pritesh Patel. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController, SignUpViewControllerDelegate {
    
    @IBOutlet weak var myProgressView: UIView!
    @IBOutlet weak var lblVersionInfor: UILabel!
    @IBOutlet weak var mySwitchRemeber: UISwitch!
    var myUserDefault: UserDefaults!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfUsername: UITextField!
    
    var timer = Timer()
    var seconds = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.myProgressView.isHidden = true
        self.seconds = 5
        self.setSavedValues()
    }
    
    private func setSavedValues()
    {
        myUserDefault  = UserDefaults.standard
        if let userName = myUserDefault.value(forKey: "userName"){
            tfUsername.text = userName as? String
        }
        
        if let userPassword = myUserDefault.value(forKey: "userPassword"){
            tfPassword.text = userPassword as? String
        }
        
        self.setVersionInformation()
    }
    
    
    
    func userEmailChanged(text: String?)
    {
        self.tfUsername.text = text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let singUpVC = segue.destination as? SignUpViewController {
            singUpVC.delegate = self
        }
    }
    
    func segue() {
        
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainVC = storyBoard.instantiateViewController(withIdentifier: "mainVC") as! MainTableViewController
                    self.navigationController?.pushViewController(mainVC, animated: true)
    }

    @IBAction func btnLogin(_ sender: UIButton) {
        self.view.endEditing(true)
        if checkDynamicLogin()  {
            
            if self.mySwitchRemeber.isOn{
                self.myUserDefault.set(tfUsername.text, forKey: "userName")
                self.myUserDefault.set(tfPassword.text, forKey: "userPassword")
            }else{
                self.myUserDefault.removeObject(forKey: "userName")
                self.myUserDefault.removeObject(forKey: "userPassword")
            }
            runTimer()
            
        }
        else
        {
            let alert = UIAlertController(title: title,
                                          message: NSLocalizedString("MSG_INCORRECT_PASSWORD", comment: ""),
                                          preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: NSLocalizedString("STR_OK", comment: ""),
                                             style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func setVersionInformation()
    {
//        var str:String=""
//        if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") {
//            str = "V \(version)"
//        }
//        
//        if let versionCode = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") {
//            str = str + "(\(versionCode))"
//        }
//        
//        lblVersionInfor.text = str
    }
    
    func runTimer()
    {
        self.myProgressView.isHidden = false
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer()
    {
        self.seconds -= 1
        //This will decrement(count down)the seconds.
        if(seconds == 0)
        {
            myProgressView.isHidden = true
            self.timer.invalidate()
            segue()
        }
    }
    
    private func checkStaticLogin() -> Bool
    {
        if (tfUsername.text == "sa" && tfPassword.text == "sa") || (tfUsername.text == "super" && tfPassword.text == "super")
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    private func checkDynamicLogin() -> Bool
    {
        if let c = Customer.getCustomer(cEmailId: tfUsername.text!)
        {
            if c.password == tfPassword.text
            {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.setCurrentUser(cust: c)
                return true
            }
        }
        return false
    }
    
    //https://medium.com/@KaushElsewhere/how-to-dismiss-keyboard-in-a-view-controller-of-ios-3b1bfe973ad1
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
}

