import Kitura
import Configuration

public func initializeCRUDResources(manager: ConfigurationManager, router: Router) throws {
    let factory = AdapterFactory(manager: manager)
    try UserResource(factory: factory).setupRoutes(router: router)
}
