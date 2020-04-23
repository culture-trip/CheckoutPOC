//
//  Action.swift
//  CheckOut
//
//  Created by Warrd Adlani on 22/04/2020.
//  Copyright © 2020 Warrd Adlani. All rights reserved.
//

import Foundation

protocol Actionable {
    
    var action: Action? { get }
}

enum ActionType: String, Decodable {
    
    case generic
    case submit
    case save
    case exit
}

struct Action: Decodable {
    
    let type: ActionType
}
