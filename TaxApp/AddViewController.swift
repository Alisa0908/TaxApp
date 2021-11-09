//
//  AddViewController.swift
//  TaxApp
//
//  Created by 松尾有紗 on 2021/11/09.
//

import UIKit

class AddViewController: UIViewController {
    
    var resultArray:[Double] = []
    var sum:Double = 0

   
    
    @IBOutlet weak var addLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultArray = UserDefaults.standard.object(forKey: "item") as! [Double]
        print(resultArray)
        sum = resultArray.reduce(0) { (num1:Double, num2:Double) -> Double in
            return num1 + num2
        }

        addLabel.text = String(format: "%.0f", sum)
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
