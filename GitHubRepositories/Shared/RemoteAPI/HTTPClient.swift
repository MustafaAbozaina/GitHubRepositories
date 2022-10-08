//
//  HTTPClient.swift
//  MindValley
//
//  Created by mustafa salah eldin on 10/1/22.
//

import Foundation

protocol HTTPClient {
    func loadData<T: Codable, F: Codable>(urlPath: String, restMethod: RestMethod, parameters: [String: Any]?, success: @escaping (T)-> (), failure: @escaping (NetworkFailure<F>)-> ())
}
