import Alamofire

internal protocol HTTPClient {
    func sendRequest<Request, Response>(
        _ request: Request
    ) async throws -> Response where Request: HTTPRequest, Response == Request.Response
}
