//
//  CreateChannelVC.swift
//  SmackAppFirst
//
//  Created by Suleman Daud on 2/19/18.
//  Copyright © 2018 Suleman Daud. All rights reserved.
//

import UIKit

class CreateChannelVC: UIViewController {
    // Outlets
    @IBOutlet weak var channelName: UITextField!
    @IBOutlet weak var channelDes: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        activityIndicator.isHidden = true
    }

    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createChannelBtnPressed(_ sender: Any) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        guard let channelName = channelName.text else { return }
        guard let channelDes = channelDes.text else { return }
        
        SocketService.instance.addChannel(channelName: channelName, channelDes: channelDes) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func setupView() {
        channelName.attributedPlaceholder = NSAttributedString(string: "Channel Name", attributes: [NSAttributedStringKey.foregroundColor: PLACEHOLDER_COLOR])
        channelDes.attributedPlaceholder = NSAttributedString(string: "Channel Description", attributes: [NSAttributedStringKey.foregroundColor: PLACEHOLDER_COLOR])
    }
    
}
