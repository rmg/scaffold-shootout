public protocol PostAdapter {
    func findAll(onCompletion: @escaping ([Post], Error?) -> Void)
    func create(_ model: Post, onCompletion: @escaping (Post?, Error?) -> Void)
    func deleteAll(onCompletion: @escaping (Error?) -> Void)

    func findOne(_ maybeID: String?, onCompletion: @escaping (Post?, Error?) -> Void)
    func update(_ maybeID: String?, with model: Post, onCompletion: @escaping (Post?, Error?) -> Void)
    func delete(_ maybeID: String?, onCompletion: @escaping (Post?, Error?) -> Void)
}
