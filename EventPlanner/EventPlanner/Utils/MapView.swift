import CoreLocation
import MapKit
import SwiftUI

// MARK: - MapView

struct MapView: UIViewRepresentable {
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
        var parent: MapView
        var locationManager = CLLocationManager()

        init(parent: MapView) {
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

        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            parent.selectedLocation = view.annotation?.coordinate
        }

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                if parent.selectedLocation == nil {
                    parent.region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                    manager.stopUpdatingLocation()
                }
            }
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

            // Add annotation at the selected location
            let annotation = MKPointAnnotation()
            annotation.coordinate = selectedLocation
            mapView.addAnnotation(annotation)
        } else {
            mapView.setRegion(region, animated: true)
        }

        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        mapView.addGestureRecognizer(tapGesture)

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        if let selectedLocation = selectedLocation {
            let newRegion = MKCoordinateRegion(center: selectedLocation, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            uiView.setRegion(newRegion, animated: true)

            // Remove existing annotations
            uiView.removeAnnotations(uiView.annotations)

            // Add new annotation at the selected location
            let annotation = MKPointAnnotation()
            annotation.coordinate = selectedLocation
            uiView.addAnnotation(annotation)
        }
    }
}

extension MapView.Coordinator {
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let mapView = gesture.view as! MKMapView
        let location = gesture.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)

        // Remove existing annotations
        mapView.removeAnnotations(mapView.annotations)

        // Add new annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)

        parent.selectedLocation = coordinate
    }
}

// Preview
#Preview {
    MapView(selectedLocation: .constant(nil))
}
