import Nest
import Inquiline

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
    var fallback: Responder = BasicResponder { _ in
        return Response(.NotFound, headers: nil, contentType: "text/plain; charset=utf8", content: Status.NotFound.description)
    }
    
    func get(path: String, responder: Responder) {
        let route = Route(path: path, actions: [.get: responder])
        routes.append(route)
    }

    func get(path: String, respond: Respond) {
        get(path, responder: BasicResponder(respond))
    }
    
    func post(path: String, responder: Responder) {
        let route = Route(path: path, actions: [.post: responder])
        routes.append(route)
    }
    
    func post(path: String, respond: Respond) {
        post(path, responder: BasicResponder(respond))
    }
}