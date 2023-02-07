import Alamofire
@testable import Pigwidgeon

final class HTTPSessionMock: HTTPSession {
    var mockedDataRequest: HTTPDataRequestMock!
    
    func request<Parameters>(
        _ convertible: URLConvertible,
        method: HTTP.Method,
        parameters: Parameters,
        headers: [String: String],
        contentType: RequestContentType
    ) -> HTTPDataRequestMock where Parameters: Encodable {
        return mockedDataRequest
    }
}
