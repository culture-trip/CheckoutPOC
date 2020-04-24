//
//  JSONParserWorker.swift
//  CheckOut
//
//  Created by Warrd Adlani on 24/04/2020.
//  Copyright © 2020 Warrd Adlani. All rights reserved.
//

import Foundation

public class JSONParserWorker {
    
    static func parseJSON(with name: String?, completion: ((Application?, Error?)->())?) {
       
        guard let name = name, let completion = completion else { return }
        
        ApplicationLoader.parseConfiguration(with: name) { application, error  in
            
            let fakeData = NSData() // This is where the new data will be injected
            
            let newApplication = updateForInjection(with: application, additionalData: fakeData)

            DispatchQueue.main.async {
                
                if let error = error {
                    completion(nil, error)
                } else {
                    completion(newApplication ?? application, nil)
                }
            }
        }
    }
    
    private static func updateForInjection(with application: Application?, additionalData: Any?) -> Application? {
        
        guard let application = application,
              let additionalData = additionalData else { return nil }
        
        let newRow = Row(content: "Testing injectable info", height: nil, type: .bodyTextCell, alignment: nil, cellInputType: nil, action: nil, isSecure: nil)
        
        let rows = application.screens?.first?.sections?.first?.rows
        var updatedRows: [Row] = [Row].init(rows!)
        updatedRows.insert(newRow, at: 20)
        
        let newRows = application.screens?.first?.sections?.first?.updateValues(rows: updatedRows)
        let newScreen = application.screens?.first?.updateValues(id: nil, title: nil, sections: [newRows!], content: nil, type: nil, headerImage: nil, headerText: nil, footerImage: nil, footerText: nil, topContentInset: nil, bottomContentInset: nil, hasSeparators: nil)
        let newApplication = application.updateValues(screens: [newScreen!])
        
        return newApplication
    }
}
