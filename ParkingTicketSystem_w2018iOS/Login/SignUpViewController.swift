//
//  EmployeeVC.swift
//  Demo
//
//  Created by MacStudent on 2017-10-16.
//  Copyright © 2017 MacStudent. All rights reserved.
//

import UIKit
internal protocol SignUpViewControllerDelegate: class {
    
    func userEmailChanged(text:String?)
    
}

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tfEmailID: UITextField!
    @IBOutlet weak var tfFullName: UITextField!
    @IBOutlet weak var tfBirthdate: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    weak var delegate: SignUpViewControllerDelegate?
    
    var datePicker : UIDatePicker!
    var selectedBirtdDate: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tfBirthdate.delegate = self
    }

    @IBAction func btnSave(_ sender: UIButton)
    {
        if validateData()
        {
            let customer = Customer()
            customer.cEmailId = self.tfEmailID.text!
            customer.cName = self.tfFullName.text!
            customer.birthDate = self.selectedBirtdDate
            customer.password = self.tfPassword.text!
            
            let flag = Customer.addCustomer(cust: customer)
            if flag == true
            {
                
                delegate?.userEmailChanged(text: customer.cEmailId)
                navigationController?.popViewController(animated: true)
        }
        }
        else
        {
            let alert = UIAlertController(title: title,
                                          message: NSLocalizedString("MSG_DUPLICATION", comment: ""),
                                          preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: NSLocalizedString("STR_OK", comment: ""),
                                             style: .destructive, handler: nil)
            
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        self.pickUpDate(textField)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    //MARK:- Button
    @objc func doneClick()
    {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        self.tfBirthdate.text =  datePicker.date.getFormatedBirthDate()
        self.selectedBirtdDate = datePicker.date
        self.tfBirthdate.resignFirstResponder()
    }
    
    @objc func cancelClick()
    {
        self.tfBirthdate.resignFirstResponder()
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
    
    func validateData()->Bool
    {
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
}
