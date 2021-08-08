//
//  DetailViewController.swift
//  Flag Viewer
//
//  Created by Илья Канищев on 08.08.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var country: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        if let countryName = country {
            imageView.image = UIImage(named: countryName.lowercased())
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareFlag))
    }
    
    @objc func shareFlag() {
        if let flag = imageView.image {
            let flagImage = flag.jpegData(compressionQuality: 0.8)!
            let vc = UIActivityViewController(activityItems: [flagImage, country!], applicationActivities: [])
            vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            present(vc, animated: true)
        }
    }
}
