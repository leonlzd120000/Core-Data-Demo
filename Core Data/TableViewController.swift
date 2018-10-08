//
//  TableViewController.swift
//  Core Data
//
//  Created by cmr on 18/10/8.
//  Copyright © 2018年 cmr. All rights reserved.
//

import UIKit

import CoreData

class TableViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var itemArray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as! String)
        
        
     loadItems()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(itemArray.count)
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

//        cell.textLabel?.text = itemArray[indexPath.row].title
        
         cell.textLabel?.text = itemArray[indexPath.row].title

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
       context.delete(itemArray[indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        saveItems()
    }
    

    @IBAction func addButtonPressed(_ sender: AnyObject) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Sth", message: "You need add", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "add"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "ok", style: .default) { (action) in
            
            
            let newItem = Item(context: self.context)
            
            newItem.title = textField.text
            
            newItem.done = false
            
            self.itemArray.append(newItem)
            
            self.saveItems()
           
            print(textField.text!)
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    func saveItems(){
        
        do {
            try context.save()
        } catch {
            print("error saving context\(error) ")
        }

        
    }
    
    func loadItems(){
      
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        do{
            
            try context.fetch(request)
            
        }catch{
            print("error fetching\(error)")
        }
    }
    
}

