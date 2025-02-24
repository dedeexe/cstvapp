import SwiftUI

struct SpinnerView: View {
    @State var isLoading = false

    var body: some View {
        Image(systemName: "progress.indicator")
            .symbolEffect(
                .variableColor.iterative,
                options: .repeat(.continuous),
                value: isLoading
        )
        .onAppear {
            isLoading = true
        }
    }
}

#Preview {
    SpinnerView()
}
