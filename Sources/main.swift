import http4swift

let handler: HTTPHandler = { request, writer in
    let body = String(validatingUTF8: request.bodyBytes)
    print(body)
    do {
        let content = "foo"
        try writer.write(Response(.Ok, headers: nil, contentType: "text/html", content: content))
    } catch {
        fatalError()
    }
}

let server = HTTPServer(port: 8080)
server?.serve(handler)