import Alamofire
import Foundation

/// The request response decoder type, borrowed from Alamofire.
public typealias RequestResponseDecoder = DataDecoder

/// A type that can be used as an HTTP request by Pigwidgeon.
public protocol HTTPRequest {
    /// The request parameters type.
    associatedtype Parameters: Encodable
    /// The request response type.
    associatedtype Response: Decodable
    /// The response decoder type.
    associatedtype ResponseDecoder: RequestResponseDecoder

    /// The request base URL.
    var baseURL: URL { get }
    /// The request path.
    var path: URL { get }
    /// The request method.
    var method: HTTP.Method { get }
    /// The request scheme.
    var scheme: HTTP.Scheme { get }
    /// The request parameters.
    var parameters: Parameters { get }
    /// The request headers.
    var headers: [String: String] { get }
    /// The request content type.
    var contentType: RequestContentType { get }
    /// The response decoder.
    var responseDecoder: ResponseDecoder { get }
}

extension HTTPRequest {
    internal var urlComponents: URLComponents {
        var urlComponents = URLComponents()

        urlComponents.host = baseURL.absoluteString
        urlComponents.path = path.absoluteString
        urlComponents.scheme = scheme.rawValue

        return urlComponents
    }
}
