import Foundation
import APIKit
import Himotoki

struct QiitaTodayItemRequest: QiitaRequest {
    
    let tags: [String]
    let day: String
    let accessToken: String
    
    typealias Response = [QiitaItem]
    
    var method: HTTPMethod{
        return .get
    }
    
    var path: String{
        return "/items"
    }
    
    var parameters: Any? {
        return ["query": quary()]
    }
    
    var headerFields: [String: String] {
        return ["Authorization": "Bearer \(accessToken)"]
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try decodeArray(object) as Response
    }
    
    private func quary() -> String {
        let tagQuary = tags.map{"tag:\($0) created:>\(day)"}.joined(separator: " OR ")
        return tagQuary
    }
}
