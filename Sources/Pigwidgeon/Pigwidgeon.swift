import Alamofire

/// A concrete HTTPClient implementation that sends HTTP requests.
public final class Pigwidgeon: HTTPClient {
    private let session: any HTTPSession

    internal init(session: any HTTPSession) {
        self.session = session
    }

    /// Initialize Pigwidgeon.
    public init() {
        self.session = Session.default
    }

    /// Send an HTTP request.
    /// - Parameter request: The HTTPRequest to be sent.
    /// - Returns: The result returned from the service.
    public func sendRequest<Request, Response>(
        _ request: Request
    ) async throws -> Response where Request: HTTPRequest, Response == Request.Response {
        return try await withCheckedThrowingContinuation { continuation in
            self.session
                .request(
                    request.urlComponents,
                    method: request.method,
                    parameters: request.parameters,
                    headers: request.headers,
                    contentType: request.contentType
                )
                .validate()
                .responseDecodable(of: Response.self, decoder: request.responseDecoder) { response in
                    continuation.resume(with: response.result.mapError { afError in
                        return afError as Error
                    })
                }
        }
    }
}
