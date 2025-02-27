import SwiftUI

enum Icon: String {
    case arrowLeft = "arrow.backward"

    var image: Image {
        Image(systemName: rawValue)
    }
}
