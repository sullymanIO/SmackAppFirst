//
//  ChatVC.swift
//  SmackAppFirst
//
//  Created by Suleman Daud on 2/2/18.
//  Copyright © 2018 Suleman Daud. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Outlets
    @IBOutlet weak var revealBtn: UIButton!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var messageTxtField: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    
    private(set) public var headerName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTableView.delegate = self
        messageTableView.dataSource = self
        // shifts the view up
        view.bindToKeyboard()
        messageTableView.reloadData()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.viewTapped))
        view.addGestureRecognizer(tap)
        revealBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: TO_NOTIFY_CHANNEL_NAME_CHANGED, object: nil)
        
        if AuthService.instance.loginStatus {
            AuthService.instance.userByData(completion: { (success) in
                if success {
                    self.onLoginGetMessages()
                    NotificationCenter.default.post(name: TO_NOTIFY_USER_DATA_CHANGED, object: nil)
                    NotificationCenter.default.post(name: TO_NOTIFY_CHANNELS_UPLOADED, object: nil)
                    
                }
            })
        }
    
    }
    
    @objc func viewTapped() {
        view.endEditing(true)
    }
    
    func onLoginGetMessages() {
        MessageService.instance.getChannels(completion: { (success) in
            if success {
                    if MessageService.instance.channels.count > 0 {
                        let channel: Channel =  MessageService.instance.channels[0]
                        MessageService.instance.updateChannelName(channel: channel)
                        self.setHeaderWithChannelName()
                        self.getMessages()
                        self.messageTableView.reloadData()
                    } else {
                        self.headerLbl.text = "No channels yet!"
                    }
            }
            
        })
    }
    
    @objc func channelSelected(_ :Notification) {
        
        setHeaderWithChannelName()
    }

    func getMessages() {
        MessageService.instance.getAllMessages { (success) in
            if success {
                print(MessageService.instance.messages)
                self.messageTableView.reloadData()
                self.setHeaderWithChannelName()
                
            }
        }
    }
    func setHeaderWithChannelName() {
        if let channelName = MessageService.instance.selectedChannel?.channel, MessageService.instance.selectedChannel?.channel != ""{
        headerLbl.text = "#\(channelName)"
        } else {
            headerLbl.text = "Smack"
        }
    }
    
    func setDefaultHeaderName() {
        headerName = "Smack"
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        guard let message = messageTxtField.text else {
            return
        }
        SocketService.instance.sendMessage(message: message) { (success) in
            if success {
                self.messageTxtField.text = ""
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as? MessageCell {
            cell.configureCell(message: MessageService.instance.messages[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    
    

}
