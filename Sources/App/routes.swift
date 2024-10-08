import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

// curl \
//   -H "Authorization: Bearer TOKEN" \
//   -H "Content-Type: application/json" \
//   http://IP_ADDRESS:8123/ENDPOINT

    app.post { req async in
        req.client
        return 200
    }
}
