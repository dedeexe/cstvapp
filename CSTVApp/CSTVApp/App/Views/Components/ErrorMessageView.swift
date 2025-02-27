import SwiftUI

struct ErrorMessageView: View {
    let message: String
    let onTapRefresh: () -> Void

    var body: some View {
        VStack(spacing: Measure.spaceNormal) {
            TextLabel(message, style: .caption)
                .multilineTextAlignment(.center)

            Button {
                onTapRefresh()
            } label: {
                TextLabel("Tente novamente", style: .action)
                    .underline()
            }

        }
        .padding(Measure.spaceNormal)
    }
}

#Preview {
    VStack {
        ErrorMessageView(message: "Message") {
            //Do Nothing
        }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Palette.background.color)
}
