//
//  UserViewController.swift
//  calender
//
//  Created by 豊田莉彩 on 2019/11/28.
//  Copyright © 2019 豊田莉彩. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var titleTextField: UITextField!
    
    var saveData:UserDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle =  .light
        } else {
        }
        super.viewDidLoad()
        
        
        titleTextField.delegate = self
        
     
        }
        
        // Do any additional setup after loading the view.
    
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func saveMemo() {
        if titleTextField.text! == "" {
            return
        }
        var familyNameArray =  [[String: Any]]()
        if let data = saveData.object(forKey: "family") {
            familyNameArray = data  as! [[String: Any]]
        }
        
        var nextid: Int!
        if saveData.object(forKey: "nextid") != nil {
            nextid = saveData.object(forKey: "nextid") as? Int
        } else {
            nextid = 1
        }
        
        
//        let newFamily = titleTextField!.text
        let newFamily = ["name" : titleTextField!.text , "id" : nextid] as [String : Any]
        familyNameArray.append(newFamily)
        
        nextid = nextid + 1
        saveData.set(nextid, forKey: "nextid")
        
        saveData.set(familyNameArray, forKey: "family")
        
        let alert: UIAlertController = UIAlertController(title: "SAVE", message: "ユーザーを登録しました。",preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: "OK",
                
                style: .default,
                handler: { action in
                    
                    self.navigationController?.popViewController(animated: true)
                    print("OKボタンが押されました！")
            }
            )
        )
        present(alert, animated: true, completion: nil)
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

