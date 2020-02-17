//
//  UpdateUserDetailsViewController.swift
//  ParkingTicketSystem_w2018iOS
//
//  Created by moxDroid on 2018-02-28.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit

class UpdateUserDetailsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var txtUserFullName: UITextField!
    @IBOutlet weak var txtBirthDate: UITextField!
    @IBOutlet weak var txtVehicleNumber: UITextField!
    @IBOutlet weak var txtOldPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    
    var datePicker : UIDatePicker!
    var selectedBirtdDate: Date?
    
    var cust: Customer!
    var appDelegate: AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let button = UIBarButtonItem(title: NSLocalizedString("STR_SAVE", comment: ""), style: UIBarButtonItemStyle.plain, target: self, action: #selector(UpdateUserDetailsViewController.update))
        self.navigationItem.rightBarButtonItem = button
        
        
         self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.cust = self.appDelegate.getCurrentUser()
        setCustomerData()
        
        self.txtBirthDate.delegate = self
    }
    
    private func setCustomerData()
    {
        self.lblUserEmail.text = cust.cEmailId
        self.txtUserFullName.text = cust.cName
        self.txtBirthDate.text = cust.birthDate?.getForamttedDate()
        self.txtVehicleNumber.text = cust.vehicleNumber
        self.txtPhoneNumber.text = cust.phoneNumber
    }
    
    func pickUpDate(_ textField : UITextField){
        
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor.white
        self.datePicker.datePickerMode = UIDatePickerMode.date
        textField.inputView = self.datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.purple
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: NSLocalizedString("STR_DONE", comment: ""), style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: NSLocalizedString("STR_CANCEL", comment: ""), style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        self.pickUpDate(textField)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    @objc func doneClick()
    {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        self.txtBirthDate.text =  datePicker.date.getFormatedBirthDate()
        self.selectedBirtdDate = datePicker.date
        self.txtBirthDate.resignFirstResponder()
    }
    
    @objc func cancelClick()
    {
        self.txtBirthDate.resignFirstResponder()
    }
    
    @objc func update()
    {
        if self.validateData() == true
        {
            self.cust.cName = txtUserFullName.text
            self.cust.birthDate = selectedBirtdDate
            self.cust.vehicleNumber = txtVehicleNumber.text
            self.cust.phoneNumber = txtPhoneNumber.text
            
            if Customer.updateCustomer(cust: cust)
            {
                self.appDelegate.setCurrentUser(cust: cust)
                self.presentAlertWithTitle(title: "Success", message: "Record Updated Successfully...")
                print()
            }
            else
            {
                self.presentAlertWithTitle(title: "Error...", message: "Error while  Updating record...")
            }
        }
    }
    
    private func validateData() -> Bool
    {
        var errorMessage = ""
        var flag = true
        if self.txtUserFullName.text?.count == 0
        {
            errorMessage = "Enter Full Name\n"
            flag = false
        }
        
        if self.txtVehicleNumber.text?.count == 0
        {
            errorMessage += "Enter Vehicle Number\n"
            flag = false
        }
        
        if self.txtOldPassword.text?.count != 0
        {
            if self.txtNewPassword.text?.count != 0
            {
                if self.txtNewPassword.text != self.txtConfirmPassword.text
                {
                    errorMessage += "Invalid match for New and confirm Password\n"
                    flag = false
                }
                else
                {
                    if self.txtOldPassword.text != self.cust.password
                    {
                        errorMessage += "Invalid Current Password\n[\(cust.password!)]"
                        flag = false
                    }
                    else
                    {
                        self.cust.password = txtNewPassword.text
                    }
                }
            }
            else
            {
                errorMessage += "Enter New Password\n"
                flag = false
            }
        }
        
        if self.txtPhoneNumber.text?.count == 0
        {
            errorMessage += "Enter Phone Number\n"
            flag = false
        }
        
        if flag == false
        {
            self.presentAlertWithTitle(title: "Error!!!", message: errorMessage)
        }
        return flag
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
}

import UIKit

extension UIViewController {
    
    func presentAlertWithTitle(title: String, message: String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
       
        alertController.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
        
        //----- Custom Color ------
        let subView = alertController.view.subviews.first!
        let alertContentView = subView.subviews.first!
        let mainView = alertContentView.subviews.first!
        mainView.backgroundColor = Utils.uicolorFromHex(rgbValue: 0xC39BD3)
        //---- End Custom Color -----
        self.present(alertController, animated: true, completion: nil)
    }
}
