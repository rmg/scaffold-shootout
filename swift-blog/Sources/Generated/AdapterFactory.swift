import Foundation
import Configuration
import CloudFoundryConfig

public class AdapterFactory {
    let manager: ConfigurationManager

    init(manager: ConfigurationManager) {
        self.manager = manager
    }

    public func getPostAdapter() throws -> PostAdapter {
      return PostMemoryAdapter()
    }
    public func getUserAdapter() throws -> UserAdapter {
      return UserMemoryAdapter()
    }
    public func getCommentAdapter() throws -> CommentAdapter {
      return CommentMemoryAdapter()
    }

}
