//
//  EditViewController.swift
//  calender
//
//  Created by 豊田莉彩 on 2020/02/06.
//  Copyright © 2020 豊田莉彩. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UITextFieldDelegate {
    var selectIndex: Int!
    
    let saveData: UserDefaults = UserDefaults.standard
    var familyNameArray = [[String: Any]]()
    
    @IBOutlet var textfield: UITextField!
    
    @IBAction func edituser () {
        
        if textfield.text! == "" {
            return
        }
        let alert = UIAlertController(title:"完了", message: "ユーザー名を変更します", preferredStyle: UIAlertController.Style.alert)
        
        let action1 = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            self.familyNameArray[self.selectIndex]["name"] = self.textfield.text
            self.saveData.set(self.familyNameArray, forKey: "family")
            self.navigationController?.popViewController(animated: true)
        })
        let cancel = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) in
            print("キャンセル")
        })
        alert.addAction(action1)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func deleteuser () {
        
        let alert = UIAlertController(title:"確認", message: "本当に削除しますか？(データは戻りません)", preferredStyle: UIAlertController.Style.alert)
        
        let action1 = UIAlertAction(title: "削除", style: UIAlertAction.Style.destructive, handler: {
            (action: UIAlertAction!) in
            self.familyNameArray.remove(at: self.selectIndex)
            self.saveData.set(self.familyNameArray, forKey: "family")
            self.navigationController?.popViewController(animated: true)
        })
        let cancel = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) in
            print("キャンセル")
        })
        alert.addAction(action1)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
        //familyNameArrayから、selectIndex番目のuserデータを削除したい
        
    }
    
    override func viewDidLoad() {
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle =  .light
        } else {
        }
        super.viewDidLoad()
        
        textfield.delegate = self
        
        if let data = saveData.object(forKey: "family") {
            familyNameArray = data  as! [[String: Any]]
            
            
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        let user = familyNameArray[selectIndex]
        textfield.text = user["name"] as? String
        // Do any additional setup after loading the view.
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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



