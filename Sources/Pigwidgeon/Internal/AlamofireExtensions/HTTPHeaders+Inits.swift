import Alamofire

extension HTTPHeaders {
    internal init(dictionary: [String: String]) {
        self.init(dictionary.map(HTTPHeader.init))
    }
}
