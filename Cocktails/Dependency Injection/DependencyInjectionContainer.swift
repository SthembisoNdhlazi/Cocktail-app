import Foundation
import Swinject
import InjectPropertyWrapper

extension Container {
    static let shared = Container()
    subscript<T>(type: T.Type) -> T {
        get { resolve(type)! }
    }
}

extension Container: InjectPropertyWrapper.Resolver {
    
}
