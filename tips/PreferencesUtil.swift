import Foundation

let PREFERRED_PERCENTAGE = "preferred_percentage";
let PREFERRED_THEME = "preferred_theme"
let DEFAULT_TIP = 18

class PreferencesUtil {
    
    class func getPreferredPercentage() -> Int {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let currentValue = defaults.objectForKey(PREFERRED_PERCENTAGE) {
            return currentValue as! Int
        } else {
            return DEFAULT_TIP
        }
    }
    
    class func setPreferredPercentage(preferredPercentage: Int) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(preferredPercentage, forKey: PREFERRED_PERCENTAGE)
        defaults.synchronize()
    }
    
    class func getPreferredTheme() -> Bool {
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.boolForKey(PREFERRED_THEME)
    }
    
    class func setPreferredTheme(isDark: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(isDark, forKey: PREFERRED_THEME)
        defaults.synchronize()
    }
}