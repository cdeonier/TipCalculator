import UIKit

class TipsController: UIViewController, TipSelectedDelegate {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipsButton: UIButton!
    @IBOutlet weak var billAmountContainer: UIView!
    @IBOutlet weak var tipContainer: UIView!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var totalContainer: UIView!
    
    var currentTip: Int?
    var currentBillAmount = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initValues()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        initializeTheme()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        setTipButtonText()
        billField.becomeFirstResponder()
        checkAndSetBillAmountIfExists()
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        updateAmounts()
    }
    
    @IBAction func billFieldDidChange(sender: UITextField) {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        
        if sender.text!.characters.count > 1 {
            currentBillAmount = Double((formatter.numberFromString(sender.text!)?.doubleValue)!)
            updateAmounts()
            
            if billAmountContainer.frame.origin.y != 85 {
                animateDisplayFields()
            }
        } else {
            currentBillAmount = 0.0
            initCurrencySymbol()
        }
    }
    
    func updateAmounts() {
        let tipPercentage = Double(currentTip!) / 100
        
        if currentBillAmount > 0.0 {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.billAmount = currentBillAmount
            
            let tip = currentBillAmount * tipPercentage
            let total = currentBillAmount + tip
            
            tipsLabel.text = getCurrencyString(tip)
            totalLabel.text = getCurrencyString(total)
        } else {
            tipsLabel.text = getCurrencyString(0)
            totalLabel.text = getCurrencyString(0)
        }
    }
    
    func initValues() {
        billAmountContainer.frame.origin.y = 200
        currentTip = PreferencesUtil.getPreferredPercentage() ?? 18
        initCurrencySymbol()
    }
    
    func initCurrencySymbol() {
        let locale = NSLocale.currentLocale()
        let currencySymbol = locale.objectForKey(NSLocaleCurrencySymbol) as! String
        billField.text = currencySymbol
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "tipPercentageSegue" {
            let controller:TipsPercentageController = segue.destinationViewController as! TipsPercentageController
            controller.delegate = self
            controller.currentTip = currentTip
        } else if segue.identifier == "tipsSettingSegue" {
            let controller:TipsSettingsController = segue.destinationViewController as! TipsSettingsController
            controller.delegate = self
        }
    }
    
    func checkAndSetBillAmountIfExists() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if appDelegate.billAmount != nil {
            billField.text = getCurrencyString(currentBillAmount)
            restoreBillAmountAndFields()
        }
    }
    
    func restoreBillAmountAndFields() {
        billAmountContainer.frame.origin.y = 85
        tipContainer.alpha = 1
        separator.alpha = 1
        totalContainer.alpha = 1
        updateAmounts()
    }
    
    func tipSelected(percentage: Int) {
        currentTip = percentage
        setTipButtonText()
        updateAmounts()
    }
    
    func setTipButtonText() {
        tipsButton.setTitle("Tip \(currentTip!)%:", forState: .Normal)
    }
    
    func showBillAmountDependentFields() {
        fadeInView(tipContainer, delay: 0)
        fadeInView(separator, delay: 0.5)
        fadeInView(totalContainer, delay: 1)
    }
    
    func fadeInView(view: UIView, delay: Double) {
        UIView.animateWithDuration(0.5, delay: delay, options: .CurveEaseInOut, animations:{
            view.alpha = 1
            }, completion:nil)
    }
    
    func getCurrencyString(val: Double) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter.stringFromNumber(val)!
    }
    
    func animateDisplayFields() {
        UIView.animateWithDuration(1.0, animations: {
            self.billAmountContainer.frame.origin.y = 85
            }, completion: { (value: Bool) in
                self.showBillAmountDependentFields()
        })
    }
}

