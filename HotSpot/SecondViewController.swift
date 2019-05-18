//
//  SecondViewController.swift
//  HotSpot
//
//  Created by t-yokoda on 2019/05/15.
//  Copyright © 2019 t-yokoda. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: BaseViewController {
    
    @IBOutlet weak var photoViewButton: UIButton!
    
    @IBAction func photoViewButtonTap(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
    
    let myMapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myMapView.frame = self.view.frame
        self.view.addSubview(myMapView)
        self.view.sendSubviewToBack(myMapView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let myLocation = locations.last! as CLLocation
        currentLocation = myLocation.coordinate
        
        setLocation(myLocation: myLocation)
        
    }
    
    func setLocation(myLocation: CLLocation) {

        let currentLocation = myLocation.coordinate
        let pin = MKPointAnnotation()
        pin.coordinate = currentLocation
        pin.title = "現在地"
        self.myMapView.addAnnotation(pin)
        
        let mySpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let myRegion = MKCoordinateRegion(center: currentLocation, span: mySpan)
        myMapView.region = myRegion
    }

}

