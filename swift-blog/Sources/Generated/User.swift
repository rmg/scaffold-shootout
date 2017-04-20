import SwiftyJSON

public struct User {
    public let id: String?
    public let name: String
    public let email: String

    public init(id: String?, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }

    public init(json: JSON) throws {
        // Required properties
        guard json["name"].exists() else {
            throw ModelError.requiredPropertyMissing(name: "name")
        }
        guard let name = json["name"].string else {
            throw ModelError.propertyTypeMismatch(name: "name", type: "string", value: json["name"].description, valueType: String(describing: json["name"].type))
        }
        self.name = name
        guard json["email"].exists() else {
            throw ModelError.requiredPropertyMissing(name: "email")
        }
        guard let email = json["email"].string else {
            throw ModelError.propertyTypeMismatch(name: "email", type: "string", value: json["email"].description, valueType: String(describing: json["email"].type))
        }
        self.email = email

        // Optional properties
        if json["id"].exists() &&
           json["id"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "id", type: "string", value: json["id"].description, valueType: String(describing: json["id"].type))
        }
        self.id = json["id"].string

        // Check for extraneous properties
        if let jsonProperties = json.dictionary?.keys {
            let properties: [String] = ["id", "name", "email"]
            for jsonPropertyName in jsonProperties {
                if !properties.contains(where: { $0 == jsonPropertyName }) {
                    throw ModelError.extraneousProperty(name: jsonPropertyName)
                }
            }
        }
    }

    public func settingID(_ newId: String?) -> User {
      return User(id: newId, name: name, email: email)
    }

    public func updatingWith(json: JSON) throws -> User {
        if json["id"].exists() &&
           json["id"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "id", type: "string", value: json["id"].description, valueType: String(describing: json["id"].type))
        }
        let id = json["id"].string ?? self.id

        if json["name"].exists() &&
           json["name"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "name", type: "string", value: json["name"].description, valueType: String(describing: json["name"].type))
        }
        let name = json["name"].string ?? self.name

        if json["email"].exists() &&
           json["email"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "email", type: "string", value: json["email"].description, valueType: String(describing: json["email"].type))
        }
        let email = json["email"].string ?? self.email

        return User(id: id, name: name, email: email)
    }

    public func toJSON() -> JSON {
        var result = JSON([
            "name": JSON(name),
            "email": JSON(email),
        ])
        if let id = id {
            result["id"] = JSON(id)
        }

        return result
    }
}
