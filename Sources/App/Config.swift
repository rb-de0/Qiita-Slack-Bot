import Himotoki

struct Config: Decodable {
    
    let slackAPIKey: String
    let qiitaAccessToken: String
    let targetUsers: [String]
    let searchTags: [String]
    let additinalMessage: String
    
    static func decode(_ e: Extractor) throws -> Config {
        
        return try Config(
            slackAPIKey: e <| "slackAPIKey",
            qiitaAccessToken: e <| "qiitaAccessToken",
            targetUsers: e <|| "targetUsers",
            searchTags: e <|| "searchTags",
            additinalMessage: e <| "additinalMessage"
        )
    }
}
