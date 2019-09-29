//
//  ScheduleRideViewController.swift
//  Mano
//
//  Created by Leandro Wauters on 9/1/19.
//  Copyright © 2019 Leandro Wauters. All rights reserved.
//

import UIKit
import MapKit
import GooglePlaces

enum SelectedAnnotationView {
    case pickup,dropoff
}
class ScheduleRideViewController: UIViewController {
    
    let scheduleRideView = ScheduleRideView()
    private var dropoffAddress: String!
    private var dropoffName: String!
    private var dropoffLat: Double!
    private var dropoffLon: Double!
    private var pickupName: String?
    private var pickupAddress: String?
    private var pickupLat: Double!
    private var pickupLon: Double!
    private var mapOverlays: MKOverlay?
    private var mapPoints = [CustomPointAnnotation]()
    static var selectedAnnotationView: SelectedAnnotationView!
    private var selectedDatePressed = false
    private var changeWidth = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = scheduleRideView
        scheduleRideView.delegate = self
        guard let currentUser = DBService.currentManoUser,
            let homeAddress = currentUser.homeAdress,
            let homeLon = currentUser.homeLon,
            let homeLat = currentUser.homeLat else {showAlert(title: "Error", message: "User not found")
                return}
        pickupAddress = homeAddress
        pickupLon = homeLon
        pickupLat = homeLat
        pickupName = "Home"
        setupMap(pickupTitle: "Home", pickupSubtitle: homeAddress, dropoffTitle: dropoffName, dropoffSubtitle: dropoffAddress, pickupLat: homeLat, pickupLon: homeLon, dropoffLat: dropoffLat, dropoffLon: dropoffLon, changedAddress: false)
        scheduleRideView.mapView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?,dropoffAddress: String, dropoffName: String, dropoffLat: Double, dropoffLon: Double) {
        self.dropoffAddress = dropoffAddress
        self.dropoffName = dropoffName
        self.dropoffLat = dropoffLat
        self.dropoffLon = dropoffLon
        super.init(nibName: nil, bundle: nil)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMap(pickupTitle: String, pickupSubtitle: String, dropoffTitle: String, dropoffSubtitle: String, pickupLat: Double, pickupLon: Double, dropoffLat: Double, dropoffLon: Double, changedAddress: Bool) {
        if let mapOverlay = mapOverlays {
            scheduleRideView.mapView.removeOverlay(mapOverlay)
            scheduleRideView.mapView.removeAnnotations(mapPoints)
        }
        setupAnnotation(title: pickupTitle, subtitle: pickupSubtitle, coordinate: CLLocationCoordinate2D(latitude: pickupLat, longitude: pickupLon), imageName: "homeMapPin", tag: 0)
        setupAnnotation(title: dropoffTitle, subtitle: dropoffSubtitle, coordinate: CLLocationCoordinate2D(latitude: dropoffLat, longitude: dropoffLon), imageName: "appointmentMapPin", tag: 1)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: pickupLat, longitude: pickupLon), addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: dropoffLat, longitude: dropoffLon), addressDictionary: nil))
        request.transportType = .automobile
        let directions = MKDirections(request: request)
        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            for route in unwrappedResponse.routes {
                self.mapOverlays = route.polyline
                self.scheduleRideView.mapView.addOverlay(route.polyline)
                self.scheduleRideView.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 75, left: 75, bottom: 95, right: 75), animated: true)
            }
        }
    }
    
    
    func setupAnnotation(title: String, subtitle: String, coordinate: CLLocationCoordinate2D, imageName: String, tag: Int){
        let point = CustomPointAnnotation()
        point.title = title
        point.subtitle = subtitle
        point.coordinate = coordinate
        point.imageName = imageName
        point.tag = tag
        scheduleRideView.mapView.addAnnotation(point)
        mapPoints.append(point)
    }
}

