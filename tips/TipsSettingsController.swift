import UIKit

class TipsSettingsController: UIViewController {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var defaultTipField: UITextField!
    @IBOutlet weak var darkThemeSwitch: UISwitch!
    
    var delegate: TipSelectedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultTipField.text = String(PreferencesUtil.getPreferredPercentage())
        darkThemeSwitch.setOn(PreferencesUtil.getPreferredTheme(), animated: false)
        saveButton.enabled = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        initializeTheme()
    }
    
    @IBAction func tipDidChange(sender: UITextField) {
        let newTipPercentage = Double(sender.text!)
        
        if newTipPercentage > 100 || newTipPercentage < 0 {
            showError()
            defaultTipField.text = String(PreferencesUtil.getPreferredPercentage())
            return
        }
        
        saveButton.enabled = true
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func saveButtonClick(sender: UIBarButtonItem) {
        let newTipPercentageToStore = Int(defaultTipField.text!)!
        PreferencesUtil.setPreferredPercentage(newTipPercentageToStore)
        
        delegate?.tipSelected(Int(defaultTipField.text!)!)

        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func didSwitchTheme(sender: UISwitch) {
        let isDarkTheme = sender.on
        setTheme(isDarkTheme)
        PreferencesUtil.setPreferredTheme(isDarkTheme)
        initializeTheme()
    }
    
    func showError() {
        let alert = UIAlertController(title: "Error", message: "You must enter a valid value between 0 and 100", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}
