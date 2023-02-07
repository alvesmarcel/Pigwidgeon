/// A namespace that contains Scheme and Method types for HTTP requests.
public enum HTTP {
    /// The scheme component of the URL. The possible values are `http` or `https`.
    public enum Scheme: String {
        case http
        case https
    }

    /// The HTTP request method, e.g., `GET`, `PUT`, `POST`. Raw values are uppercased.
    public enum Method: String {
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