extension ScheduleRideViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        renderer.lineWidth = 4.5
        return renderer
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is CustomPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            annotationView.annotation = annotation
            return annotationView
        } else {
            let annotationView = MKAnnotationView(annotation:annotation, reuseIdentifier:identifier)
            annotationView.isEnabled = true
            annotationView.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            btn.setImage(UIImage(named: "search_blue"), for: .normal)
            annotationView.rightCalloutAccessoryView = btn
            let cpa = annotation as! CustomPointAnnotation
            annotationView.image = UIImage(named: cpa.imageName)
            return annotationView
        }
    }

    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
       let annot = view.annotation as! CustomPointAnnotation
        scheduleRideView.mapView.removeAnnotation(view.annotation!)
        if annot.tag == 0 {
            ScheduleRideViewController.selectedAnnotationView = .pickup
        } else {
           ScheduleRideViewController.selectedAnnotationView = .dropoff
        }
        MapsHelper.shared.setupAutoCompeteVC(Vc: self)
        
    }
}

extension ScheduleRideViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        guard let address = place.formattedAddress else {
            showAlert(title: "Error finding address", message: nil)
            return}
        let coordinate = place.coordinate
        dismiss(animated: true, completion: nil)
        if ScheduleRideViewController.selectedAnnotationView == SelectedAnnotationView.pickup {
            pickupAddress = address
            pickupLat = coordinate.latitude
            pickupLon = coordinate.longitude
            pickupName = "Pick-up"

        } else {
            dropoffName = place.name ?? ""
            dropoffAddress = address
            dropoffLon = coordinate.longitude
            dropoffLat = coordinate.latitude
        }
        setupMap(pickupTitle: pickupName!, pickupSubtitle: pickupAddress!, dropoffTitle: dropoffName, dropoffSubtitle: dropoffAddress, pickupLat: pickupLat, pickupLon: pickupLon, dropoffLat: dropoffLat, dropoffLon: dropoffLon, changedAddress: true)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

extension ScheduleRideViewController: ScheduleRideViewDelegate {
    func scheduleRidePressed() {
        let date = scheduleRideView.datePicker.date.dateDescription
        let timeStamp = Date().dateDescription
        DBService.createARide(date: date, passangerId: DBService.currentManoUser.userId  , passangerName: DBService.currentManoUser.fullName, pickupAddress: pickupAddress!, dropoffAddress: dropoffAddress, dropoffName: dropoffName, pickupLat: pickupLat, pickupLon: pickupLon, dropoffLat: dropoffLat, dropoffLon: dropoffLon, dateRequested: timeStamp, passangerCell: DBService.currentManoUser.cellPhone!) { [weak self] error in
            if let error = error {
                self?.showAlert(title: "Error creating ride", message: error.localizedDescription)
            }

        }
        let alertVC = AlertViewController(nibName: nil, bundle: nil, title: "Ride requested!", message: "Check your ride status for updates")
        alertVC.delegate = self
        alertVC.modalPresentationStyle = .overCurrentContext
        present(alertVC, animated: true)
    }
    
    func selectDatePressed() {
        if selectedDatePressed {
            selectedDatePressed = false
            UIView.animate(withDuration: 0.3) {
                self.scheduleRideView.scheduleRideView.transform = .identity
                self.scheduleRideView.scheduleRideButtonView.frame.origin.y += self.scheduleRideView.scheduleRideButtonView.frame.height * 3
                self.scheduleRideView.selectDateView.frame.origin.y += self.scheduleRideView.selectDateView.frame.height * 3
            }
            scheduleRideView.datePicker.isHidden = true
        } else {
            selectedDatePressed = true
            UIView.animate(withDuration: 0.3, animations: {
                self.scheduleRideView.scheduleRideView.transform = CGAffineTransform(scaleX: 1, y: 2)
                self.scheduleRideView.scheduleRideButtonView.frame.origin.y -= self.scheduleRideView.scheduleRideButtonView.frame.height * 3
                self.scheduleRideView.selectDateView.frame.origin.y -= self.scheduleRideView.selectDateView.frame.height * 3
            }) { (done) in
                self.scheduleRideView.datePicker.isHidden = false
            }
        }
    }
    
    func cancelRidePressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func didChangeDate() {
        self.scheduleRideView.requestButton.alpha = 1
        self.scheduleRideView.requestButton.isEnabled = true
    }
}

extension ScheduleRideViewController: AlertViewDelegate {
    func okayPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    
}
