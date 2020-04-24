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
        
        guard let rows = application.screens?.first?.sections?.first?.rows else { return nil }
        
        // Example row injected ...
        let newRow = Row(content: "Testing injectable info to see how and where this can be done", height: nil, type: .bodyTextCell, alignment: nil, cellInputType: nil, action: nil, isSecure: nil, isInjected: true)
        
        let addRows = [newRow]
        
        // Updating the application (assuming there is only one section)
        // Need to inject secion, and row if required
        
        let currentRows = application.screens?.first?.sections?.first?.rows
        var updatedRows: [Row] = [Row].init(currentRows!)
        
        // Look in the current rows for injectable logic in reverse order to prevent breakage
        for i in stride(from: updatedRows.count-1, through: 0, by: -1) {
            
            let row = rows[i]
            
            if row.isInjected != nil, row.isInjected == true {

                updatedRows.replaceSubrange(i...i, with: addRows)
            }
        }
        
        let newRows = application.screens?.first?.sections?.first?.updateValues(rows: updatedRows)
        let newScreen = application.screens?.first?.updateValues(id: nil, title: nil, sections: newRows == nil ? nil : [newRows!], content: nil, type: nil, headerImage: nil, headerText: nil, footerImage: nil, footerText: nil, topContentInset: nil, bottomContentInset: nil, hasSeparators: nil)
        let newApplication = application.updateValues(screens: [newScreen!])
        
        return newApplication
    }
}
