//
//  FakeJSON.swift
//  MindValleyTests
//
//  Created by mustafa salah eldin on 8/28/22.
//

import Foundation

class FakeJSON {
    enum StubbedJSONs: String {
        case general = "GeneralJsonStub"
    }
    
    class func getData(stubbedJson: StubbedJSONs, bundleObject: AnyObject) -> Data {
        return JSONLoader.loadFromTestingBundle(bundleObject: bundleObject, fileName: stubbedJson.rawValue, fileExtension: "json")
    }
    
    class func getJsonData(stubbedJson: StubbedJSONs, bundleObject: AnyObject) -> (Data?, Dictionary<String, Any>?) {
        let jsonData = getData(stubbedJson: stubbedJson, bundleObject: self)
        let json = try? JSONSerialization.jsonObject(with: jsonData, options: [])
        
        return (jsonData, json as? Dictionary<String, Any>)
    }
}
