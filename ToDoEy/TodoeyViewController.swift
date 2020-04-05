//
//  ViewController.swift
//  ToDoEy
//
//  Created by Muhammad Fawwaz Mayda on 04/04/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class TodoeyViewController: UITableViewController {
    let arrayData = ["Abang","Bola","Kotak"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK: TableView DataSoource
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier, for: indexPath)
        cell.textLabel?.text = arrayData[indexPath.row]
        return cell
    }
    
    //MARK: TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let check = UITableViewCell.AccessoryType.checkmark
        let none = UITableViewCell.AccessoryType.none
        if tableView.cellForRow(at: indexPath)?.accessoryType==check {
            tableView.cellForRow(at: indexPath)?.accessoryType=none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType=check
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: IBAction
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        
        var alerTextField = UITextField()
        let alert = UIAlertController(title: "Add a new Item", message: "OH", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (UIAlertAction) in
            print(alerTextField.text)
        }
        
        alert.addTextField { (UITextField) in
            alerTextField = UITextField
        }
        alert.addAction(action)
        present(alert,animated: true)
        
    }
    
}

