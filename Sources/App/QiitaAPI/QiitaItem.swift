import Himotoki

struct QiitaItem: Decodable {
    let title: String
    let url: String
    let tags: [Tag]

    static func decode(_ e: Extractor) throws -> QiitaItem {
        
        return try QiitaItem(
            title: e <| "title",
            url: e <| "url",
            tags: e <|| "tags"
        )
    }
    
    struct Tag: Decodable {
        let name: String
        
        static func decode(_ e: Extractor) throws -> Tag {
            
            return try Tag(name: e <| "name")
        }
    }
}
