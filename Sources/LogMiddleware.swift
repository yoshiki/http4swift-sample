import Nest
import Inquiline

struct LogMiddleware: Middleware {
    func respond(to request: RequestType, chainingTo next: Responder) throws -> ResponseType {
        let response = try next.respond(to: request)
        print("\(request.path) \(response.statusLine)")
        return response
    }
}