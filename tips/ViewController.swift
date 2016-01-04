//
//  ViewController.swift
//  tips
//
//  Created by ao guo on 12/24/15.
//  Copyright © 2015 ao guo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Tip: UILabel!
    @IBOutlet weak var BillAmount: UILabel!
    @IBOutlet weak var NumberOfPeople: UILabel!
    @IBOutlet weak var tipSplitter: UISlider!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var Split: UILabel!
    @IBOutlet weak var Total: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
    var select = defaults.integerForKey("savedint")
        tipControl.selectedSegmentIndex = select
        if defaults.boolForKey("darkmodeon")==true{
            self.view.backgroundColor = UIColor.blackColor()
            tipLabel.textColor = UIColor.whiteColor()
            totalLabel.textColor = UIColor.whiteColor()
            NumberOfPeople.textColor = UIColor.whiteColor()
            BillAmount.textColor = UIColor.whiteColor()
            Tip.textColor = UIColor.whiteColor()
            Split.textColor = UIColor.whiteColor()
            Total.textColor = UIColor.whiteColor()
        }
        else{
            self.view.backgroundColor = UIColor.whiteColor()
            tipLabel.textColor = UIColor.blackColor()
            totalLabel.textColor = UIColor.blackColor()
            NumberOfPeople.textColor = UIColor.blackColor()
            BillAmount.textColor = UIColor.blackColor()
            Tip.textColor = UIColor.blackColor()
            Split.textColor = UIColor.blackColor()
            Total.textColor = UIColor.blackColor()
        }
    }
    override func viewDidDisappear(animated: Bool) {
        let previousDate = NSDate.timeIntervalSinceReferenceDate()
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(Int(NSString(string: billField.text!).doubleValue), forKey: "previousAmount")
        defaults.setDouble(previousDate, forKey: "previousTime")
        defaults.synchronize()
    }
    override func viewDidAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        billField.becomeFirstResponder()
        let preAmount = defaults.integerForKey("previousAmount")
        let now = NSDate.timeIntervalSinceReferenceDate()
        let preTime = defaults.doubleForKey("previousTime")
        if (preAmount > 0 && (now - preTime) < (10 * 60)){
            billField.text = "\(preAmount)"
        }
        else{
            billField.text = ""
        }
        var billAmount = NSString(string: billField.text!).doubleValue
        var tipPercentages = [0.18,0.2,0.22]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        tipLabel.text = formatAmount(tip)
        totalLabel.text = formatAmount(total)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func formatAmount (amount: Double) ->String{
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        return formatter.stringFromNumber(amount)!
    }

    @IBAction func Tipsplit(sender: AnyObject) {
        if (billField.text == ""){
            UIView.animateWithDuration(1, animations: {
                self.billField.frame = CGRectMake(132, 300, 168, 30)
                print("Empty Bill")
                self.tipLabel.hidden = true
                self.totalLabel.hidden = true
                self.tipControl.hidden = true
            })
        }
        else{
            UIView.animateWithDuration(1, animations: {
                self.billField.frame = CGRectMake(132, 83, 168, 30)
                self.tipLabel.hidden = false
                self.totalLabel.hidden = false
                self.tipControl.hidden = false
            })
        }
        var tipPercentages = [0.18,0.2,0.22]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = NSString(string: billField.text!).doubleValue
        var tipSplited = Int(tipSplitter.value)
        var tip = billAmount * tipPercentage/Double(tipSplited)
        var total = (billAmount + tip)/Double(tipSplited)
        NumberOfPeople.text = String(tipSplited)
        tipLabel.text = formatAmount(tip)
        totalLabel.text = formatAmount(total)
    }
    @IBAction func onEditingChanged(sender: AnyObject) {
        if (billField.text == ""){
        UIView.animateWithDuration(1, animations: {
            self.billField.frame = CGRectMake(132, 300, 168, 30)
            print("Empty Bill")
            self.tipLabel.hidden = true
            self.totalLabel.hidden = true
            self.tipControl.hidden = true
                })
        }
        else{
            UIView.animateWithDuration(1, animations: {
                self.billField.frame = CGRectMake(132, 83, 168, 30)
                self.tipLabel.hidden = false
                self.totalLabel.hidden = false
                self.tipControl.hidden = false
            })
        }
        var tipPercentages = [0.18,0.2,0.22]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = NSString(string: billField.text!).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        tipLabel.text = formatAmount(tip)
        totalLabel.text = formatAmount(total)
    }
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

}

