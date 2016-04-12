import Nest
import C7

public protocol PayloadConvertible {
  func toPayload() -> PayloadType
}


class BytesPayload : PayloadType {
  var bytes: [Byte]?

  init(bytes: [Byte]) {
    self.bytes = bytes
  }

  func next() -> [Byte]? {
    if let bytes = bytes {
      self.bytes = nil
      return bytes
    }

    return nil
  }
}


extension String : PayloadConvertible {
  var bytes: [Byte] {
    return utf8.map { UInt8($0) }
  }

  public func toPayload() -> PayloadType {
    return BytesPayload(bytes: bytes)
  }
}
