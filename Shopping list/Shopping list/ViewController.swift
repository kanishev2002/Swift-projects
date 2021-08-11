//
//  ViewController.swift
//  Shopping List
//
//  Created by Илья Канищев on 11.08.2021.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetList))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItem", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        
        return cell
    }
    
    @objc func resetList() {
        shoppingList.removeAll()
        tableView.reloadData()
    }
    
    @objc func addItem() {
        let ac = UIAlertController(title: "New item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Submit", style: .default){ [weak self, weak ac] _ in
            guard let text = ac?.textFields?.first?.text else { return }
            
            self?.shoppingList.append(text)
            if let position = self?.shoppingList.count {
                let indexPath = IndexPath(row: position - 1, section: 0)
                self?.tableView.insertRows(at: [indexPath], with: .automatic)
            }
        })
        
        present(ac, animated: true)
    }
}

