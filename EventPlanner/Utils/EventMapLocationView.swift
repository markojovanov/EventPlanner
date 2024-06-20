import CoreLocation
import MapKit
import SwiftUI

struct EventMapLocationView: UIViewRepresentable {
    @Binding var selectedLocation: CLLocationCoordinate2D?
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 37.7749,
            longitude: -122.4194
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.05,
            longitudeDelta: 0.05
        )
    )

    class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
        var parent: EventMapLocationView
        var locationManager = CLLocationManager()

        init(parent: EventMapLocationView) {
            self.parent = parent
            super.init()
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let annotationView = MKMarkerAnnotationView(
                annotation: annotation, reuseIdentifier: "myAnnotation"
            )
            annotationView.canShowCallout = true
            annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            return annotationView
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator

        if let selectedLocation = selectedLocation {
            let savedRegion = MKCoordinateRegion(center: selectedLocation, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            mapView.setRegion(savedRegion, animated: true)

            let annotation = MKPointAnnotation()
            annotation.coordinate = selectedLocation
            mapView.addAnnotation(annotation)
        }

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {}
}

#Preview {
    EventMapLocationView(selectedLocation: .constant(nil))
}
