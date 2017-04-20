import Kitura
import Configuration

public func initializeCRUDResources(manager: ConfigurationManager, router: Router) throws {
    let factory = AdapterFactory(manager: manager)
    try PostResource(factory: factory).setupRoutes(router: router)
    try UserResource(factory: factory).setupRoutes(router: router)
    try CommentResource(factory: factory).setupRoutes(router: router)
}
