public protocol CommentAdapter {
    func findAll(onCompletion: @escaping ([Comment], Error?) -> Void)
    func create(_ model: Comment, onCompletion: @escaping (Comment?, Error?) -> Void)
    func deleteAll(onCompletion: @escaping (Error?) -> Void)

    func findOne(_ maybeID: String?, onCompletion: @escaping (Comment?, Error?) -> Void)
    func update(_ maybeID: String?, with model: Comment, onCompletion: @escaping (Comment?, Error?) -> Void)
    func delete(_ maybeID: String?, onCompletion: @escaping (Comment?, Error?) -> Void)
}
