import Alamofire

extension DataRequest: HTTPDataRequest {
    @discardableResult
    internal func responseDecodable<T>(
        of type: T.Type,
        decoder: DataDecoder,
        completionHandler: @escaping (AFDataResponse<T>) -> Void
    ) -> Self where T: Decodable {
        return self.responseDecodable(
            of: type,
            queue: .main,
            dataPreprocessor: DecodableResponseSerializer<T>.defaultDataPreprocessor,
            decoder: decoder,
            completionHandler: completionHandler
        )
    }
}
