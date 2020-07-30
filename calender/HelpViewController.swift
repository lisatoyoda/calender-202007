//
//  HelpViewController.swift
//  calender
//
//  Created by 豊田莉彩 on 2020/06/25.
//  Copyright © 2020 豊田莉彩. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var number: Int = 0
    var imageArrey: [String] = ["チュートリアル.001.png", "チュートリアル.002.png",  "チュートリアル.003.png", "チュートリアル.004.png", "チュートリアル.005.png", "チュートリアル.006.png", "チュートリアル.007.png"]
    
    override func viewDidLoad() {
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle =  .light
        } else {
        }
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    /*
    @IBAction func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        print ("left")
    }
    
    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer) {
    print ("right")
    }*/
    
    @IBAction func right() {
        number += 1
        if number == 6 {
           // number = 0
            self.dismiss(animated: true, completion: nil)
        }
        print (number)
        imageView.image = UIImage(named: imageArrey[number])
    }
        
        
    @IBAction func left() {
        print ("left")
        number -= 1
        if number < 0 {
            number = 6
        }
        print (number)
        imageView.image = UIImage(named: imageArrey[number])
        
        
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
