//
//  Helper.swift
//  Parse Chat
//
//  Created by Shayin Feng on 2/23/17.
//  Copyright © 2017 Shayin Feng. All rights reserved.
//

import UIKit

class Helper: NSObject {
    
    class func alertMessage(_ userTitle: String, userMessage: String, action: @escaping (UIAlertAction) -> (), sender: AnyObject)
    {
        let myAlert = UIAlertController(title: userTitle, message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: action)
        myAlert.addAction(okAction)
        sender.present(myAlert, animated:true, completion:nil)
    }
    
    class func alertMessageWithAction(_ userTitle: String, userMessage: String, left: String, right: String, leftAction: @escaping (UIAlertAction) -> (), rightAction: @escaping (UIAlertAction) -> (), sender: AnyObject)
    {
        let myAlert = UIAlertController(title: "Log Out", message: "Are you sure to logout?", preferredStyle: UIAlertControllerStyle.alert)
        
        myAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: leftAction))
        
        myAlert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: rightAction))
        sender.present(myAlert, animated: true, completion: nil)
    }
}
