import Foundation
import APIKit

protocol QiitaRequest: Request{}

extension QiitaRequest {
    
    var baseURL: URL{
        return URL(string: "http://qiita.com/api/v2")!
    }
    
    func send(completion: @escaping (Response) -> ()) {
        
        Session.send(self){result in
            
            switch result{
            case .success(let response):
                completion(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
