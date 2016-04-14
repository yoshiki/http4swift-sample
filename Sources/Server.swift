import Nest
import http4swift
import Inquiline
import URI

struct Server {
    var port: UInt16
    
    init(port: UInt16 = 8080) {
        self.port = port
    }
    
    func start(router router: Router) {
        if let server = HTTPServer(port: port) {
            server.serve { (request) -> ResponseType in
                var req = Request(request: request)
                req.parseURI()
                if let responder = router.match(req) {
                    do {
                        return try responder.respond(to: req)
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
