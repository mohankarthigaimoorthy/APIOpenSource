//
//  dummyStatus.swift
//  dummyApi
//
//  Created by Mohan K on 18/01/23.
//

import Foundation

struct dummyStatus: Decodable {
    let localized_name: String
    let primary_attr: String
    let attack_type: String
    let legs: Int
    let img: String
    let id: Int
    
}
