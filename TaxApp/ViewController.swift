//
//  ViewController.swift
//  TaxApp
//
//  Created by 松尾有紗 on 2021/11/09.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTableView.delegate = self
        itemTableView.dataSource = self
        costsArray.removeAll()
        
        costField.addTarget(self, action: #selector(costFieldDidChange), for: .editingChanged)
        costField.keyboardType = UIKeyboardType.numberPad
    }
    
    var cost:Double = 0
    var addTaxCost:Double = 0
    var costsArray:[Double] = []
    var addTaxCostString:String = ""
    
    @IBOutlet var showLabel: UILabel!
    @IBOutlet var costField: UITextField!
    @IBOutlet var taxController: UISegmentedControl!
    @IBOutlet var itemTableView: UITableView!
    
    @objc func costFieldDidChange(sender: UITextField) {  //値の取得
        
        if costField.text != "" &&  Int(costField.text!) != nil {
            if taxController.selectedSegmentIndex == 0 {
                calc(tax:1.1)
            } else {
                calc(tax: 1.08)
            }
        } else {
            costField.text = ""
            showLabel.text = ""
        }
    }
    
    @IBAction func taxChanger(_ sender: Any) {
        
        if costField.text != "" &&  Int(costField.text!) != nil {
            if taxController.selectedSegmentIndex == 0 {
                //↓で登録しているcalc関数を使っている
                calc(tax: 1.1)
            } else {
                calc(tax: 1.08)
            }        }
        else {
            costField.text = ""
            showLabel.text = ""
        }
        
    }
    
    func calc(tax:Double) {
        
        //    costFieldに追加された数字をcostに代入
        
        cost = Double(costField.text!)!
        //    税金の計算を行う
        addTaxCost = cost * Double(tax)
        print(addTaxCost)
        //    addTaxCostをString型に変更(小数点以下も削除している)
        addTaxCostString = String(format: "%.0f", addTaxCost)
        //    上のラベルに計算結果を表示
        showLabel.text = addTaxCostString
    }
    
    
    @IBAction func addButton(_ sender: Any) {
        if addTaxCost != 0 {
            costsArray.append(contentsOf: [addTaxCost])
            print(costsArray)
            UserDefaults.standard.set(costsArray, forKey: "item")
            
            costField.text = ""
            showLabel.text = ""
            
            self.itemTableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return costsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        cell.textLabel?.text = "\(costsArray[indexPath.row])"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            costsArray.remove(at: indexPath.row)
            
            UserDefaults.standard.set(costsArray, forKey: "item")
            
            itemTableView.reloadData()
        }
    }
    
    
}

