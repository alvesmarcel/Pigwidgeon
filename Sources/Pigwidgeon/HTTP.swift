internal enum HTTP {
    internal enum Scheme: String {
        case http
        case https
    }

    internal enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
        case head = "HEAD"
        case options = "OPTIONS"
        case query = "QUERY"
        case trace = "TRACE"
        case connect = "CONNECT"
    }
}
