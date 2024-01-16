import SwiftUI

struct VideoDetailsView: View {
    var videoList: [URL]

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    if videoList.isEmpty {
                        Text("No Video Available")
                            .font(.title)
                    } else {

                        let description = videoList.first?.description
                        Text(description ?? "Video Details")
                    }
                }
                .padding()
                .foregroundColor(.black)
                .background(Color.white)
            }
        }
    }
}
