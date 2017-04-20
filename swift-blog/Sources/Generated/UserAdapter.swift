public protocol UserAdapter {
    func findAll(onCompletion: @escaping ([User], Error?) -> Void)
    func create(_ model: User, onCompletion: @escaping (User?, Error?) -> Void)
    func deleteAll(onCompletion: @escaping (Error?) -> Void)

    func findOne(_ maybeID: String?, onCompletion: @escaping (User?, Error?) -> Void)
    func update(_ maybeID: String?, with model: User, onCompletion: @escaping (User?, Error?) -> Void)
    func delete(_ maybeID: String?, onCompletion: @escaping (User?, Error?) -> Void)
}
