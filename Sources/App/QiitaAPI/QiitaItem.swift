import Himotoki

struct QiitaItem: Decodable {
    let title: String
    let url: String

    static func decode(_ e: Extractor) throws -> QiitaItem {
        
        return try QiitaItem(
            title: e <| "title",
            url: e <| "url"
        )
    }
}
