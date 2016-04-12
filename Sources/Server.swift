import Nest
import http4swift
import S4

struct Server {
    var port: UInt16
    
    init(port: UInt16 = 8080) {
        self.port = port
    }
    
    func start(router router: Router) {
        if let server = HTTPServer(port: port) {
            server.serve({ (request) -> ResponseType in
                if let responder = router.match(request) {
                    return responder(request)
                } else {
                    return Response(.NotFound)
                }
            })
        } else {
            fatalError()
        }
    }
}
