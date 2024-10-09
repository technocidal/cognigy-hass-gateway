import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    //    curl \
    //      -H "Authorization: Bearer TOKEN \
    //      -H "Content-Type: application/json" \
    //      -d '{"entity_id": "light.elgato_key_light_air_9d2c" }' \
    //      http://192.168.1.121:8123/api/services/switch/turn_on

    struct EntityInformation: Content {
        let entity_id: String
    }

    app.post { req async throws in
        guard let token = Environment.get("HASS_TOKEN") else {
            return 500
        }
        let entityInformation = EntityInformation(entity_id: "light.elgato_key_light_air_9d2c")
        return try await req.client.post(
            "http://192.168.1.121:8123/api/services/light/turn_on",
            headers: [
                "Authorization": "Bearer \(token)",
                "Content-Type": "application/json",
            ], content: entityInformation)
        return 200
    }
}
