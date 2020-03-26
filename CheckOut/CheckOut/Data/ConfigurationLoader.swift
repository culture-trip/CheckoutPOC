//
//  ConfigurationLoader.swift
//  CheckOut
//
//  Created by Warrd Adlani on 26/03/2020.
//  Copyright © 2020 Warrd Adlani. All rights reserved.
//

import Foundation

public final class ConfigurationLoader {
    
    class func parseConfiguration(with name: String, completion: @escaping (Configuration?)->()) {
        
        let queue = DispatchQueue(label: "configuration-loader-queue")
        var config: Configuration? = nil
        
        queue.async {
            if let path = Bundle.main.path(forResource: name, ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    
                    print(jsonResult)
                    
                    config = try JSONDecoder().decode(Configuration.self, from: data)
                    completion(config)
                    print(config ?? "failed")
                } catch {
                    completion(nil)
                }
            }
        }
    }
}
