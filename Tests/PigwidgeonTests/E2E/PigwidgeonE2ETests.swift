import Alamofire
import XCTest
@testable import Pigwidgeon

final class PigwidgeonE2ETests: XCTestCase {
    private let session = Session.default
    private var sut: Pigwidgeon!
    
    override func setUp() {
        sut = Pigwidgeon(session: session)
    }
    
    func testSendRequest_Success_MSFT() async throws {
        let yahooFinanceRequest = YahooFinanceRequest(ticker: "MSFT")
        
        let actualResponse = try await sut.sendRequest(yahooFinanceRequest)
        
        XCTAssertEqual(actualResponse.chart.result.first!.meta.currency, "USD")
        XCTAssertEqual(actualResponse.chart.result.first!.meta.symbol, "MSFT")
    }
    
    func testSendRequest_Success_AAPL() async throws {
        let yahooFinanceRequest = YahooFinanceRequest(ticker: "AAPL")
        
        let actualResponse = try await sut.sendRequest(yahooFinanceRequest)
        
        XCTAssertEqual(actualResponse.chart.result.first!.meta.currency, "USD")
        XCTAssertEqual(actualResponse.chart.result.first!.meta.symbol, "AAPL")
    }
}

private struct TestRequestParameters: Encodable {
    let region = "US"
    let lang = "en-US"
    let includePrePost = false
    let interval = "2m"
    let useYfid = true
    let range = "1d"
    let corsDomain = "finance.yahoo.com"
}

private struct YahooFinanceResponse: Codable {
    let chart: YahooFinanceChart
}

private struct YahooFinanceChart: Codable {
    let result: [YahooFinanceResult]
}

private struct YahooFinanceResult: Codable {
    let meta: YahooFinanceMetadata
}

private struct YahooFinanceMetadata: Codable {
    let currency: String
    let symbol: String
}

private struct YahooFinanceRequest: HTTPRequest {
    typealias Response = YahooFinanceResponse
    
    init(ticker: String) {
        path = URL(string: "/v8/finance/chart/\(ticker)")!
    }
    
    let baseURL = URL(string: "query1.finance.yahoo.com")!
    let path: URL
    let method = HTTP.Method.get
    let scheme = HTTP.Scheme.https
    let headers: [String: String] = ["accept-language": "en-US,en;q=0.9,pt-BR;q=0.8,pt;q=0.7"]
    let parameters = TestRequestParameters()
    let contentType: RequestContentType = .urlEncoded
    let responseDecoder = JSONDecoder()
}
