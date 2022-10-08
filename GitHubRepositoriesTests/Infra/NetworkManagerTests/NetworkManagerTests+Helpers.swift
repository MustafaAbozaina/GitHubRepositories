//
//  NetworkManagerTests+Helpers.swift
//  MindValleyTests
//
//  Created by mustafa salah eldin on 8/29/22.
//

import XCTest
@testable import GitHubRepositories

// MARK: Helpers
extension NetworkManagerTests {
    func makeSUT() -> (NetworkManager, FakeURLSession) {
        let urlSession = FakeURLSession()
        let sut = NetworkManager(session: urlSession)
        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(urlSession)
        
        return (sut, urlSession)
    }
    
    func getValidJsonData() -> Data? {
        let dummyJson = ["key": "value"]
        let jsonEncoder = JSONEncoder()
        if let data = try? jsonEncoder.encode(dummyJson) {
            return data
        } else {
            return nil
        }
    }
    
    func getInvalidData() -> Data {
        return Data()
    }
    
    func expect(expectedOutput: LoadDataOutputExpection, sut: NetworkManager, expectationDesc: String, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: expectationDesc)
        sut.loadData(urlPath: anyUrl, restMethod: .get, parameters: nil, success: { (mocked: DummyCodable) in
            if expectedOutput == .success {
                exp.fulfill()
            } else {
                XCTFail(file: file, line: line)
            }
            
        }, failure: { (networkFailure: NetworkFailure<DummyNetworkFailureModel> ) in
            if expectedOutput == .success {
                XCTFail(file: file, line: line)
            } else {
                exp.fulfill()
            }
        })
        waitForExpectations(timeout: 2, handler: nil)

    }
    
    func expectWithResult<T: Codable>(expectedOutput: LoadDataOutputExpection, sut: NetworkManager, expectationDesc: String, expectedSuccessType: T.Type,  file: StaticString = #filePath, line: UInt = #line) -> Any? {
        
        let exp = expectation(description: expectationDesc)
        var result: Any? = nil
        sut.loadData(urlPath: anyUrl, restMethod: .get, parameters: nil, success: { (mocked: T) in
            if expectedOutput == .success {
                exp.fulfill()
            } else {
                XCTFail(file: file, line: line)
            }
            result = mocked
        }, failure: { (networkFailure: NetworkFailure<DummyNetworkFailureModel>) in
            if expectedOutput == .success {
                XCTFail(file: file, line: line)
            } else {
                exp.fulfill()
                XCTAssertNotNil(networkFailure.error)
            }
            result = networkFailure.error
        })
        waitForExpectations(timeout: 2, handler: nil)
        return result
    }
    
    enum LoadDataOutputExpection {
        case success
        case failure
    }
}

struct GeneralTestingJsonRoot: Codable  {
    var root: [GeneralTestingJson]
}

struct GeneralTestingJson: Codable {
    var id: Int?
    var title: String?
    var subTitle: String?
    var url: String?
}

struct DummyNetworkFailureModel: Codable {
    
}
