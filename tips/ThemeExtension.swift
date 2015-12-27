import UIKit

extension UIViewController {
    func initializeTheme() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.view.backgroundColor = appDelegate.theme.getThemeBackground()
    }
    
    func setTheme(isDark: Bool) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.theme.setDarkTheme(isDark)
    }
}
