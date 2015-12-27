import UIKit

class Theme {
    
    let darkThemeBackground = UIColor.purpleColor()
    let darkThemeText = UIColor.whiteColor()
    let lightThemeBackground = UIColor.yellowColor()
    let lightThemeText = UIColor.darkGrayColor()
    
    var isDarkTheme: Bool = false
    
    init() {
        isDarkTheme = PreferencesUtil.getPreferredTheme()
    }
    
    func darkTheme() -> Bool {
        return isDarkTheme
    }
    
    func setDarkTheme(setDark: Bool) {
        isDarkTheme = setDark
    }
    
    func getThemeBackground() -> UIColor {
        return isDarkTheme ? darkThemeBackground : lightThemeBackground
    }
    
    func getThemeText() -> UIColor {
        return isDarkTheme ? darkThemeText : lightThemeText
    }
}