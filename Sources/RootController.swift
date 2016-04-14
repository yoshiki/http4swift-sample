import Nest
import Inquiline

class RootController {
    func index(request: RequestType) -> ResponseType {
        do {
            if let req = request as? Request, json = try req.json() {
                print(json)
            }
        } catch {
            return Response(.InternalServerError)
        }
        return Response(.Ok, content: "posted")
    }
}