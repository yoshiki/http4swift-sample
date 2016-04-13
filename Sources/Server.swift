import Nest
import http4swift
import Inquiline

struct Server {
    var port: UInt16
    
    init(port: UInt16 = 8080) {
        self.port = port
    }
    
    func start(router router: Router) {
        if let server = HTTPServer(port: port) {
            server.serve { (request) -> ResponseType in
                if let responder = router.match(request) {
                    do {
                        return try responder.respond(to: request)
                    } catch {
                        return Response(Status.InternalServerError, contentType: "text/plain; charset=utf8")
                    }
                } else {
                    return Response(.NotFound, contentType: "text/plain; charset=utf8")
                }
            }
        } else {
            fatalError()
        }
    }
}
