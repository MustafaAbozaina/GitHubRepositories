//
//  URL+QueryParams.swift
//  MindValleyTests
//
//  Created by mustafa salah eldin on 8/29/22.
//

import Foundation

extension URL {
    var queryDictionary: [String: Any]? {
        guard let query = self.query else { return nil}

        var queryStrings = [String: String]()
        for pair in query.components(separatedBy: "&") {

            let key = pair.components(separatedBy: "=")[0]

            let value = pair
                .components(separatedBy:"=")[1]
                .replacingOccurrences(of: "+", with: " ")
                .removingPercentEncoding ?? ""

            queryStrings[key] = value
        }
        return queryStrings
    }
}
