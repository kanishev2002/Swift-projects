//
//  WebsiteTableViewController.swift
//  Simple Browser
//
//  Created by Илья Канищев on 09.08.2021.
//

import UIKit

class WebsiteTableViewController: UITableViewController {
    
    let permittedWebsites = ["apple.com", "google.com"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Pick a website"
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return permittedWebsites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "websiteCell", for: indexPath)
        cell.textLabel?.text = permittedWebsites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "WebView") as? ViewController {
            vc.permittedWebsites = permittedWebsites
            vc.websiteToOpen = permittedWebsites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
