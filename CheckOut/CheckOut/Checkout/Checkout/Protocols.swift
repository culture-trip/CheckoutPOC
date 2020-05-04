//
//  Protocols.swift
//  CheckOut
//
//  Created by Warrd Adlani on 01/05/2020.
//  Copyright © 2020 Warrd Adlani. All rights reserved.
//

import UIKit

public protocol CheckCoordinating: Coordinator {
        
    init(window: UIWindow?)
    func start()
    func openSuccesfulPaymentScreen()
}

