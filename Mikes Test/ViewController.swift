//
//  ViewController.swift
//  Mikes Test
//
//  Created by Michael Kwon on 6/4/17.
//  Copyright © 2017 Michael Kwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var setTextBool: Bool = false
    var newText: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newText = appDelegate.GlobalDeepLinkTextVariable
        print(newText ?? "No value passed from AppDelegate")
        MainLabel.text = newText
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
    }
}

