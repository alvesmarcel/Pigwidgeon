import Alamofire
import Foundation
@testable import Pigwidgeon

struct HTTPDataRequestMock: HTTPDataRequest {
    let id = UUID()
    let mockedResponse: AFDataResponse<Decodable>
    
    func validate() -> HTTPDataRequestMock {
        return self
    }
    
    func responseDecodable<T>(
        of type: T.Type,
        decoder: DataDecoder,
        completionHandler: @escaping (AFDataResponse<T>) -> Void
    ) -> HTTPDataRequestMock where T: Decodable {
        let mappedResponse = mockedResponse.map { decodable in
            return decodable as! T
        }
        completionHandler(mappedResponse)
        return self
    }
}
