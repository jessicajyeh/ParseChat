//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Jessica Yeh on 6/26/17.
//  Copyright © 2017 Jessica Yeh. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var chatMessageField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [PFObject]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50

        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.refresh), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapSend(_ sender: Any) {
        let chatMessage = PFObject(className: "Message_fbu2017")
        chatMessage["text"] = chatMessageField.text ?? ""
        chatMessage["user"] = PFUser.current()
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.chatMessageField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let message = messages?[indexPath.row]
        cell.chatLabel.text = message?["text"] as? String
        
        if let user = message?["user"] as? PFUser {
            // User found! update username label with username
            cell.usernameLabel.text = user.username
        } else {
            // No user found, set default username
            cell.usernameLabel.text = "🤖"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages!.count
    }


    func refresh () {
        let query = PFQuery(className: "Message_fbu2017")
        query.includeKey("user")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if error == nil {
                self.messages = posts
                self.tableView.reloadData()
            } else {
                print(error!)
            }
        }
    }
    /*
    // MARK: - Navigation
     

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
