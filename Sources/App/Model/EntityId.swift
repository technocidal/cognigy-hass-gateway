import Vapor

struct EntityIdWrapper: Content {
    let entityId: String
    
    enum CodingKeys: String, CodingKey {
        case entityId = "entity_id"
    }
}
