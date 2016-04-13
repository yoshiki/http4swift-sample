import Nest
import Inquiline

typealias Respond = (to: RequestType) throws -> ResponseType

protocol Responder  {
    func respond(to request: RequestType) throws -> ResponseType
}
