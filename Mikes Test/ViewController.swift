//
//  ViewController.swift
//  Mikes Test
//
//  Created by Michael Kwon on 6/4/17.
//  Copyright © 2017 Michael Kwon. All rights reserved.
//

import UIKit
import Branch

class ViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var setTextBool = false
    var newText = "tbd"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newText = appDelegate.GlobalDeepLinkTextVariable
        print(newText )
        MainLabel.text = newText
        let linkprop: BranchLinkProperties = BranchLinkProperties()
        linkprop.tags = ["store id","rewards id"]
        let buo = BranchUniversalObject(canonicalIdentifier: "content/123")
        buo.canonicalUrl = "https://mikekwon36.github.io"
        buo.contentDescription = "description"
        buo.contentMetadata.customMetadata = ["custom":"123"]
        buo.contentMetadata.customMetadata = ["anything":"everything"]
        buo.locallyIndex = true
        buo.userCompletedAction(BNCRegisterViewEvent)
        BranchEvent.standardEvent(.viewItem, withContentItem: buo).logEvent()
        buo.getShortUrl(with: linkprop)
    }
    
    @IBOutlet weak var MainLabel: UILabel!
    
    @IBAction func ButtonMethod(_ sender: UIButton) {
        if setTextBool == true {
            newText = "Hello World!"
            MainLabel.text = newText
            setTextBool = false
        } else {
            newText = "Goodbye World!"
            MainLabel.text = newText
            setTextBool = true
        }
        print("setText boolean set to " + String(setTextBool))
    }
    
    @IBAction func Button2Method(_ sender: UIButton) {
        // Branch.getInstance()?.handleDeepLink(withNewSession: URL?)
    }
}
