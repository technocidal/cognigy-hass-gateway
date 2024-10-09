import Vapor

extension Client {
    
    func turnOnLight(with entityId: String) async throws -> ClientResponse {
        guard let token = Environment.get("HASS_TOKEN") else {
            throw Abort(.internalServerError)
        }
        
        guard let server = Environment.get("HASS_SERVER") else {
            throw Abort(.internalServerError)
        }
        
        let entity = EntityIdWrapper(entityId: entityId)
        
        return try await post(
            "http://\(server)/api/services/light/turn_on",
            headers: [
                "Authorization": "Bearer \(token)",
                "Content-Type": "application/json",
            ], content: entity)
    }
    
    func turnOffLight(with entityId: String) async throws -> ClientResponse {
        guard let token = Environment.get("HASS_TOKEN") else {
            throw Abort(.internalServerError)
        }
        
        guard let server = Environment.get("HASS_SERVER") else {
            throw Abort(.internalServerError)
        }
        
        let entity = EntityIdWrapper(entityId: entityId)
        
        return try await post(
            "http://\(server)/api/services/light/turn_off",
            headers: [
                "Authorization": "Bearer \(token)",
                "Content-Type": "application/json",
            ], content: entity)
    }
}
