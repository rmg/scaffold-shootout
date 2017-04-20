import SwiftyJSON

public struct Post {
    public let id: String?
    public let title: String
    public let body: String

    public init(id: String?, title: String, body: String) {
        self.id = id
        self.title = title
        self.body = body
    }

    public init(json: JSON) throws {
        // Required properties
        guard json["title"].exists() else {
            throw ModelError.requiredPropertyMissing(name: "title")
        }
        guard let title = json["title"].string else {
            throw ModelError.propertyTypeMismatch(name: "title", type: "string", value: json["title"].description, valueType: String(describing: json["title"].type))
        }
        self.title = title
        guard json["body"].exists() else {
            throw ModelError.requiredPropertyMissing(name: "body")
        }
        guard let body = json["body"].string else {
            throw ModelError.propertyTypeMismatch(name: "body", type: "string", value: json["body"].description, valueType: String(describing: json["body"].type))
        }
        self.body = body

        // Optional properties
        if json["id"].exists() &&
           json["id"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "id", type: "string", value: json["id"].description, valueType: String(describing: json["id"].type))
        }
        self.id = json["id"].string

        // Check for extraneous properties
        if let jsonProperties = json.dictionary?.keys {
            let properties: [String] = ["id", "title", "body"]
            for jsonPropertyName in jsonProperties {
                if !properties.contains(where: { $0 == jsonPropertyName }) {
                    throw ModelError.extraneousProperty(name: jsonPropertyName)
                }
            }
        }
    }

    public func settingID(_ newId: String?) -> Post {
      return Post(id: newId, title: title, body: body)
    }

    public func updatingWith(json: JSON) throws -> Post {
        if json["id"].exists() &&
           json["id"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "id", type: "string", value: json["id"].description, valueType: String(describing: json["id"].type))
        }
        let id = json["id"].string ?? self.id

        if json["title"].exists() &&
           json["title"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "title", type: "string", value: json["title"].description, valueType: String(describing: json["title"].type))
        }
        let title = json["title"].string ?? self.title

        if json["body"].exists() &&
           json["body"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "body", type: "string", value: json["body"].description, valueType: String(describing: json["body"].type))
        }
        let body = json["body"].string ?? self.body

        return Post(id: id, title: title, body: body)
    }

    public func toJSON() -> JSON {
        var result = JSON([
            "title": JSON(title),
            "body": JSON(body),
        ])
        if let id = id {
            result["id"] = JSON(id)
        }

        return result
    }
}
