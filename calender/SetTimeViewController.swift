//
//  CalendarViewController.swift
//  calender
//
//  Created by 豊田莉彩 on 2019/06/29.
//  Copyright © 2019 豊田莉彩. All rights reserved.
//

import UIKit

class SetTimeViewController: UIViewController {
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var label: UILabel!
    @IBOutlet var memberLabel: UILabel!
    @IBOutlet var dinnerLabel: UILabel!
    
    var saveDate:UserDefaults = UserDefaults.standard
    var date: String!
    var member: [String: Any]!
    var dinner: String!
    
    override func viewDidLoad() {
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle =  .light
        } else {
        }
        super.viewDidLoad()
        
        createDatePicker()
        self.navigationItem.title = date
        let name = member["name"] as! String
        memberLabel.text = name + "の帰宅時間"
        dinner = "有"
        label.text = "未定"
    }
    @IBAction func selectSegment(_ sender: Any) {
        
        switch (sender as AnyObject).selectedSegmentIndex {
        case 0:
            dinner = "有"
            print(dinner)
        case 1:
            dinner = "無"
            print(dinner)
        case 2:
            dinner = "未定"
            print(dinner)
            
        default:
            print("エラ-")
        }
    }
    
    //datepickerが選択されたらtextfieldに表示
    @IBAction func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "HH:mm"
        let str: String = dateFormatter.string(from: sender.date) //選択された時間（String型）
        print(str)
        label.text = dateFormatter.string(from: sender.date)
        
    }
    
    
    func createDatePicker(){
        // DatePickerModeをDate(日付)に設定
        datePicker.datePickerMode = .time
        // DatePickerを日本語化
        datePicker.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        
    }
    
    @IBAction func save() {
        let id = member["id"] as! Int
        saveDate.set(label.text, forKey: date+"id"+String(id))
        saveDate.set(dinner, forKey: date + "dinner" + "id" + String(id))
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func undecided() {
        label.text = "未定"
        
    }
    
    
    @IBAction func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func  delete() {
        let alert: UIAlertController = UIAlertController(title: "DELETE", message: "削除してもいいですか",preferredStyle: .alert)
        
    //Deleteのaction
        let deleteAction:UIAlertAction =
            UIAlertAction(title: "Delete",
                  style: .destructive,
                  handler:{
                    (action:UIAlertAction!) -> Void in
                    // 処理
                    let id = self.member["id"] as! Int
                    self.saveDate.set("", forKey: self.date+"id"+String(id))
                    self.saveDate.set("", forKey: self.date + "dinner" + "id" + String(id))
                    //元の画面に戻る
                    self.navigationController?
                        .popViewController(animated: true)
                    print("deleteしました。")
        })
        
        
        // Cancel のaction
        let cancelAction:UIAlertAction =
                    UIAlertAction(title: "Cancel",
                          style: .cancel,
                          handler:{
                            (action:UIAlertAction!) -> Void in
                            // 処理
                            print("cancelしました！")
                    })
    
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}



