import Alamofire
import XCTest
@testable import Pigwidgeon

final class PigwidgeonTests: XCTestCase {
    private var session: HTTPSessionMock!
    private var sut: Pigwidgeon!
    
    override func setUp() {
        session = HTTPSessionMock()
        sut = Pigwidgeon(session: session)
    }
    
    func testSendRequest_Success() async throws {
        let expectedResponse = TestRequestResponse(field1: "Field 1", field2: 10)
        
        let mockedResponseResult = Result<Decodable, AFError>.success(expectedResponse)
        let mockedDataResponse = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: mockedResponseResult)
        
        session.mockedDataRequest = HTTPDataRequestMock(mockedResponse: mockedDataResponse)
        
        let actualResponse = try await sut.sendRequest(TestRequest())
        
        XCTAssertEqual(actualResponse, expectedResponse)
    }
    
    func testSendRequest_Failure_ServerSideError() async {
        let expectedError = AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 404))
        
        let mockedResponseResult = Result<Decodable, AFError>.failure(expectedError)
        let mockedDataResponse = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: mockedResponseResult)
        
        session.mockedDataRequest = HTTPDataRequestMock(mockedResponse: mockedDataResponse)
        
        do {
            let _ = try await sut.sendRequest(TestRequest())
            XCTFail("Should throw exception")
        } catch {
            XCTAssertEqual(error.asAFError?.responseCode, 404)
        }
    }
}

private struct TestRequestParameters: Codable {
    let paramA: String
    let paramB: Int
}

private struct TestRequestResponse: Codable, Equatable {
    let field1: String
    let field2: Int
}

private struct TestRequest: HTTPRequest {
    typealias Response = TestRequestResponse
    
    let baseURL = URL(string: "baseurl.com")!
    let path = URL(string: "/path")!
    let method = HTTP.Method.get
    let scheme = HTTP.Scheme.https
    let headers: [String: String] = [:]
    let parameters = TestRequestParameters(paramA: "Param A", paramB: 7)
    let contentType: RequestContentType = .json
    let responseDecoder = JSONDecoder()
}
