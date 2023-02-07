import Alamofire

internal protocol HTTPDataRequest {
    func validate() -> Self

    @discardableResult
    func responseDecodable<T>(
        of type: T.Type,
        decoder: DataDecoder,
        completionHandler: @escaping (AFDataResponse<T>) -> Void
    ) -> Self where T: Decodable
}
