//
//  OTPCode.swift
//  Calendar
//
//  Created by Wendolyn Kang on 30/10/18.
//  Copyright © 2018 Wendolyn Kang. All rights reserved.
//

import UIKit

class CodeViewController: UIViewController, UITextFieldDelegate {
    
    //"attach" the text fields here, there are four for each number
  
   
    @IBOutlet weak var txtOTP1: UITextField!
    @IBOutlet weak var txtOTP2: UITextField!
    @IBOutlet weak var txtOTP3: UITextField!
    @IBOutlet weak var txtOTP4: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //to make a clear background colour for the text fields
        txtOTP1.backgroundColor = UIColor.clear
        txtOTP2.backgroundColor = UIColor.clear
        txtOTP3.backgroundColor = UIColor.clear
        txtOTP4.backgroundColor = UIColor.clear
        
        //a function to add the bottom dash "_" for the text fields
        addBottomBorderTo(textField: txtOTP1)
        addBottomBorderTo(textField: txtOTP2)
        addBottomBorderTo(textField: txtOTP3)
        addBottomBorderTo(textField: txtOTP4)
        
        //wait i forgot what this does...
        //but i remember this was important to imporve it so welp
        txtOTP1.delegate = self
        txtOTP2.delegate = self
        txtOTP3.delegate = self
        txtOTP4.delegate = self
        
        //so that when u tap it will automatically like default to the first text field...
        //...i think
        txtOTP1.becomeFirstResponder()
    }
    
    //declare the function of adding the bottom dash "_"
    func addBottomBorderTo(textField:UITextField) {
        let layer = CALayer()
        layer.backgroundColor = UIColor.gray.cgColor
        layer.frame = CGRect(x: 0.0, y: textField.frame.size.height - 2.0, width: textField.frame.size.width, height: 2.0)
        textField.layer.addSublayer(layer)
    }
    
    //to make it so that after you type one numer it auto goes to the next text field
    //its basically for convienience
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if ((textField.text?.count)! < 1 ) && (string.count > 0) {
            if textField == txtOTP1 {
                txtOTP2.becomeFirstResponder()
            }
            
            if textField == txtOTP2 {
                txtOTP3.becomeFirstResponder()
            }
            
            if textField == txtOTP3 {
                txtOTP4.becomeFirstResponder()
            }
            
            if textField == txtOTP4 {
                txtOTP4.resignFirstResponder()
            }
            textField.text = string
            return false
        }
            
        else if ((textField.text?.count)! >= 1 ) && (string.count == 0) {
            
            if textField == txtOTP2 {
                txtOTP1.becomeFirstResponder()
            }
            
            if textField == txtOTP3 {
                txtOTP2.becomeFirstResponder()
            }
            
            if textField == txtOTP4 {
                txtOTP3.becomeFirstResponder()
            }
            
            if textField == txtOTP1 {
                txtOTP1.resignFirstResponder()
            }
            
            textField.text = ""
            return false
        }
        else if (textField.text?.count)! >= 1 {
            textField.text = string
            return false
        }
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
