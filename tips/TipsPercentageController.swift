import UIKit

class TipsPercentageController: UIViewController {

    @IBOutlet weak var tensTipField: UITextField!
    @IBOutlet weak var onesTipField: UITextField!
    @IBOutlet weak var tipSelector: UISegmentedControl!
    
    let POSSIBLE_TIPS_PERCENTAGES = [15, 18, 20]
    
    var delegate: TipSelectedDelegate?
    var currentTip: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTipFields()
        setupSelector()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        initializeTheme()
    }
    
    @IBAction func didSelectTensTip(sender: UITextField) {
        tensTipField.text = ""
        onesTipField.text = ""
    }
    
    @IBAction func didEditTensTip(sender: UITextField) {
        onesTipField.becomeFirstResponder()
    }
    
    @IBAction func didSelectOnesTip(sender: AnyObject) {
        onesTipField.text = ""
    }
    
    @IBAction func didEditOnesTip(sender: UITextField) {
        finish(getEnteredTip())
    }
    
    @IBAction func didSelectSuggestedTip(sender: UISegmentedControl) {
        if isCustomTip() {
            tensTipField.becomeFirstResponder()
        } else {
            currentTip = POSSIBLE_TIPS_PERCENTAGES[tipSelector.selectedSegmentIndex]
            setupTipFields()
            finish(currentTip!)
        }
    }
    
    func isCustomTip() -> Bool {
        return tipSelector.selectedSegmentIndex == tipSelector.numberOfSegments - 1
    }
    
    func getEnteredTip() -> Int {
        return Int(tensTipField.text!)! * 10 + Int(onesTipField.text!)!
    }
    
    func finish(percentage: Int) {
        // Delay briefly so it doesn't feel so sudden
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(500 * NSEC_PER_MSEC))
        
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.dismissViewControllerAnimated(true) {
                self.delegate?.tipSelected(percentage)
            }
        }
    }
    
    func setCurrentTip() {
        currentTip = Int(tensTipField.text!)! * 10 + Int(onesTipField.text!)!
    }
    
    func setupTipFields() {
        let onesDigit = currentTip! % 10
        let tensDigit = (currentTip! - onesDigit) / 10
        
        tensTipField.text = String(tensDigit)
        onesTipField.text = String(onesDigit)
    }
    
    func setupSelector() {
        if let index = POSSIBLE_TIPS_PERCENTAGES.indexOf(currentTip!) {
            tipSelector.selectedSegmentIndex = index
        } else {
            tipSelector.selectedSegmentIndex = tipSelector.numberOfSegments - 1
        }
    }
}
