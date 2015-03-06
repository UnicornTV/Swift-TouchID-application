//
//  ViewController.swift
//  Touch ID Example
//
//  Created by Adam Leonard on 9/27/14.
//  Copyright (c) 2014 com.swiftcast.tv. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestFingerprintAuthentication()
    }

    func requestFingerprintAuthentication() {
        let context = LAContext()
        var authError: NSError?
        let authenticationReason: String = "To display a message to the user"
        
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &authError) {
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: authenticationReason, reply: {
                (success: Bool, error: NSError?) -> Void in
                if success {
                    self.updateMessageLabel("Woohoo")
                } else {
                    self.updateMessageLabel("Unable to Authenticate")
                }
            })
        }
    }
    
    func updateMessageLabel(message: String) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.messageLabel.text = message
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

