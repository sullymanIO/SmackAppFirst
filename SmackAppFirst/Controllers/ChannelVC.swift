//
//  ChannelVC.swift
//  SmackAppFirst
//
//  Created by Suleman Daud on 2/2/18.
//  Copyright © 2018 Suleman Daud. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDataSource, UITableViewDelegate{

    // Outlets
    @IBOutlet weak var channelTableView: UITableView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var profilePicImage: RoundedUiImages!
    
    @IBAction func prepareForUnwindVC(segue: UIStoryboardSegue){
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = view.frame.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(self.loginStatus), name: TO_NOTIFY_USER_DATA_CHANGED, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadTable), name: TO_NOTIFY_CHANNELS_UPLOADED, object: nil)
        setupUserInfo()
        SocketService.instance.getChannel { (success) in
            self.channelTableView.reloadData()
        }
        
        channelTableView.delegate = self
        channelTableView.dataSource = self

    }

    @objc func loginStatus(_ userDataDidChange: Notification) {
        setupUserInfo()
    }
    
    @objc func reloadTable() {
        channelTableView.reloadData()
    }
    
    func setupUserInfo () {
        if AuthService.instance.loginStatus {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            profilePicImage.image = UIImage(named: UserDataService.instance.avatarName)
            profilePicImage.backgroundColor = UserDataService.instance.returnColor(colorString: UserDataService.instance.avatarColor)
        } else {
            loginBtn.setTitle("Login", for: .normal)
            profilePicImage.image = UIImage(named: "profileDefault")
            profilePicImage.backgroundColor = UIColor.lightGray
        }
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.loginStatus {
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
            
        } else {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelCell", for: indexPath) as? ChannelCell {
            cell.configureCell(channel: MessageService.instance.channels[indexPath.item])
            return cell
        }
        
        return ChannelCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel: Channel = MessageService.instance.channels[indexPath.item]
        MessageService.instance.updateChannelName(channel: channel)
        MessageService.instance.clearAllMessagesForChannel()
        MessageService.instance.getAllMessages { (success) in
            NotificationCenter.default.post(name: TO_NOTIFY_CHANNEL_NAME_CHANGED, object: nil)
            self.revealViewController().revealToggle(animated: true)
        }

    }
    @IBAction func addChannelBtnPressed(_ sender: Any) {
        let addChannel = CreateChannelVC()
        addChannel.modalPresentationStyle = .custom
        present(addChannel, animated: true, completion: nil)
    }
    
    
}

