import SlackKit

class QiitaSlackBot {
    
    private let qiitaAPIManager: QiitaAPIManager
    private let slackKit: SlackKit
    private weak var slackClient: Client?
    
    private let targetUsers: [String]
    private let additinalMessage: String
    
    init(withConfig config: Config) {
        slackKit = SlackKit(withAPIToken: config.slackAPIKey)
        qiitaAPIManager = QiitaAPIManager(withAccessToken: config.qiitaAccessToken, searchTags: config.searchTags)
        
        targetUsers = config.targetUsers
        additinalMessage = config.additinalMessage
        
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
        
        let sendMessage = additinalMessage + "\n" + text
        
        for user in targetUsers {
            slackClient?.webAPI.sendMessage(channel: "@\(user)", text: sendMessage, asUser: true, success: nil, failure: nil)
        }
    }
    
    func fetchTodayItems() {
        qiitaAPIManager.fetchTodayItems()
    }
}
