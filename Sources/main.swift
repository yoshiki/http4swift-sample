import http4swift
import Nest
import Inquiline

struct SampleResponder: Responder {
    func respond(to request: RequestType) throws -> ResponseType {
        return Response(.Ok, headers: nil, contentType: "text/html", content: "sample responder")
    }
}

let log = LogMiddleware()

let router = Router(middleware: log) { route in
    route.get("/") { request in
        let content = "foo"
        return Response(.Ok, headers: nil, contentType: "text/html", content: content)
    }
    route.get("/bar") { request in
        let content = "bar"
        return Response(.Ok, headers: nil, contentType: "text/html", content: "")
    }
    route.post("/", respond: RootController().index)
    route.get("/sample", responder: SampleResponder())
}

let app = Server(port: 8080)
app.start(router: router)
