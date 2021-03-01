//
//  ProfileViewController.swift
//  lab
//
//  Created by Ilya Androsav on 2/14/21.
//

import UIKit
import GoogleMaps
import LanguageManager_iOS

class SettingsViewController: UIViewController {

    static var appFontSize : CGFloat = 18
    static var blackTheme = false
    var picker = UIColorPickerViewController()
    
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var fontSizeSelector: UISlider!
    @IBOutlet weak var changeColorButton: UIButton!
    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var darkModeLabel: UILabel!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var fontSlider: UISlider!
    @IBOutlet weak var languageSelect: UISegmentedControl!
    @IBOutlet weak var fontTextLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if SettingsViewController.blackTheme{
            return .lightContent
        } else {
            return .darkContent
        }
    }
    
    @IBAction func languageChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            LanguageManager.shared.setLanguage(language: .ru)
            { title -> UIViewController in
              return  (self.storyboard?.instantiateViewController(identifier: "MainTapBarNavController"))!
            }
        } else {
            LanguageManager.shared.setLanguage(language: .en)
            { title -> UIViewController in
                return (self.storyboard?.instantiateViewController(identifier: "MainTapBarNavController"))!
            }
        }
    }
    
    func changeFont(){
        UIButton.appearance().titleLabel?.font = UIButton.appearance().titleLabel?.font.withSize(CGFloat(SettingsViewController.appFontSize))
        UILabel.appearance().font = darkModeLabel.font.withSize(CGFloat(SettingsViewController.appFontSize))
        fontSizeLabel.text = "\(Int(SettingsViewController.appFontSize))"
        fontTextLabel.font = fontTextLabel.font.withSize(CGFloat(SettingsViewController.appFontSize))
        fontSizeLabel.font = fontSizeLabel.font.withSize(CGFloat(SettingsViewController.appFontSize))
        darkModeLabel.font = darkModeLabel.font.withSize(CGFloat(SettingsViewController.appFontSize))
        changeColorButton.titleLabel?.font = changeColorButton.titleLabel?.font.withSize(CGFloat(SettingsViewController.appFontSize))
        SettingsViewController.appFontSize = CGFloat(SettingsViewController.appFontSize)
    }
    
    @IBAction func changeColorTap(_ sender: Any) {
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func fontValueChanged(_ sender: UISlider) {
        SettingsViewController.appFontSize = CGFloat(sender.value)
        changeFont()
    }
    
    @IBAction func themeSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            SettingsViewController.blackTheme = true
            self.view.overrideUserInterfaceStyle = .dark
            self.navigationController?.overrideUserInterfaceStyle = .dark
            self.tabBarController?.overrideUserInterfaceStyle = .dark
            fontSizeLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            darkModeLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            setNeedsStatusBarAppearanceUpdate()
            
            UIView.appearance().overrideUserInterfaceStyle = .dark
            UINavigationBar.appearance().overrideUserInterfaceStyle = .dark
            UITabBar.appearance().overrideUserInterfaceStyle = .dark
        } else {
            SettingsViewController.blackTheme = false
            self.view.overrideUserInterfaceStyle = .light
            self.navigationController?.overrideUserInterfaceStyle = .light
            self.tabBarController?.overrideUserInterfaceStyle = .light
            fontSizeLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            darkModeLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            setNeedsStatusBarAppearanceUpdate()
            
            UIView.appearance().overrideUserInterfaceStyle = .light
            UINavigationBar.appearance().overrideUserInterfaceStyle = .light
            UITabBar.appearance().overrideUserInterfaceStyle = .light
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        themeSwitch.isOn = SettingsViewController.blackTheme
        fontSizeLabel.text = "\(Int(SettingsViewController.appFontSize))"
        fontSizeSelector.value = Float(CGFloat(SettingsViewController.appFontSize))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        languageSelect.selectedSegmentIndex = LanguageManager.shared.currentLanguage == .en ? 0 : 1
    }
    
    @IBAction func logout(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginNavController = storyboard.instantiateViewController(identifier: "AuthNavController")

        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SettingsViewController : UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        picker.selectedColor = viewController.selectedColor

        UINavigationBar.appearance().tintColor = viewController.selectedColor
        UIDatePicker.appearance().tintColor = viewController.selectedColor
        UIButton.appearance().tintColor = viewController.selectedColor
        UITabBar.appearance().tintColor = viewController.selectedColor
        UISlider.appearance().tintColor = viewController.selectedColor
        logoutButton.tintColor = viewController.selectedColor
        fontSlider.tintColor = viewController.selectedColor
        changeColorButton.tintColor = viewController.selectedColor
       
        self.navigationController?.navigationBar.tintColor = picker.selectedColor
        self.tabBarController?.tabBar.tintColor = picker.selectedColor
        
    }
}
