//
//  ViewController.swift
//  PokeFinder
//
//  Created by Gavin Craft on 7/5/18.
//  Copyright © 2018 Gavin Craft. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var mapHasCeneteredOnce = false
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate=self
        mapView.userTrackingMode=MKUserTrackingMode.follow
        // Do any additional setup after loading the view, typically from a nib.
    }
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            mapView.showsUserLocation = true
        }else{
            locationManager.requestWhenInUseAuthorization()
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse{
            mapView.showsUserLocation=true
        }
    }
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters:2000, longitudinalMeters:2000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        if let loc = userLocation.location{
            if !mapHasCeneteredOnce{
                centerMapOnLocation(location: loc)
                mapHasCeneteredOnce = true
            }
        }
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annot: MKAnnotationView!
        if annotation.isKind(of: MKUserLocation.self){
            annot = MKAnnotationView(annotation: annotation, reuseIdentifier: "user")
            annot.image = UIImage(named: "ash")
        }
        return annot
    }
    override func viewDidAppear(_ animated: Bool) {
        locationAuthStatus()
    }

    @IBAction func spotPoke(_ sender: Any) {
    }
    

}

