import SlackKit

class QiitaSlackBot {
    
    private let qiitaAPIManager: QiitaAPIManager
    private let slackKit: SlackKit
    private weak var slackClient: Client?
    
    private let targetUsers: [String]
    
    init(withConfig config: Config) {
        slackKit = SlackKit(withAPIToken: config.slackAPIKey)
        qiitaAPIManager = QiitaAPIManager(withAccessToken: config.qiitaAccessToken, searchTags: config.searchTags)
        
        targetUsers = config.targetUsers
        
        slackKit.onClientInitalization = {[weak self] slackClient in
            self?.slackClient = slackClient
        }
        
        qiitaAPIManager.didRecievedItems = {[weak self] text in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.send(text: text)
        }
    }
    
    private func send(text: String) {
        
        for user in targetUsers {
            slackClient?.webAPI.sendMessage("@\(user)", text: text, asUser: true, success: nil, failure: nil)
        }
    }
    
    func fetchTodayItems() {
        qiitaAPIManager.fetchTodayItems()
    }
}
