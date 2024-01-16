import SwiftUI
import MarkdownKit

struct VideoDetailsView: View {
    @Binding var currentIndex: Int
    var videoList: [Video]

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    if videoList.isEmpty {
                        Text("No Video Available")
                            .font(.title)
                    } else {
                        let description = videoList[currentIndex].description
                        MarkdownView(markdown:description)
                    }
                }
                .padding()
                .foregroundColor(.black)
                .background(Color.white)
            }
        }
    }

    struct MarkdownView: UIViewRepresentable {
        let markdown: String

        func makeUIView(context: Context) -> UITextView {
            let textView = UITextView()
            textView.isEditable = false
            textView.backgroundColor = .white
            textView.textColor = .black
            textView.showsVerticalScrollIndicator = true
            textView.indicatorStyle = .black
            return textView
        }

        func updateUIView(_ uiView: UITextView, context: Context) {
            guard let font = UIFont(name: "Arial", size: 18) else { return }
            let parser = MarkdownParser(font: font)
            let attributedString = parser.parse(markdown)
            uiView.attributedText = attributedString
        }
    }
}
