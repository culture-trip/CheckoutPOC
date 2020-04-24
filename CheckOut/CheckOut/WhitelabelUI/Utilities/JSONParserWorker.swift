//
//  JSONParserWorker.swift
//  CheckOut
//
//  Created by Warrd Adlani on 24/04/2020.
//  Copyright © 2020 Warrd Adlani. All rights reserved.
//

import Foundation

struct InjectedProperties {
    
    var sections: [Row]
}

public class JSONParserWorker {
    
    static func parseJSON(with name: String?, injectableSections: [Rows]?, completion: ((Application?, Error?)->())?) {
       
        guard let name = name, let completion = completion else { return }
        
        ApplicationLoader.parseConfiguration(with: name) { application, error  in
                        
            let newApplication = updateForInjection(with: application, injectableSections: injectableSections)

            DispatchQueue.main.async {
                
                if let error = error {
                    completion(nil, error)
                } else {
                    completion(newApplication ?? application, nil)
                }
            }
        }
    }
    
    private static func updateForInjection(with application: Application?, injectableSections: [Rows]?) -> Application? {
        
        guard let application = application,
              let injectableSections = injectableSections else { return nil }
        
        guard let rows = application.screens?.first?.sections?.first?.rows else { return nil }
        
        // Updating the application (assuming there is only one section for now)
        // Need to inject secion, and row if required
        
        let currentRows = application.screens?.first?.sections?.first?.rows
        var updatedRows: [Row] = [Row].init(currentRows!)
        
        // Look in the current rows for injectable logic in reverse order to prevent breakage
        
        let itemsCount = updatedRows.count > 1 ? updatedRows.count - 1 : updatedRows.count
        
        for i in stride(from: itemsCount, through: 0, by: -1) {
            
            let row = rows[i]
            
            if row.isInjected != nil, row.isInjected == true {
                
                var relatedRows = [Row]()
                
                for injectedRow in injectableSections.first!.rows! {
                    
                    if injectedRow.groupKey == row.groupKey {
                        
                        relatedRows.append(injectedRow)
                    }
                }

                // Either update content here, or replace the object with the injected group
                
                updatedRows.replaceSubrange(i...i, with: relatedRows)
            }
        }
        
        let newRows = application.screens?.first?.sections?.first?.updateValues(rows: updatedRows)
        let newScreen = application.screens?.first?.updateValues(id: nil, title: nil, sections: newRows == nil ? nil : [newRows!], content: nil, type: nil, headerImage: nil, headerText: nil, footerImage: nil, footerText: nil, topContentInset: nil, bottomContentInset: nil, hasSeparators: nil)
        let newApplication = application.updateValues(screens: [newScreen!])
        
        return newApplication
    }
}
