import SwiftUI
import PencilKit

struct DrawingCanvasView: View {
    @Binding var drawing: PKDrawing

    var body: some View {
        CanvasView(drawing: $drawing)
            .border(Color.gray.opacity(0.3), width: 1)
    }
}

// This wrapper connects PencilKit to SwiftUI
struct CanvasView: UIViewRepresentable {
    @Binding var drawing: PKDrawing

    func makeUIView(context: Context) -> PKCanvasView {
        let canvasView = PKCanvasView()
        canvasView.drawing = drawing
        canvasView.delegate = context.coordinator

        // Configure for kids - make drawing tools accessible
        canvasView.drawingPolicy = .anyInput
        canvasView.maximumZoomScale = 3.0
        canvasView.minimumZoomScale = 0.5

        return canvasView
    }

    func updateUIView(_ canvasView: PKCanvasView, context: Context) {
        canvasView.drawing = drawing
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PKCanvasViewDelegate {
        let parent: CanvasView

        init(_ parent: CanvasView) {
            self.parent = parent
        }

        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            parent.drawing = canvasView.drawing
        }
    }
}

#Preview {
    DrawingCanvasView(drawing: .constant(PKDrawing()))
}

#Preview {
    DrawingCanvasView(drawing: .constant(PKDrawing()))
}
