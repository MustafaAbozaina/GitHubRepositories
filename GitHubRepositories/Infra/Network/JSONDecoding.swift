//
//  JSONDecoding.swift
//  MindValley
//
//  Created by mustafa salah eldin on 8/29/22.
//

import Foundation

protocol NetworkJSONDecoding {
    func decode<T: Decodable>(responseData: Data) -> T?
}

extension NetworkJSONDecoding {
    func decode<T: Decodable>(responseData: Data) -> T? {
        do {
            let responseModel = try JSONDecoder().decode(T.self, from: responseData)
            return responseModel
        } catch (let error) {
            debugPrint("Error decoding object \(T.self) with error \(error)")
            return nil
        }
    }
}

extension JSONDecoder {
    func decode<T: Decodable>(responseData: Data) -> T? {
        do {
            let responseModel = try JSONDecoder().decode(T.self, from: responseData)
            return responseModel
        } catch (let error) {
            debugPrint("Error decoding object \(T.self) with error \(error)")
            return nil
        }
    }
}
