//
//  ChatViewController.swift
//  Parse Chat
//
//  Created by Shayin Feng on 2/23/17.
//  Copyright © 2017 Shayin Feng. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var viewToButtom: NSLayoutConstraint!
    
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var chatTableView: UITableView!
    
    @IBOutlet weak var inputFieldView: UIView!
    
    var tapGesture = UIGestureRecognizer()
    
    var chats: [PFObject]?
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        let contentString = inputTextField.text
        if contentString != "", contentString != nil {
            postMessage ()
        }
        
    }
    
    func getMessage () {
        var query = PFQuery(className:"Message4567")
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                print("Success")
                // Do something with the found objects
                self.chats = objects
                self.chatTableView.reloadData()
            } else {
                // Log details of the failure
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    func postMessage () {
        let message = PFObject(className:"Message4567")
        print(currentuser)
        message["user"] = PFUser.current()?.username
        message["text"] = inputTextField.text
        message.saveInBackground { (success, error) in
            if success {
                print("submitted")
                self.inputTextField.text = ""
                self.inputTextField.resignFirstResponder()
            }
            if let error = error {
                Helper.alertMessage("Submit Message", userMessage: "\(error.localizedDescription)", action: { (action) in }, sender: self)
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTableView.dataSource = self
        chatTableView.delegate = self
        
        
        // auto adjust table cell height
        chatTableView.rowHeight = UITableViewAutomaticDimension
        chatTableView.estimatedRowHeight = 80
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)
    }
    
    func keyboardWillShow(notification: Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y -= keyboardSize.height
        }
        
    }
    
    func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y += keyboardSize.height
        }
    }
    
    func onTimer() {
        // Add code to be run periodically
        getMessage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ChatTableViewCell
        if let chat = chats?[indexPath.row] {
            cell.contentLabel.text = "\(chat["user"] ?? "nil"): \(chat["text"] ?? "nil")"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if chats == nil {
            return 0
        } else {
            return chats!.count
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        inputTextField.resignFirstResponder()
    }
}
