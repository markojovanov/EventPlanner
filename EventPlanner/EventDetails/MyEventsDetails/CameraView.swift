import SwiftUI

struct CameraView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var imageData: Data?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    var body: some View {
        VStack {
            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 10)
                    .padding()
            } else {
                VStack {
                    Text("No Image")
                        .foregroundColor(.gray)
                        .padding(.bottom, 20)

                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                }
                .padding()
            }
            Group {
                if imageData == nil {
                    GeneralButton(title: "Take photo", color: .blue) {
                        showingImagePicker = true
                    }
                } else {
                    GeneralButton(title: "Save photo", color: .green) {
                        saveImage()
                        dismiss()
                    }
                }
            }
            .padding()
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
