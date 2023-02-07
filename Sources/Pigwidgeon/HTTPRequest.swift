import Alamofire
import Foundation

internal protocol HTTPRequest {
    associatedtype Parameters: Encodable
    associatedtype Response: Decodable
    associatedtype ResponseDecoder: DataDecoder

    var baseURL: URL { get }
    var path: URL { get }
    var method: HTTP.Method { get }
    var scheme: HTTP.Scheme { get }
    var parameters: Parameters { get }
    var headers: [String: String] { get }
    var contentType: RequestContentType { get }
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
