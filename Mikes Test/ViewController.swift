//
//  ViewController.swift
//  Mikes Test
//
//  Created by Michael Kwon on 6/4/17.
//  Copyright © 2017 Michael Kwon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var setTextBool: Bool = false
    var newText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    }

    @IBAction func Button2Method(_ sender: UIButton) {
    }
}

