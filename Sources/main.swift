import http4swift

let router = Router { route in
    route.get("/") { request in
        let content = "foo"
        return Response(.Ok, headers: nil, contentType: "text/html", content: content)
    }
    route.get("/bar") { request in
        let content = "bar"
        return Response(.Ok, headers: nil, contentType: "text/html", content: content)
    }
}

let app = Server(port: 8080)
app.start(router: router)
