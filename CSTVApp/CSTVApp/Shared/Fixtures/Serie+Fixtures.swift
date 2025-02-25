#if DEBUG
import Foundation

extension Serie {
    static func fixture(fullName: String = "Main Serie") -> Serie {
        Serie(fullName: fullName)
    }
}
#endif
