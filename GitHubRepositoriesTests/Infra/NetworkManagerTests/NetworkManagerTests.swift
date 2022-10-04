//
//  NetworkManagerTests.swift
//  MindValleyTests
//
//  Created by mustafa salah eldin on 8/24/22.
//

import XCTest
@testable import GitHubRepositories

let anyUrl = "www.any-url.com/"

class NetworkManagerTests: XCTestCase {
    
    func test_loadData_shouldPassCorrectValuesToUrlSession() {
        let session = URLSessionSpy()
        let parameters = ["key1": "value1", "key2": "value2"]
        let httpMethod: RestMethod = .get
        let headers = ["password": "12345"]
        let sut = NetworkManager(session: session, baseUrl: anyUrl ,headers: headers)
        let testUrl1 = "testUrl1"
        sut.loadData(urlPath: testUrl1, restMethod: httpMethod, parameters: parameters , success: { (mocked: DummyCodable) in
        }, failure: { (error: Error ) in
        })

        XCTAssertEqual(anyUrl+testUrl1, session.url?.path)
        XCTAssertEqual(httpMethod.rawValue, session.restMethod)
        XCTAssertEqual(parameters, session.parameters as! [String: String])
        XCTAssertEqual(headers, session.headers)

        trackForMemoryLeaks(session)
    }
    
    func test_loadData_shouldCallDataTaskAsManyTimesAsLoadDataCalled() {
        let session = URLSessionSpy()
        let sut = NetworkManager(session: session)
        
        sut.loadData(urlPath: anyUrl, restMethod: .get, parameters: nil,success: { (mocked: DummyCodable) in
        }, failure: { (error: Error ) in
        })
        sut.loadData(urlPath: anyUrl, restMethod: .get, parameters: nil,success: { (mocked: DummyCodable) in
        }, failure: { (error: Error ) in
        })
        sut.loadData(urlPath: anyUrl, restMethod: .get, parameters: nil,success: { (mocked: DummyCodable) in
        }, failure: { (error: Error ) in
        })
        let callingTimes = 3
        
        trackForMemoryLeaks(sut)
        
        XCTAssertEqual(callingTimes, session.dataTaskCallsCount)
    }
    
    func test_loadData_shoudFailure_inCaseErrorRetrieved() {
        let (sut, urlSession) = makeSUT()
        urlSession.dataTaskCompletion = (nil, nil , NSError(domain: "", code: 1))
        
        expect(expectedOutput: .failure, sut: sut, expectationDesc: #function)
    }
    /// Failure Status Codes greater than 299 and less than 299
    func test_loadData_shouldFailure_inCaseErrorStatusCode() {
        let (sut, urlSession) = makeSUT()
        urlSession.dataTaskCompletion = (nil, HTTPURLResponse(url: URL(string:"") ?? URL(fileURLWithPath: ""), statusCode: 300, httpVersion: nil, headerFields: nil) , nil)
        expect(expectedOutput: .failure, sut: sut, expectationDesc: #function)
    }
    
    /// Success Status Codes between 200 and 299
    func test_loadData_shouldSuccess_inCaseSuccessStatusCode() {
        let (sut, urlSession) = makeSUT()
        urlSession.dataTaskCompletion = (getValidJsonData()! , HTTPURLResponse(url: URL(string:"") ?? URL(fileURLWithPath: ""), statusCode: 200, httpVersion: nil, headerFields: nil) , nil)
        expect(expectedOutput: .success, sut: sut, expectationDesc: #function)
    }
    
    func test_loadData_shouldFail_inCaseFailedToMapRetrievedData() {
        let (sut, urlSession) = makeSUT()
        urlSession.dataTaskCompletion = (getInvalidData() , HTTPURLResponse(url: URL(string:"") ?? URL(fileURLWithPath: ""), statusCode: 200, httpVersion: nil, headerFields: nil) , nil)
        expect(expectedOutput: .failure, sut: sut, expectationDesc: #function)
    }
    
    func test_LoadDataDecoding_shouldSuccessForCorrectJsonAndDecodableObject() {
        let (sut, urlSession) = makeSUT()
        urlSession.dataTaskCompletion = (FakeJSON.getData(stubbedJson: .general, bundleObject: self), HTTPURLResponse(), nil)
        let result = expectWithResult(expectedOutput: .success, sut: sut, expectationDesc: #function, expectedSuccessType: RootModel<GeneralTestingJsonRoot>.self) as! RootModel<GeneralTestingJsonRoot>

        XCTAssertEqual(result.data.root[0].id, 1)
        XCTAssertEqual(result.data.root[0].title, "course")
        XCTAssertEqual(result.data.root[0].subTitle, "Conscious Parenting")
        XCTAssertEqual(result.data.root[0].url, "https://assets.mindvalley.com")
    }
        
}


struct RootModel<D: Codable>: Codable {
    let data: D
}

// What Network Manager should do?
/* Network manager should use URLSession to request remote APIs.
 
 NetworkManager Data needed:-
 - loadData Method need url, restMethod, Parameters
 
 -> Use Cases:
 1- Should fire failure in case error status code (above 299 or below 200) // done
 2- Should fire failure in case Decodable error // done
 3- Success in case decodable success and resopnse status code 200-299 // done
 4- Sake sure the (parameters, restMethods, URL, headers) passsed to session correctly // done
 5- Should trigger failure in case URLSession triggered Error // done
 
 -> What about the data validation
 -> Url should be passed correctly from network to urlSession // done
 -> Make sure that one loadData call dataTask one time // done
 */
