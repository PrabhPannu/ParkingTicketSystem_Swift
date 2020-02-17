//
//  LocationViewController.swift
//  ParkingTicketSystem_w2018iOS
//
//  Created by moxDroid on 2018-02-26.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

//https://www.latlong.net/
//https://www.raywenderlich.com/110054/routing-mapkit-core-location
//https://www.ioscreator.com/tutorials/draw-route-mapkit-tutorial
//https://www.hackingwithswift.com/example-code/location/how-to-find-directions-using-mkmapview-and-mkdirectionsrequest

class LocationViewController: UIViewController
{
    @IBOutlet weak var myMap: MKMapView!
    
    var locationSteps:[MKRouteStep] = []
    var currentLocation: CLLocation!
    let parkingSpotLocation = CLLocation(latitude: 43.773257, longitude: -79.335899)
    let regionRadius: CLLocationDistance = 1500
    var locationManager: CLLocationManager!
    var buttonNext:UIBarButtonItem!
    var totalDistance:String = "Distance"
     var totalTime:String = "Time"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.showStepButton()
        
        self.myMap.showsUserLocation = true
        self.myMap.isPitchEnabled = true
        self.myMap.isZoomEnabled = true
        self.myMap.isScrollEnabled = true
        self.myMap.delegate = self

        self.centerMapOnLocation(location: self.parkingSpotLocation)
        self.setMarkerOnMap(location: self.parkingSpotLocation, title: "Parking Ticket System", subTitle: "Toronto, ON, CA")
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
       
   
        //https://forums.developer.apple.com/thread/5841
        if CLLocationManager.locationServicesEnabled()
        {
             self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            //self.locationManager.startUpdatingLocation()
            self.locationManager.requestLocation()
        }
    }
    
    private func showStepButton()
    {
        self.buttonNext = UIBarButtonItem(title: "Route", style: UIBarButtonItemStyle.plain, target: self, action: #selector(LocationViewController.goToHome))
        
        self.navigationItem.rightBarButtonItem = buttonNext
    }
    
    
    @objc func goToHome() {
       
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let locationStepsVC = storyBoard.instantiateViewController(withIdentifier: "locationStepsVC") as! LocationStepsViewController
        locationStepsVC.steps = self.locationSteps
        locationStepsVC.totalDistanceString = totalDistance
        locationStepsVC.totalTimeString = totalTime
    self.navigationController?.pushViewController(locationStepsVC, animated: true)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func centerMapOnLocation(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        self.myMap.setRegion(coordinateRegion, animated: true)
    }
    
    private func setMarkerOnMap(location: CLLocation, title: String, subTitle: String)
    {
        // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        myAnnotation.title = title
        myAnnotation.subtitle = subTitle
        self.myMap.addAnnotation(myAnnotation)
    }

    @IBAction func btnChangeMapTypeClicked(_ sender: UIBarButtonItem)
    {
        switch sender.tag
        {
        case 0:
            self.myMap.mapType = MKMapType.standard
        case 1:
            self.myMap.mapType = MKMapType.satellite
        case 2:
            self.myMap.mapType = MKMapType.hybrid
        default:
            self.myMap.mapType = MKMapType.standard
        }
    }
    
    private func showDirectionAndPathOnMap()
    {
        //2
        let sourceLocation = CLLocationCoordinate2D(latitude: self.currentLocation.coordinate.latitude, longitude: self.currentLocation.coordinate.longitude
            )
        let destinationLocation = CLLocationCoordinate2D(latitude: self.parkingSpotLocation.coordinate.latitude, longitude: self.parkingSpotLocation.coordinate.longitude)
        //3
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        // 4.
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        // 5.
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Parking Tracking System"
        sourceAnnotation.subtitle = "Toronto, ON"
        
        if let location = sourcePlacemark.location
        {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "Current Location"
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        // 6.
    //self.mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        // 7.
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        // 8.
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                    self.showAlert(message: error.localizedDescription)
                }
                
                return
            }
            
            let route = response.routes[0]
            self.myMap.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.myMap.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
            
            self.totalDistance = "Distance: \(route.distance / 1000) km"
            self.totalTime = "Time: \(Utils.stringFromTimeInterval(interval: route.expectedTravelTime))"
            
            self.locationSteps = route.steps
            /*for s in route.steps
            {
                print(s.instructions)
            }
             */
        }
        
    }
    
    private func showAlert(message: String)
    {
        let alert = UIAlertController(title: "Error!!!",
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: NSLocalizedString("STR_OK", comment: ""),
                                     style: .destructive, handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
}

extension LocationViewController: MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
    {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.orange
        renderer.lineWidth = 4.0
        
        return renderer
    }
}

extension LocationViewController: CLLocationManagerDelegate
{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse
        {
            //self.myMap.showsUserLocation = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        print("New Location Found")
        self.currentLocation = locations[0]
        print(self.currentLocation)
        self.centerMapOnLocation(location: self.currentLocation)
        self.setMarkerOnMap(location: self.currentLocation, title: "Current", subTitle: "My Current Location")
        self.showDirectionAndPathOnMap()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error :\(error)")
        self.showAlert(message: error.localizedDescription)
    }
}
