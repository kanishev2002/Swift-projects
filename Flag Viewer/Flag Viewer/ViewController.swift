//
//  ViewController.swift
//  Flag Viewer
//
//  Created by Илья Канищев on 08.08.2021.
//

import UIKit

class ViewController: UITableViewController {
    
    let countries = [
        "estonia", "france", "germany",
        "ireland", "italy", "monaco",
        "nigeria", "poland", "russia",
        "spain", "uk", "us"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Flag Viewer"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlagCell", for: indexPath)
        let country = countries[indexPath.row]
        cell.imageView?.image = UIImage(named: country)
        cell.imageView?.layer.borderWidth = 1
        cell.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        cell.imageView?.layer.cornerRadius = 8
        let label = getCountryName(from: country)
        cell.textLabel?.text = label
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailView") as?  DetailViewController {
            vc.country = getCountryName(from: countries[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func getCountryName(from name: String) -> String {
        if name != "uk" && name != "us"{
            return name.capitalized
        }
        else {
            return name.uppercased()
        }
    }
}

