//
//  NetworkManager.swift
//  MindValley
//
//  Created by mustafa salah eldin on 8/25/22.
//

import Foundation

class NetworkManager: HTTPClient {
    private var session: URLSession
    private var baseUrl: String
    private var headers: [String: String]?
    private var jsonDecoder: JSONDecoder = JSONDecoder()
    
    init(session: URLSession, baseUrl: String = "https://pastebin.com/raw/", headers: [String: String]? = nil) {
        self.session = session
        self.baseUrl = baseUrl
        self.headers = headers
    }

    func loadData<T: Codable, F: Codable>(urlPath: String, restMethod: RestMethod, parameters: [String: Any]?, success: @escaping (T)-> (), failure: @escaping (NetworkFailure<F>)-> ()) {
        let fullUrl = baseUrl + urlPath
        guard let urlRequest = buildRequest(urlPath: fullUrl, httpMethod: restMethod, parameters: parameters, headers: headers) else {return }
        
        self.session.dataTask(with: urlRequest) { data, response, error in
            if let _ = error {
                failure(.init(failureModel: nil, error: .generalError))
                return
            }
            
            self.handleResult(data: data, response: response as? HTTPURLResponse, success: success, failure: failure)
            
        }.resume()
    }
    
    private func handleResult<T: Codable, F: Codable>(data: Data?, response: HTTPURLResponse?, success: @escaping (T)-> Void, failure: (NetworkFailure<F>)-> Void) {
        var statusCodeFailure = false
        guard let data = data, let response = response else {
            failure(.init(failureModel: nil, error: .responseFailureStatusCode, stausCode: response?.statusCode ))

            return
        }

            if response.statusCode > 299 || response.statusCode < 200  {
                statusCodeFailure = true
        }
        
        if (statusCodeFailure) {
            failure(self.buildFailureModel(data: data, response: response))
        }
        else {
            if let successModel: T = self.decodeDataToModel(data: data) {
                success(successModel)
            } else {
                failure(.init(failureModel: nil, error: .failedToMapDataToModel, stausCode: response.statusCode))
            }
            
        }
    }
    
    private func buildFailureModel<F: Codable>(data: Data, response: URLResponse) -> NetworkFailure<F> {
        let failureResponse: F? = self.decodeDataToModel(data: data)
            var errorType: NetworkError = .responseFailureStatusCode
                if failureResponse == nil {
                    errorType = .failedToMapDataToModel
                }
        let statusCode = (response as? HTTPURLResponse)?.statusCode
             return .init(failureModel: failureResponse, error: errorType, stausCode: statusCode)
    }
        
    private func decodeDataToModel<T: Codable>(data: Data) -> T? {
        let decodedValue: T? = self.jsonDecoder.decode(responseData: data)
        return decodedValue
    }
    
}

// MARK: Helpers
extension NetworkManager {
    private func buildRequest(urlPath: String, httpMethod: RestMethod, parameters: [String: Any]?, headers: [String: String]? = nil) -> URLRequest? {
        guard let url = buildURL(urlPath: urlPath, parameters: parameters) else {return nil}

        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        if let unwrappedHeaders = headers {
            for (key, value) in unwrappedHeaders {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }

        return request
    }
    
    private func buildURL(urlPath: String, parameters: [String: Any]?) -> URL? {
        var urlComponents = URLComponents(string: urlPath)
        urlComponents?.queryItems = buildQueryParameters(parameters: parameters)
        
        return urlComponents?.url
    }
    
    private func buildQueryParameters(parameters: [String: Any]?) -> [URLQueryItem]? {
        guard let parameters = parameters else {
            return nil
        }
        var queryParamters: [URLQueryItem] = []
        for (key, value) in parameters {
            queryParamters.append(URLQueryItem(name: "\(key)", value: "\(value)") )
        }
        
        return queryParamters
    }

}

enum RestMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Int, Error {
    case generalError
    case responseFailureStatusCode
    case failedToMapDataToModel
}

struct NetworkFailure<F: Decodable> {
    var failureModel: F?
    var error: NetworkError
    var stausCode: Int?
}



