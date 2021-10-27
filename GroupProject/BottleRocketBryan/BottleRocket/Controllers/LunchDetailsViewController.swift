//
//  LunchDetailsViewController.swift
//  BottleRocket
//
//  Created by Bryan Lee on 10/21/21.
//

import MapKit
import UIKit

class LunchDetailsViewController: UIViewController {
    
    @IBOutlet private var map: MKMapView!
    @IBOutlet private var name: UILabel!
    @IBOutlet private var category: UILabel!
    @IBOutlet private var firstAddress: UILabel!
    @IBOutlet private var secondAddress: UILabel!
    @IBOutlet private var phone: UILabel!
    @IBOutlet private var twitter: UILabel!
    
    private var lat: Double?
    private var long: Double?
    
    static let identifier = String(describing: LunchDetailsViewController.self)
    static let storyboardID = "LunchDetails"
    
    var viewModel: LunchCellViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        updateUI()
        configureMap()
    }
    
    private func configureNavBar() {
        navigationItem.title = "Lunch Tyme"
//        self.navigationController?.navigationBar.topItem?.title = " "
        let backBarButtonItem = UIBarButtonItem(title: "You back button title here", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem


        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let mapButton = UIBarButtonItem(
            image: UIImage(named: "icon_map"),
            style: .plain,
            target: self,
            action: nil)
        mapButton.tintColor = UIColor.white
        
        navigationItem.rightBarButtonItem = mapButton
    }
    
    private func updateUI() {
        name.text = viewModel?.name
        category.text = viewModel?.category
        firstAddress.text = viewModel?.address
        secondAddress.text = viewModel?.addressEnding
        phone.text = viewModel?.phone
        twitter.text = viewModel?.twitter
        lat = viewModel?.lat
        long = viewModel?.long
    }
    
    private func configureMap() {
        let location = CLLocation(latitude: lat ?? 0.0, longitude: long ?? 0.0)
        map.centerToLocation(location)
        
        let lunch = MKPointAnnotation()
        lunch.title = viewModel?.name
        lunch.coordinate = CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: long ?? 0.0)
        map.addAnnotation(lunch)
    }
    
    private func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
    
}

private extension MKMapView {
    
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
