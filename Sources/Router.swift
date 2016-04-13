// Original code from https://github.com/Zewo/Router/
import Nest
import Inquiline

struct Router {
    let routes: [Route]
    let matcher: RouteMatcher
    let fallback: Responder
    let middleware: [Middleware]
    
    init(middleware: Middleware..., matcher: RouteMatcher.Type = BasicRouteMatcher.self, build: (route: RouterBuilder) -> Void) {
        let builder = RouterBuilder()
        build(route: builder)
        self.middleware = middleware
        self.routes = builder.routes
        self.matcher = matcher.init(routes: builder.routes)
        self.fallback = builder.fallback
    }
    
    func match(request: RequestType) -> Responder? {
        if let route = matcher.match(request) {
            let method = Method(request.method)
            if let responder = route.actions[method] {
                return middleware.chain(to: responder)
            }
        }
        return fallback
    }
}

protocol RouteMatcher {
    var routes: [Route] { get }
    init(routes: [Route])
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
