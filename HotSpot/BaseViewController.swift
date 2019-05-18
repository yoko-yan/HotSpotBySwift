//
//  BaseViewController.swift
//  HotSpot
//
//  Created by t-yokoda on 2019/05/18.
//  Copyright © 2019 t-yokoda. All rights reserved.
//

import UIKit
import CoreLocation
import CoreMotion

class BaseViewController: UIViewController, CLLocationManagerDelegate {

    let myLocationManager = CLLocationManager()
    
    var currentLocation: CLLocationCoordinate2D?
    
    let NUMBER_OF_HORIZONTAL_CELL_COUNT = 3.0
    let CELL_MARGIN = 1.0
    let EDGE_INSETS = UIEdgeInsets(top:0, left:0, bottom:0, right:0)
    
    var motionX = 0.0
    var motionY = 0.0
    var motionZ = 0.0
    
    var tab1flag = true
    var tab2flag = false
    
    let motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myLocationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.notDetermined {
            myLocationManager.requestAlwaysAuthorization()
        }
        myLocationManager.startUpdatingLocation()
        
        
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 1.0
            motionManager.startAccelerometerUpdates(
                to: OperationQueue.current!,
                withHandler: {(accelData: CMAccelerometerData?, errorOC: Error?) in
                    self.outputAccelData(acceleration: accelData!.acceleration)
            })
        }
    }
    
    func outputAccelData(acceleration: CMAcceleration){

        print(String(format: "X %06f", acceleration.x))
        print(String(format: "Y %06f", acceleration.y))
        print(String(format: "Z %06f", acceleration.z))
        
        if tab1flag && acceleration.x > 0.4 {
            self.tabBarController?.selectedIndex = 1
            tab1flag = false
            tab2flag = true
        } else
        if tab2flag && acceleration.x < -0.4 {
            self.tabBarController?.selectedIndex = 0
            tab1flag = true
            tab2flag = false
        }
        
        motionX = acceleration.x
        motionY = acceleration.y
        motionZ = acceleration.z
        
    }
    
    func stopAccelerometer(){
        if (motionManager.isAccelerometerActive) {
            motionManager.stopAccelerometerUpdates()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let myLocation = locations.last! as CLLocation
        currentLocation = myLocation.coordinate
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        var statusStr = ""
        switch (status) {
        case .notDetermined:
            statusStr = "NotDetermined"
        case .restricted:
            statusStr = "Restricted"
        case .denied:
            statusStr = "Denied"
        case .authorizedAlways:
            statusStr = "AuthorizedAlways"
        case .authorizedWhenInUse:
            statusStr = "AuthorizedWhenInUse"
        }
        print(" CLAuthorizationStatus: \(statusStr)")
        
    }

}
