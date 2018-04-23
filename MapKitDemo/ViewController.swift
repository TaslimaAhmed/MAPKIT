//
//  ViewController.swift
//  MapKitDemo
//
//  Created by Mobioapp on 12/19/17.
//  Copyright © 2017 Mobioapp. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController ,CLLocationManagerDelegate,MKMapViewDelegate{
    @IBOutlet weak var mapkit: MKMapView!
    var latitudeForCurrentLocation:Double=0.0
    var longitudeForCurrentLocation:Double=0.0
    var center=CLLocationCoordinate2D()
    var locationManagerForCurrentLocation=CLLocationManager()
    var currentLocation:CLLocation!
    var points = [CLLocationCoordinate2D]()
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureMap()
        getCurrentLocation()
       
    }
    func configureMap(){
        mapkit.delegate=self
        mapkit.mapType =  MKMapType.standard
        mapkit.isZoomEnabled=true
        mapkit.isScrollEnabled=true
        mapkit.showsUserLocation=true
        mapkit.center=view.center
        mapkit.isUserInteractionEnabled = true
        self.locationManagerForCurrentLocation.delegate=self
        locationManagerForCurrentLocation.desiredAccuracy=kCLLocationAccuracyBest
        locationManagerForCurrentLocation.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
        locationManagerForCurrentLocation.stopUpdatingLocation()
        }
        
        
    }
    
    func getCurrentLocation(){
        
        if CLLocationManager.locationServicesEnabled() {
            
            guard let lat = locationManagerForCurrentLocation.location?.coordinate.latitude else
            {
                return print("Fatal error")
                }
        
            let lng = locationManagerForCurrentLocation.location?.coordinate.longitude
            latitudeForCurrentLocation=lat
            longitudeForCurrentLocation=lng!
            print ("lat is:\(latitudeForCurrentLocation)and long is :\(longitudeForCurrentLocation)")
            points.append(CLLocationCoordinate2DMake(latitudeForCurrentLocation,longitudeForCurrentLocation))
             points.append(CLLocationCoordinate2DMake(latitudeForCurrentLocation,longitudeForCurrentLocation))
            let polyline = MKPolyline(coordinates:&points,count:points.count)
            mapkit.add(polyline)
            
            
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations[0] as CLLocation
        let center = CLLocationCoordinate2D(latitude:userLocation.coordinate.latitude,longitude:userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center:center, span:MKCoordinateSpan(latitudeDelta:0.01,longitudeDelta:0.01))
        mapkit.setRegion(region,animated:true)
        let myAnnotation:MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        myAnnotation.title = "current location"
        myAnnotation.subtitle = "location subtitle"
        mapkit.addAnnotation(myAnnotation)
        let myAnnotation2:MKPointAnnotation = MKPointAnnotation()
        myAnnotation2.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        myAnnotation2.title = "current location"
        myAnnotation2.subtitle = "location subtitle"
        mapkit.addAnnotation(myAnnotation2)
        

    
    }
    func locationManager(_manager:CLLocationManager, didFailWithError error:Error){
        print("Error \(error)")
    }
    
   
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }




}
