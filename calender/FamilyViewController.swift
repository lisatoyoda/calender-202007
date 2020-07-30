//
//  ViewController  2.swift
//  calender
//
//  Created by 豊田莉彩 on 2019/07/15.
//  Copyright © 2019 豊田莉彩. All rights reserved.
//

import UIKit

class FamilyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  familyNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let user = familyNameArray[indexPath.row] as! [String: Any]
        cell?.textLabel?.text = user["name"] as? String
        
        
        return cell!
    }
    
    let saveData: UserDefaults = UserDefaults.standard
    
    @IBOutlet var table:UITableView!
    var selectIndex: Int!
    var familyNameArray = [[String: Any]]()
    
    override func viewWillAppear(_ animated: Bool) {
        if let data = saveData.object(forKey: "family") {
            familyNameArray = data  as! [[String: Any]]
        }
        table.reloadData()
    }
    
    override func viewDidLoad() {
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle =  .light
        } else {
        }
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        table.dataSource = self
        
        table.delegate = self
        
    }
  
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toEdit" {
//            let nextVC = segue.destination as! ViewController
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = familyNameArray[indexPath.row]
        print("\(String(describing: user["name"]))が選ばれました！")
        selectIndex = indexPath.row
        performSegue(withIdentifier: "toEdit", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEdit" {
            let nextVC = segue.destination as! EditViewController
            nextVC.selectIndex = self.selectIndex
            
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
