//
//  SettingsViewController.swift
//  tips
//
//  Created by ao guo on 12/29/15.
//  Copyright © 2015 ao guo. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var DarkOn: UISwitch!
    @IBOutlet weak var tControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        self.view.backgroundColor = UIColor.whiteColor()
        let defaults = NSUserDefaults.standardUserDefaults()
        DarkOn.on = defaults.boolForKey("darkmodeon")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ValueChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tControl.selectedSegmentIndex, forKey: "savedint")
        defaults.setBool(DarkOn.on, forKey: "darkmodeon")
        defaults.synchronize()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
