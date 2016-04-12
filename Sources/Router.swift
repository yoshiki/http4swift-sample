import Nest

protocol RouteMatcher {
    var routes: [Route] { get }
    func match(request: RequestType) -> Route?
}

struct BasicRouteMatcher: RouteMatcher {
    var routes: [Route]
    
    init(routes: [Route]) {
        self.routes = routes
    }
    
    func match(request: RequestType) -> Route? {
        for route in routes {
            if route.path == request.path {
                let method = Method(request.method)
                if let _ = route.actions[method] {
                    return route
                }
            }
        }
        return nil
    }
}

struct Router {
    let routes: [Route]
    let matcher: RouteMatcher
    let fallback: Responder
    
    init(build: (route: RouterBuilder) -> Void) {
        let builder = RouterBuilder()
        build(route: builder)
        self.routes = builder.routes
        self.matcher = BasicRouteMatcher(routes: builder.routes)
        self.fallback = { _ in
            return Response(.NotFound, headers: nil, contentType: "text/html", content: Status.NotFound.description)
        }
    }
    
    func match(request: RequestType) -> Responder? {
        if let route = matcher.match(request) {
            let method = Method(request.method)
            return route.actions[method]
        } else {
            return fallback
        }
    }
}
