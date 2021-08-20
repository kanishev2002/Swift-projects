//
//  Person.swift
//  Names to Faces
//
//  Created by Илья Канищев on 19.08.2021.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
