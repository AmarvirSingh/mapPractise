//
//  ViewController.swift
//  mapPractise
//
//  Created by Amarvir Mac on 25/01/21.
//  Copyright © 2021 Amarvir Mac. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    let places = Place.getPlaces()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let latitude: CLLocationDegrees = 43.64
        let longitude:CLLocationDegrees = -79.38
        
        
        //displayLocation(latitude: latitude, longitude: longitude, title: "toronto", subTitle: "you are here")
        
        let dtg = UILongPressGestureRecognizer(target: self, action: #selector(doubleTapped))
        
        map.addGestureRecognizer(dtg)
        
        //doubleTap()
        
        addAnnotationForPlaces()
        
        map.delegate = self
        
        addPolyLine()
        
        
       
        
        
    }
    
    

    
    func addPolyLine(){
        let coordinate = places.map{
            $0.coordinate
        }
        let poly = MKPolyline(coordinates: coordinate, count: coordinate.count)
        map.addOverlay(poly)
    }
    
    
    func addAnnotationForPlaces(){
        map.addAnnotations(places)
        
        let overlay = places.map{
            MKCircle(center: $0.coordinate, radius: 3000)
        }
        map.addOverlays(overlay)
    }
    
    func removePin(){
        for anno in map.annotations{
            map.removeAnnotation(anno)
        }
    }
    
    
    
    func doubleTap(){
        
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(secondTap))
        
        doubleTap.numberOfTapsRequired = 2
        
        map.addGestureRecognizer(doubleTap)
        
    }
    
    @objc func secondTap(gesture:UITapGestureRecognizer){
        removePin()
        
        let touchPOint = gesture.location(in: map)
        let coordinate = map.convert(touchPOint, toCoordinateFrom: map)
        
        let annotation = MKPointAnnotation()
        annotation.title = "destination"
        annotation.coordinate = coordinate
        map.addAnnotation(annotation)
        
        
        
    }
    
    
    
    @objc func doubleTapped(gesture:UIGestureRecognizer){
        let touchPoint = gesture.location(in: map)
        
        let coordinate = map.convert(touchPoint, toCoordinateFrom: map)
        
        
        let annotation = MKPointAnnotation()
        
        annotation.title = "My Favorite"
        annotation.coordinate = coordinate
        map.addAnnotation(annotation)
    }
    
    
    func displayLocation(latitude: CLLocationDegrees,
                         longitude: CLLocationDegrees,
                         title:String,
                         subTitle:String){
        
        let latDelta:CLLocationDegrees = 0.05
        let longDelta:CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        
        
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        map.setRegion(region, animated: true)
        
        
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.subtitle = subTitle
        annotation.coordinate = location
        
        map.addAnnotation(annotation)
        
    }


}

extension ViewController:MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let rend = MKCircleRenderer(overlay: overlay)
            rend.fillColor = UIColor.blue.withAlphaComponent(0.5) // circle color
            rend.strokeColor = UIColor.blue // circle boundary color
            rend.lineWidth = 2  // line width
            return rend
        }else if overlay is MKPolyline{
            let rend = MKPolylineRenderer(overlay: overlay)
            rend.strokeColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            rend.lineWidth = 1
            return rend
        }
        return MKOverlayRenderer()
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pinIdentifier")
      
        pin.animatesDrop = true
        pin.pinTintColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        pin.canShowCallout = true
        pin.rightCalloutAccessoryView = UIButton(type: .infoDark)
        return pin
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let alert = UIAlertController(title: "title", message: " this is message ", preferredStyle: .alert)
        let cancelBtn = UIAlertAction(title: "cancelTitle", style: .cancel, handler: nil)
        alert.addAction(cancelBtn)
        present(alert, animated: true , completion: nil)
        
        
        
        
    }
}
