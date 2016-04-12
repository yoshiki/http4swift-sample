import Nest

struct Route {
    var path: String
    var actions: [Method: Responder]
    var fallback: Responder?

    init(path: String, actions: [Method: Responder], fallback: Responder? = nil) {
        self.path = path
        self.actions = actions
        self.fallback = fallback
    }
}

class RouterBuilder {
    var routes = [Route]()
    
    func get(path: String, responder: Responder) {
        let route = Route(path: path, actions: [.get: responder])
        routes.append(route)
    }
    
    func post(path: String, responder: Responder) {
        let route = Route(path: path, actions: [.post: responder])
        routes.append(route)
    }
}