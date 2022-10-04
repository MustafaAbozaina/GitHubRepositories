//
//  NetworkManagerTests+Helpers.swift
//  MindValleyTests
//
//  Created by mustafa salah eldin on 8/27/22.
//

import Foundation
@testable import GitHubRepositories


// MARK: URLSessions
class FakeURLSession: URLSession {
    var dataTaskCompletion:  (Data?, URLResponse?, Error?)
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(dataTaskCompletion.0, dataTaskCompletion.1, dataTaskCompletion.2)
        
        return MockURLSessionDataTask()
    }
}

class URLSessionSpy: URLSession {
    var url: URL?
    var parameters: [String: Any]?
    var restMethod: String?
    var headers: [String: String]?
    var dataTaskCallsCount = 0
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        dataTaskCallsCount += 1
        self.url = request.url
        self.restMethod = request.httpMethod
        self.parameters = self.url?.queryDictionary
        self.headers = request.allHTTPHeaderFields
        return MockURLSessionDataTask()
    }
    
}

class MockURLSessionDataTask: URLSessionDataTask {
    override func resume() {}
}

class DummyCodable: Codable {}

