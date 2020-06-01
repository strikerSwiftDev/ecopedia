//
//  BusSheduleViewController.swift
//  Ecopedia_MVP
//
//  Created by Anatoliy Anatolyev on 09.01.2019.
//  Copyright © 2019 Valeriy. All rights reserved.
//

import UIKit

class BusSheduleViewController: UIViewController {
//
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var destinationLabel: UILabel!
    
    private var delayArr = [10, 15, 20, 30, 45, 60]
    
    private var sheduleArray : [(String, Int)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "busSheduleTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "busSheduleTableViewCellIdentifier")
        
        
        showFromParkShedule()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        
        
    }
    
  
    
    @IBAction func destinationBTNdidTap(_ sender: Any) {
        let alert = UIAlertController(title: "Eдем", message: nil, preferredStyle: .actionSheet)
        let fromParkAction = UIAlertAction(title: "Из парка", style: .default) { (action) in
            self.showFromParkShedule()
        }
        alert.addAction(fromParkAction)
        
        let toParkAction = UIAlertAction(title: "В парк", style: .default) { (action) in
            self.showToParkShedule()
        }
        alert.addAction(toParkAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    private func showToParkShedule() {
        destinationLabel.text = "В Парк"
        sheduleArray = DataBase.shared.getToParkSheduleArray()
        tableView.reloadData()
    }
    
    private func showFromParkShedule() {
        destinationLabel.text = "Из Парка"
        sheduleArray = DataBase.shared.getFromParkSheduleArray()
        tableView.reloadData()
    }
    
    private func setNotificationForTime(stringTime: String) {
        let alert = UIAlertController(title: nil, message: "Хотите установить напоминание?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Нет", style: .default, handler: nil)
        let noAction = UIAlertAction(title: "Да", style: .default)
        { (action) in
            self.prepareRemindSettingFor(timeToRemind: stringTime)
        }
        
        alert.addAction(okAction)
        alert.addAction(noAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func prepareRemindSettingFor(timeToRemind:String) {
        let alert = UIAlertController(title: nil, message: "Напомнить за", preferredStyle: .actionSheet)
        
        for num in delayArr {
            let strNum = String(num)
            let action = UIAlertAction(title: strNum + " минут", style: .default) { (acnion) in
                    self.setReminder(timeToRemind: timeToRemind, delayTime: strNum)
            }
            alert.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func setReminder(timeToRemind:String, delayTime: String) {
//        расчет времени напоминания
        let arr = timeToRemind.components(separatedBy: ":")
        
        let remindTimeHours = Int(arr[0])!
        let remindTimeMinutes = Int(arr[1])!
        let delayIntMinutes = Int(delayTime)!
        
        var targetHours = ""
        var targetMinutes = ""
        
        if remindTimeMinutes > delayIntMinutes {
            targetHours = String(remindTimeHours)
            targetMinutes = String(remindTimeMinutes - delayIntMinutes)
        }else {
            
            targetHours = String(remindTimeHours - 1)
            if remindTimeHours == 0 {
                targetHours = "23"
            }
            targetMinutes = String(remindTimeMinutes - delayIntMinutes + 60)
        }
        
        if targetHours.count == 1 {
            targetHours = "0" + targetHours
        }
        
        if targetMinutes.count == 1 {
            targetMinutes = "0" + targetMinutes
        }
        
        if targetMinutes == "60" {
            targetMinutes = "00"
        }
        
        let alert = UIAlertController(title: "Напоминание", message: "Успешно установлено на " + targetHours + ":" + targetMinutes, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

extension BusSheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setNotificationForTime(stringTime: sheduleArray[indexPath.row].0)
    }
}

extension BusSheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sheduleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "busSheduleTableViewCellIdentifier", for: indexPath) as! busSheduleTableViewCell
        
        cell.label.text = sheduleArray[indexPath.row].0
        
        var busyColor = UIColor.black
        
        switch sheduleArray[indexPath.row].1 {
        case 1:
            busyColor = UIColor.green
        case 2:
            busyColor = UIColor.yellow
        case 3:
            busyColor = UIColor.red
            
        default:
            busyColor = UIColor.gray
        }
        cell.busyView.backgroundColor = busyColor
        return cell
    }
    
    
    
}
