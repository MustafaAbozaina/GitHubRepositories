//
//  JSONLoader.swift
//  MindValleyTests
//
//  Created by mustafa salah eldin on 8/28/22.
//

import Foundation

class JSONLoader {
    
    static func loadFromTestingBundle(bundleObject:AnyObject, fileName: String, fileExtension: String) -> Data {
        let data: Data
        let testBundle = Bundle(for: type(of: bundleObject))
        let filePath = testBundle.path(forResource: fileName, ofType: fileExtension)
        do {
            data = try Data(contentsOf: URL(fileURLWithPath: filePath!)) //
        } catch {
            fatalError("Couldn't load \(String(describing: filePath)) from main bundle:\n\(error)")
        }
        return data
    }
 
}
