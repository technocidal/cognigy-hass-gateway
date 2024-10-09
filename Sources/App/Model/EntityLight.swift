import Vapor

struct EntityLight: Content {
    let entityId: String
    let state: String
    var attributes: Attributes? = nil
    
    enum CodingKeys: String, CodingKey {
        case entityId = "entity_id"
        case state
        case attributes
    }
}

extension EntityLight {
    
    struct Attributes: Codable {
        var friendlyName: String?
        
        enum CodingKeys: String, CodingKey {
            case friendlyName = "friendly_name"
        }
    }
}
