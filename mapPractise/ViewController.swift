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
        
        doubleTap()
        
        addAnnotationForPlaces()
        
        
    }
    
    
    func addAnnotationForPlaces(){
        map.addAnnotations(places)
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

