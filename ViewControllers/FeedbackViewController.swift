//
//  FeedbackViewController.swift
//  Ecopedia_MVP
//
//  Created by Anatoliy Anatolyev on 29.04.2019.
//  Copyright © 2019 Valeriy. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {

    private let sabjArray = ["Предложение","Комплимент", "Жалоба"]
    
    
    @IBOutlet weak var bodyTF: UITextView!
    @IBOutlet weak var themeTF: UITextField!
    @IBOutlet weak var sabjPickerView: UIPickerView!
    
    @IBOutlet weak var stupidBG: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        sabjPickerView.dataSource = self
        sabjPickerView.delegate = self
        
        themeTF.delegate = self
        
        bodyTF.delegate = self
        
        clearFields()
    }
    
    private func clearFields() {
        stupidBG.alpha = 0
        activityIndicator.stopAnimating()
        themeTF.text = ""
        bodyTF.text = ""
    }
    
    private func updateVisuals() {
        
    }
    
    private func proceedSuccessSending() {
        let alert = UIAlertController(title: "Спасибо!", message: "Ваше сообщение отпралено", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default) { (action) in }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func proceedFailedSending() {
        let alert = UIAlertController(title: "Ошибка", message: "Ваше сообщение не отправлено", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default) { (action) in }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func proceedSendigMessage() {
        // обработка введеннго сообщения, формирование УРЛ и отправка
        _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (tmr) in
            self.clearFields()
            self.proceedSuccessSending()
//            Timer.invalidate(timer)
        }
        
        
    }
    
    @IBAction func sendButtonDidTap(_ sender: Any) {
        stupidBG.alpha = 1
        activityIndicator.startAnimating()
        
        proceedSendigMessage()
        
    }
    
}

extension FeedbackViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sabjArray.count
    }
    
}

extension FeedbackViewController: UITextViewDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
//        print("QQQQQQQQ")
    }
}

extension FeedbackViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sabjArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateVisuals()
    }
    
}

extension FeedbackViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)

        return true
    }

}

