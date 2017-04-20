import Foundation

public class CommentMemoryAdapter: CommentAdapter {
    var items: [String:Comment] = [:]

    public func findAll(onCompletion: @escaping ([Comment], Error?) -> Void) {
        onCompletion(items.map { $1 }, nil)
    }

    public func create(_ model: Comment, onCompletion: @escaping (Comment?, Error?) -> Void) {
        let id = model.id ?? UUID().uuidString
        // TODO: Don't overwrite if id already exists
        let storedModel = model.settingID(id)
        items[id] = storedModel
        onCompletion(storedModel, nil)
    }

    public func deleteAll(onCompletion: @escaping (Error?) -> Void) {
        items.removeAll()
        onCompletion(nil)
    }

    public func findOne(_ maybeID: String?, onCompletion: @escaping (Comment?, Error?) -> Void) {
        guard let id = maybeID else {
            return onCompletion(nil, AdapterError.invalidId(maybeID))
        }
        guard let retrievedModel = items[id] else {
            return onCompletion(nil, AdapterError.notFound(id))
        }
        onCompletion(retrievedModel, nil)
    }

    public func update(_ maybeID: String?, with model: Comment, onCompletion: @escaping (Comment?, Error?) -> Void) {
        delete(maybeID) { _, error in
            if let error = error {
                onCompletion(nil, error)
            } else {
                // NOTE: delete() guarantees maybeID non-nil if error is nil
                let id = maybeID!
                let model = (model.id == nil) ? model.settingID(id) : model
                self.create(model) { storedModel, error in
                    onCompletion(storedModel, error)
                }
            }
        }
    }

    public func delete(_ maybeID: String?, onCompletion: @escaping (Comment?, Error?) -> Void) {
        guard let id = maybeID else {
            return onCompletion(nil, AdapterError.invalidId(maybeID))
        }
        guard let removedModel = items.removeValue(forKey: id) else {
            return onCompletion(nil, AdapterError.notFound(id))
        }
        onCompletion(removedModel, nil)
    }
}
