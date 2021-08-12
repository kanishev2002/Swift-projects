//
//  Petition.swift
//  Whitehouse Peititons
//
//  Created by Илья Канищев on 11.08.2021.
//

import Foundation


struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}


