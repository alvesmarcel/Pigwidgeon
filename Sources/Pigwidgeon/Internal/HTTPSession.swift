import Alamofire

internal protocol HTTPSession {
    associatedtype Request: HTTPDataRequest

    func request<Parameters: Encodable>(
        _ convertible: URLConvertible,
        method: HTTP.Method,
        parameters: Parameters,
        headers: [String: String],
        contentType: RequestContentType
    ) -> Request
}
