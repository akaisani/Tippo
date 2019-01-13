//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Abid Amirali on 1/8/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import UIKit

class TipCalculatorViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var tipAmountSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var calculateTipButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tipInputView: UIView!
    @IBOutlet weak var tipOutputView: UIView!
    
    //MAKR:- Properties
    var tipPercent: Double? {
        switch tipAmountSegmentedControl.selectedSegmentIndex {
        case 0:
            return 0.15
        case 1:
            return 0.2
        case 2:
            return 0.25
        default:
            return nil
        }
    }
    
    var impactFeedbackGenerator: UIImpactFeedbackGenerator!

    //MARK:- View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        self.amountTextField.delegate = self
        
        let tapGestureRecongnizer:UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGestureRecongnizer)
        self.setupView()
    }
    
    func setupView() {
        //setting up views
        self.tipInputView.layer.cornerRadius = 10
        self.tipOutputView.layer.cornerRadius = 10

        // settings up buttons
        self.calculateTipButton.layer.borderWidth = 3.0
        self.calculateTipButton.layer.borderColor = UIColor.white.cgColor
        self.calculateTipButton.layer.cornerRadius = 30.0
        self.clearButton.layer.borderWidth = 3.0
        self.clearButton.layer.borderColor = UIColor.white.cgColor
        self.clearButton.layer.cornerRadius = 30.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.amountTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupLightAppearance()
        self.navigationController?.isNavigationBarHidden = true
        let defaultTipIndex = UserDefaults.standard.value(forKey: Constants.UserDefaults.defaultTipIndex) as? Int ?? 0
        self.tipAmountSegmentedControl.selectedSegmentIndex = defaultTipIndex
        
        let darkModeEnabled = UserDefaults.standard.value(forKey: Constants.UserDefaults.darkModeEnabled) as? Bool ?? false
        
        if darkModeEnabled {
            setupDarkAppearance()
        } else {
            setupLightAppearance()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    // MARK:- IBActions
    @IBAction func calculateTipButtonPressed(_ sender: UIButton) {
        self.impactFeedbackGenerator.impactOccurred()
        calculateTipAmount()
    }
    
    @IBAction func clearFieldsPressed(_ sender: UIButton) {
        self.impactFeedbackGenerator.impactOccurred()
        clearData()
    }
    @IBAction func didChangeTipAmount(_ sender: UISegmentedControl) {
        self.calculateTipAmount()
    }
    
    
    //MARK:- Helper Functions
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        if self.amountTextField.isFirstResponder {
            self.amountTextField.resignFirstResponder()
        }
    }
    
    func clearData() {
        self.amountTextField.text = ""
        self.tipAmountLabel.text = "$0.00"
        self.totalAmountLabel.text = "$0.00"
        guard let defaultTipIndex = UserDefaults.standard.value(forKey: Constants.UserDefaults.defaultTipIndex) as? Int else {return}
        self.tipAmountSegmentedControl.selectedSegmentIndex = defaultTipIndex
    }
    
    func calculateTipAmount() {
        if self.amountTextField.isFirstResponder {
            self.amountTextField.resignFirstResponder()
        }
        
        guard let valueString = self.amountTextField.text else {return}
        guard let amount = Double(valueString) else {return}
        guard let tipPercent = tipPercent else {return}
        
        let tipAmount = tipPercent * amount
        let totalAmount = tipAmount + amount
        
        self.tipAmountLabel.text = String(format: "%.2f", tipAmount)
        self.totalAmountLabel.text = String(format: "%.2f", totalAmount)
        
    }
    
    func setupLightAppearance() {
        self.view.backgroundColor = UIColor(named: Constants.Appearance.Light.viewBackgroundColor)
        self.headerView.backgroundColor = UIColor.init(named: Constants.Appearance.Light.headerColor)
        self.tipOutputView.backgroundColor = UIColor.init(named: Constants.Appearance.Light.headerColor)
        self.tipInputView.backgroundColor = UIColor.init(named: Constants.Appearance.Light.inputViewColor)
        self.calculateTipButton.backgroundColor = UIColor.init(named: Constants.Appearance.Light.inputViewColor)
        self.clearButton.backgroundColor = UIColor.init(named: Constants.Appearance.Light.headerColor)
        self.tipAmountSegmentedControl.tintColor = UIColor.blue
        self.amountTextField.keyboardAppearance = .default
        self.navigationController?.navigationBar.tintColor = nil

    }
    
    func setupDarkAppearance() {
        self.view.backgroundColor = .darkGray
        self.headerView.backgroundColor = .lightGray
        self.tipOutputView.backgroundColor = .lightGray
        self.tipInputView.backgroundColor = UIColor.init(named: Constants.Appearance.Dark.inputViewColor)
        self.calculateTipButton.backgroundColor = UIColor.init(named: Constants.Appearance.Dark.inputViewColor)
        self.clearButton.backgroundColor = .lightGray
        self.tipAmountSegmentedControl.tintColor = UIColor.darkText
        self.amountTextField.keyboardAppearance = .dark
        self.navigationController?.navigationBar.tintColor = .darkGray
    }
    
}
//MARK:- Extensions
extension TipCalculatorViewController: UITextFieldDelegate {
    
}

