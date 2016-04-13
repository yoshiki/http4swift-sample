// Original code from https://github.com/open-swift/S4
import Nest
import Inquiline

protocol Middleware {
    func respond(to request: RequestType, chainingTo next: Responder) throws -> ResponseType
}

extension Middleware {
    func chain(to responder: Responder) -> Responder {
        return BasicResponder { request in
            return try self.respond(to: request, chainingTo: responder)
        }
    }
}

#if swift(>=3.0)
extension Collection where Self.Iterator.Element == Middleware {
    func chain(to responder: Responder) -> Responder {
        var responder = responder

        for middleware in self.reversed() {
            responder = middleware.chain(to: responder)
        }
            
        return responder
    }
}
#else
extension CollectionType where Self.Generator.Element == Middleware {
    public func chain(to responder: Responder) -> Responder {
        var responder = responder
    
        for middleware in self.reverse() {
            responder = middleware.chain(to: responder)
        }
    
        return responder
    }
}
#endif

struct BasicResponder: Responder {
    let respond: Respond
    
    init(_ respond: Respond) {
        self.respond = respond
    }
    
    func respond(to request: RequestType) throws -> ResponseType {
        return try self.respond(to: request)
    }
}

