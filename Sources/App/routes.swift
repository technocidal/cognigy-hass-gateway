import Vapor

func routes(_ app: Application) throws {
    
    app.get { req async throws in
        guard let token = Environment.get("HASS_TOKEN") else {
            throw Abort(.internalServerError)
        }
        
        guard let server = Environment.get("HASS_SERVER") else {
            throw Abort(.internalServerError)
        }
        
        do {
            req.logger.info("Querying HASS")
            let response = try await req.client.get(
                "http://\(server)/api/states",
                headers: [
                    "Authorization": "Bearer \(token)",
                    "Content-Type": "application/json",
                ])
            req.logger.info("Successfully queried HASS")
            let states = try response.content.decode([EntityLight].self)
                .filter { $0.entityId.hasPrefix("light") }
                .filter {
                    $0.attributes?.friendlyName != nil
                }
            return states
        } catch {
            req.logger.error("\(error)")
            throw Abort(.internalServerError)
        }
    }
    
    app.post(":entity") { req async throws in
        guard let token = Environment.get("HASS_TOKEN") else {
            throw Abort(.internalServerError)
        }
        
        guard let entityId = req.parameters.get("entity") else {
            throw Abort(.internalServerError)
        }
        
        let command = try req.content.decode(EntityLightCommand.self)
        if command.newState == "on" {
            _ = try await req.client.turnOnLight(with: entityId)
        } else {
            _ = try await req.client.turnOffLight(with: entityId)
        }
        
        return HTTPStatus.ok
    }
}
