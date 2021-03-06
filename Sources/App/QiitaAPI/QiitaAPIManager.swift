import Foundation

class QiitaAPIManager {
    
    private let accessToken: String
    private let searchTags: [String]
    
    var didRecievedItems: ((String) -> ())?
    
    init(withAccessToken accessToken: String, searchTags: [String]) {
        self.accessToken = accessToken
        self.searchTags = searchTags
    }
    
    func fetchTodayItems() {
        
        QiitaTodayItemRequest(tags: searchTags, day: formattedToday(), accessToken: accessToken)
            .send {[weak self] items in
                guard let strongSelf = self else {
                    return
                }
                
                strongSelf.didRecievedItems?(strongSelf.transform(items: items))
            }
    }
    
    private func transform(items: [QiitaItem]) -> String {
        
        return items.map{ $0.title + " 【\($0.tags.map{$0.name}.joined(separator: "/")) 】" + "\n" + $0.url }.joined(separator: "\n\n")
    }
    
    private func formattedToday() -> String {
        let yesterday = Date(timeIntervalSinceNow: -24 * 60 * 60)
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: yesterday)
    }
}
