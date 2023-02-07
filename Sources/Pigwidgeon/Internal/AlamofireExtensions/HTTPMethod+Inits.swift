import Alamofire

extension HTTPMethod {
    internal init(_ method: HTTP.Method) {
        self.init(rawValue: method.rawValue)
    }
}
