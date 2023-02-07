import Alamofire

extension Session: HTTPSession {
    internal func request<Parameters>(
        _ convertible: URLConvertible,
        method: HTTP.Method,
        parameters: Parameters,
        headers: [String: String],
        contentType: RequestContentType
    ) -> DataRequest where Parameters: Encodable {
        let encoder: ParameterEncoder

        switch contentType {
        case .json:
            encoder = JSONParameterEncoder.default
        case .urlEncoded:
            encoder = URLEncodedFormParameterEncoder.default
        }

        return request(
            convertible,
            method: HTTPMethod(method),
            parameters: parameters,
            encoder: encoder,
            headers: HTTPHeaders(dictionary: headers),
            interceptor: nil,
            requestModifier: nil
        )
    }
}
