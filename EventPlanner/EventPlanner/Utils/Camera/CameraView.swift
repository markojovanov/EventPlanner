import SwiftUI

struct CameraView: View {
    @Binding var imageData: Data?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    var body: some View {
        VStack {
            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("No Image")
                    .foregroundColor(.gray)
            }

            Button("Take Photo") {
                showingImagePicker = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: saveImage) {
            ImagePicker(image: self.$inputImage)
        }
    }

    func saveImage() {
        guard let inputImage = inputImage else {
            return
        }
        imageData = inputImage.jpegData(compressionQuality: 1.0)
    }
}

#Preview {
    CameraView(imageData: .constant(nil))
}
