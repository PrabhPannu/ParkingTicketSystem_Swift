//
//  AddTicketViewController.swift
//  ParkingTicketSystem_w2018iOS
//
//  Created by moxDroid on 2018-02-26.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit
enum CurrentSelectionForPicker{
    case Make
    case Color
    case Lane
    case Spot
    case Payment
}
class AddTicketViewController: UIViewController {
    @IBOutlet weak var sebmentTime: UISegmentedControl!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var imgCarMake: UIImageView!
    
    @IBOutlet weak var txtVehicleNumber: UITextField!
    @IBOutlet weak var txtCarMake: UITextField!
    @IBOutlet weak var txtPaymentMethod: UITextField!
    @IBOutlet weak var txtParkingSpot: UITextField!
    @IBOutlet weak var txtParkingLane: UITextField!
    @IBOutlet weak var txtCarColor: UITextField!
    var currentSelected: CurrentSelectionForPicker!
    var myPickerView : UIPickerView!
    var cust: Customer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
       cust = appDelegate.getCurrentUser()
        
        let img = UIImage(named: "save.png")
        
        self.navigationItem.rightBarButtonItem =  UIBarButtonItem(image: img?.withRenderingMode(.alwaysOriginal), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(AddTicketViewController.save))
        
        //let button = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.plain, target: self, action: #selector(AddTicketViewController.save))
            //self.navigationItem.rightBarButtonItem = button
        
        self.txtCarMake.delegate = self
        self.txtCarColor.delegate = self
        self.txtParkingLane.delegate = self
        self.txtParkingSpot.delegate = self
        self.txtPaymentMethod.delegate = self
        self.lblDateTime.text = Date().getForamttedDateAndTime()
        
    }
    
    @objc func save()
    {
        
        let alert = UIAlertController(title: title,
                                      message: "Are you sure you want to print the ticket?",
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Yes",
                                         style: .default, handler: { _ in
                                            let myTicket = ParkingTicket(self.cust.cEmailId!, self.txtVehicleNumber.text!, self.txtCarMake.text!, self.txtCarColor.text!, self.sebmentTime.titleForSegment(at: self.sebmentTime.selectedSegmentIndex)!, Date(), self.txtParkingLane.text!, self.txtParkingSpot.text!, self.txtPaymentMethod.text!, Utils.getPaymentRateArray()[self.sebmentTime.selectedSegmentIndex])
                                            
                                            let _ = ParkingTicket.addParkingTicket(ticket: myTicket)
                                            
                                            let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                            let mainVC = storyBoard.instantiateViewController(withIdentifier: "printTicketVC") as! PrintTicketViewController
                                            mainVC.parkingTicker = myTicket
                                            self.navigationController?.pushViewController(mainVC, animated: true)
        })
        
        alert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "No",
                                         style: .default, handler: nil)
        
        alert.addAction(cancelAction)
        
        //----- Custom Color ------
        let subView = alert.view.subviews.first!
        let alertContentView = subView.subviews.first!
        let mainView = alertContentView.subviews.first!
        mainView.backgroundColor = Utils.uicolorFromHex(rgbValue: 0xC39BD3)
        //---- End Custom Color -----
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func segmentTimeSelection(_ sender: UISegmentedControl) {
        
        self.lblPrice.text  = (Utils.getPaymentRateArray()[Int(sender.selectedSegmentIndex)]).currency()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func pickUp(_ textField : UITextField){
        
        // UIPickerView
        self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.myPickerView.delegate = self
        self.myPickerView.dataSource = self
        self.myPickerView.backgroundColor = UIColor.white
        textField.inputView = self.myPickerView
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor =  UIColor.purple//UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddTicketViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(AddTicketViewController.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    //MARK:- Button
    @objc func doneClick() {
        self.hideKeyboard()
        self.setSelectedValueFromPickerView(index: self.myPickerView.selectedRow(inComponent: 0))
    }
    
    private func setSelectedValueFromPickerView(index: Int)
    {
        switch currentSelected
        {
        case .Make?:
            let carMake = Utils.getCarMakeArray()[index]
            self.txtCarMake.text = carMake
            self.imgCarMake.image = UIImage(named: "\(carMake.lowercased()).png")
        case .Color?:
            self.txtCarColor.text = Utils.getCarColorArray()[index]
        case .Lane?:
            self.txtParkingLane.text = Utils.getParkingLaneArray()[index]
        case .Spot?:
            self.txtParkingSpot.text = Utils.getParkingSpotArray()[index]
        case .Payment?:
            self.txtPaymentMethod.text = Utils.getPaymentMethodsArray()[index]
        default:
            print("No Selection")
        }
    }
    
    @objc func cancelClick() {
        self.hideKeyboard()
    }
    
    private func hideKeyboard()
    {
        switch currentSelected
        {
        case .Make?:
            self.txtCarMake.resignFirstResponder()
        case .Color?:
            self.txtCarColor.resignFirstResponder()
        case .Lane?:
            self.txtParkingLane.resignFirstResponder()
        case .Spot?:
            self.txtParkingSpot.resignFirstResponder()
        case .Payment?:
            self.txtPaymentMethod.resignFirstResponder()
        default:
            print("No Selection")
        }
        
    }

}

extension AddTicketViewController :  UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch currentSelected
        {
        case .Make?:
            return Utils.getCarMakeArray().count
        case .Color?:
            return Utils.getCarColorArray().count
        case .Lane?:
            return Utils.getParkingLaneArray().count
        case .Spot?:
            return Utils.getParkingSpotArray().count
        case .Payment?:
            return Utils.getPaymentMethodsArray().count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch currentSelected
        {
        case .Make?:
            return Utils.getCarMakeArray()[row]
        case .Color?:
            return Utils.getCarColorArray()[row]
        case .Lane?:
            return Utils.getParkingLaneArray()[row]
        case .Spot?:
            return Utils.getParkingSpotArray()[row]
        case .Payment?:
            return Utils.getPaymentMethodsArray()[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.setSelectedValueFromPickerView(index: row)
    }
}

extension AddTicketViewController :  UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
        //return false // do not show keyboard nor cursor
    }
 
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            currentSelected = CurrentSelectionForPicker.Make
        case 1:
            currentSelected = CurrentSelectionForPicker.Color
        case 2:
            currentSelected = CurrentSelectionForPicker.Lane
        case 3:
            currentSelected = CurrentSelectionForPicker.Spot
        case 4:
            currentSelected = CurrentSelectionForPicker.Payment
        default:
            print("No Selection")
        }
        self.pickUp(textField)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
}
