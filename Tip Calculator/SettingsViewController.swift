//
//  SettingsViewController.swift
//  Tip Calculator
//
//  Created by Abid Amirali on 1/9/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipAmountSegmentedControl: UISegmentedControl!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaultTipIndex = UserDefaults.standard.value(forKey: Constants.UserDefaults.defaultTipIndex) as? Int ?? 0
        self.defaultTipAmountSegmentedControl.selectedSegmentIndex = defaultTipIndex
        
        let darkModeEnabled = UserDefaults.standard.value(forKey: Constants.UserDefaults.darkModeEnabled) as? Bool ?? false
        
        if darkModeEnabled {
            self.darkModeSwitch.setOn(true, animated: true)
            setupDarkAppearance()
        } else {
            self.darkModeSwitch.setOn(false, animated: true)
            setupLightAppearance()
        }
        
        
    }

    
    func setupLightAppearance() {
        self.defaultTipAmountSegmentedControl.tintColor = .blue
        self.view.backgroundColor = UIColor(named: Constants.Appearance.Light.viewBackgroundColor)
        self.navigationController?.navigationBar.tintColor = nil
    }

    
    func setupDarkAppearance() {
        self.defaultTipAmountSegmentedControl.tintColor = .darkText
        self.view.backgroundColor = .darkGray
        self.navigationController?.navigationBar.tintColor = .darkGray
    }
    
    @IBAction func didSelectDefaultTipAmount(_ sender: UISegmentedControl) {
        let selectedAmount = sender.selectedSegmentIndex
        UserDefaults.standard.set(selectedAmount, forKey: Constants.UserDefaults.defaultTipIndex)
    }
    
    @IBAction func darkModeToggled(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: Constants.UserDefaults.darkModeEnabled)
        if sender.isOn {
            setupDarkAppearance()
        } else {
            setupLightAppearance()
        }
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
