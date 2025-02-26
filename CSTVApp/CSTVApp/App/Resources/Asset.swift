import UIKit

enum Asset: String {
    case logo

    var image: UIImage? {
        UIImage(named: rawValue)
    }
}
