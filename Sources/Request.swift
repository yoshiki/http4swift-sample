import Nest
import Inquiline
import URI
import Jay

extension Request {
    init(request: RequestType) {
        self.method = request.method
        self.path = request.path
        self.headers = request.headers
        self.content = request.content
        self.body = request.content?.toPayload()
    }
    
    mutating func parseURI() {
        do {
            let uri = try URI(path)
            if let path = uri.path {
                self.path = path
            }
        } catch {
        }
    }
    
    func json() throws -> Any? {
        if let ct = contentType where ct.hasPrefix("application/json") {
            return try bytes.map(Jay().jsonFromData)
        } else {
            return nil
        }
    }
}