//
//  ViewController.swift
//  ToDoEy
//
//  Created by Muhammad Fawwaz Mayda on 04/04/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import UIKit

class Item: Codable {
    var item : String
    var done : Bool
    init(item : String,done : Bool) {
        self.item = item
        self.done = done
    }
}
class TodoeyViewController: UITableViewController {
    var arrayData = [Item]()
    
    var dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(dataFilePath)
        //arrayData.append(Item(item: "Abang", done: true))
        //arrayData.append(Item(item: "Kotak", done: false))
        self.loadData()
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
        cell.textLabel?.text = arrayData[indexPath.row].item
        cell.accessoryType = arrayData[indexPath.row].done ? .checkmark : .none
        return cell
    }
    
    //MARK: TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        arrayData[indexPath.row].done = !arrayData[indexPath.row].done
        self.saveData()
        tableView.reloadData()
    }
    
    //MARK: IBAction and Alert
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        
        var alerTextField = UITextField()
        let alert = UIAlertController(title: "Add a new Item", message: "OH", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (UIAlertAction) in
            //print(alerTextField.text)
            self.arrayData.append(Item(item: alerTextField.text!, done: false))
            self.tableView.reloadData()
            self.saveData()
        }
        
        alert.addTextField { (UITextField) in
            alerTextField = UITextField
        }
        alert.addAction(action)
        present(alert,animated: true)
        
    }
    
    func saveData() {
        do {
            let data = try PropertyListEncoder().encode(self.arrayData)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error Encoding data")
        }
    }
    
    func loadData() {
        do {
            if let data = try? Data(contentsOf: dataFilePath!) {
                self.arrayData = try PropertyListDecoder().decode([Item].self, from: data)
            }
        } catch {
            print("Error Decoding data")
        }
    }
    
}

