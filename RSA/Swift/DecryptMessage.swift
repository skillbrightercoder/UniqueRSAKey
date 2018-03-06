//
//  DecryptMessage.swift
//  RSA
//
//  Created by Reejo Samuel on 9/23/17.
//  Copyright © 2017 Clapp Inc. All rights reserved.
//

import UIKit

class DecryptMessage: UIViewController {
    let rsa: RSA = RSA.sharedInstance()

    @IBOutlet weak var encryptedMessageField: UITextView!
    @IBOutlet weak var decryptedMessageField: UITextView!
    
    @IBAction func decryptMessage(_ sender: Any) {
        let utf8str = encryptedMessageField.text.data(using: String.Encoding.utf8)
        
        if let base64Encoded = utf8str?.base64EncodedData()
        {
            
            print("Encoded:  \(base64Encoded)")
            decryptedMessageField.text = rsa.decryptUsingPrivateKey(with: base64Encoded)

           /* if let base64Decoded = NSData(base64EncodedString: base64Encoded, options:   NSDataBase64DecodingOptions(rawValue: 0))
                .map({ NSString(data: $0, encoding: NSUTF8StringEncoding) })
            {
                // Convert back to a string
                println("Decoded:  \(base64Decoded)")
            }*/
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "RSA: Decrypt"
    }
}
